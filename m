From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 15/44] acpi_idle: Remove tracing
Date: Mon, 19 Sep 2022 11:59:54 +0200
Message-ID: <20220919101521.340781451@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Return-path: <linux-clk-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2qey3zLroBQku0zom/Uqdc2w/ejv7qE6fMvFqUVfz0c=; b=RlUJ2AwCdpPblbfQP0YMvc7OXS
        vypLks6wgtcgloMSsvVlfS4RXNb3cZ0pXhJNi4ixKXVkWOTr0JWkhccmDyvtgo89daT6S3vWq6fz5
        VJzntwGG+I/tKhwN1gXnU10VZf6Y2oBh+TZtCcBfNHoWSvo7CdW+wkU/J6FYAtOuMh9cU+iZfzo32
        ueJIGOFL/qwA0/Lhvytsoucamxio8Km/dW5jH6jiWy13xWNatkE4MBjgvPPYAw+ddArxtKXq3YvaG
        gF3XSzXuFVmf4E8UBdDETDVhHmKRxQcPulKjX3yVJj2EwPrVOE6EJWXDWrwQYGJN3PgMWDcDgEXt3
        DLPFGGag==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

All the idle routines are called with RCU disabled, as such there must
not be any tracing inside.

While there; clean-up the io-port idle thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/acpi/processor_idle.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -108,8 +108,8 @@ static const struct dmi_system_id proces
 static void __cpuidle acpi_safe_halt(void)
 {
 	if (!tif_need_resched()) {
-		safe_halt();
-		local_irq_disable();
+		raw_safe_halt();
+		raw_local_irq_disable();
 	}
 }
 
@@ -524,16 +524,21 @@ static int acpi_idle_bm_check(void)
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
 		return;
 #endif
-	/* Dummy wait op - must do something useless after P_LVL2 read
-	   because chipsets cannot guarantee that STPCLK# signal
-	   gets asserted in time to freeze execution properly. */
+	/*
+	 * Dummy wait op - must do something useless after P_LVL2 read
+	 * because chipsets cannot guarantee that STPCLK# signal
+	 * gets asserted in time to freeze execution properly.
+	 */
 	inl(acpi_gbl_FADT.xpm_timer_block.address);
 }
 
@@ -553,9 +558,7 @@ static void __cpuidle acpi_idle_do_entry
 	} else if (cx->entry_method == ACPI_CSTATE_HALT) {
 		acpi_safe_halt();
 	} else {
-		/* IO port based C-state */
-		inb(cx->address);
-		wait_for_freeze();
+		io_idle(cx->address);
 	}
 
 	perf_lopwr_cb(false);
@@ -577,8 +580,7 @@ static int acpi_idle_play_dead(struct cp
 		if (cx->entry_method == ACPI_CSTATE_HALT)
 			safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
-			inb(cx->address);
-			wait_for_freeze();
+			io_idle(cx->address);
 		} else
 			return -ENODEV;
 


