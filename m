From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 15/51] acpi_idle: Remove tracing
Date: Thu, 12 Jan 2023 20:43:29 +0100
Message-ID: <20230112195540.251666856@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=N/LoJ6QokuvkgqrdUyeUyAC9uk5r3NGpRlHTjN0UEk8=; b=T8OnHc73dEliAoWK/xch6i2J7U
        UMPcH7C3wey9SZCz29M3TnVGeV/W9jC6hfvxLiKRMqnquFKPM6nid5EbmG5dczPvuD2DZ3rsJb8bh
        1B5YEftBb1n98ERVSHO05+IatfdS4u87KvvQGiPoj8rifuEdsA4srZC4wIENwPRAVZsXaUzY4luW4
        Zenh892eKzf2pgbhojQV6wJdtmIWgpRiTZY36OvBCfqI5tc8YiwERNFtaxcfar59LGMt3V5FwEWxd
        1IYeXc/xNHpxnwh58Sqsesvu7xJ/zUZBM+XUWlSRPervhZPQ3w6Fk9QTn2mJpsRI+pQDUPSrD9z7J
        4u6HFEyw==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au

All the idle routines are called with RCU disabled, as such there must
not be any tracing inside.

While there; clean-up the io-port idle thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/processor_idle.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -109,8 +109,8 @@ static const struct dmi_system_id proces
 static void __cpuidle acpi_safe_halt(void)
 {
 	if (!tif_need_resched()) {
-		safe_halt();
-		local_irq_disable();
+		raw_safe_halt();
+		raw_local_irq_disable();
 	}
 }
 
@@ -525,8 +525,11 @@ static int acpi_idle_bm_check(void)
 	return bm_status;
 }
 
-static void wait_for_freeze(void)
+static __cpuidle void io_idle(unsigned long addr)
 {
+	/* IO port based C-state */
+	inb(addr);
+
 #ifdef	CONFIG_X86
 	/* No delay is needed if we are in guest */
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
@@ -571,9 +574,7 @@ static void __cpuidle acpi_idle_do_entry
 	} else if (cx->entry_method == ACPI_CSTATE_HALT) {
 		acpi_safe_halt();
 	} else {
-		/* IO port based C-state */
-		inb(cx->address);
-		wait_for_freeze();
+		io_idle(cx->address);
 	}
 
 	perf_lopwr_cb(false);
@@ -595,8 +596,7 @@ static int acpi_idle_play_dead(struct cp
 		if (cx->entry_method == ACPI_CSTATE_HALT)
 			safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
-			inb(cx->address);
-			wait_for_freeze();
+			io_idle(cx->address);
 		} else
 			return -ENODEV;
 


