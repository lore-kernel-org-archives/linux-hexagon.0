From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 24/51] arm64,smp: Remove trace_.*_rcuidle() usage
Date: Thu, 12 Jan 2023 20:43:38 +0100
Message-ID: <20230112195540.804410487@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=H++Izq9gHCigzm3jyfqVQx/OXXHHURXAPu4rHKpriQs=; b=YePyvi42dN2KCMqq+7e1S609eb
        WFxHWtO/jgyjZzxARHvRjE2QrtZo1Ma5mkqruZXU5/PO7FUvyR8sUawTrYfaBeVEfspiuaIFkKVMc
        fyMuNWmG8G5expNMvK0etyhW9olX8plthocE0oVEpGxCtTn6UmUf8Ek1AzD8jqegIKasUbqvSUmau
        3vbOWKtb6/qLR7kaj8lgimVeDrMvfjUeqa93YM+gDqx28KwMHAgMewjhNVOm9uQNY0kOI6Nucsz6S
        xTgwD42zZEFhgWLXGdgI1gSnPYNpoj0eZ2X3XkoE4AXqCgGkP9dJYVs+mDKvgVqwc5CylK2jrIKRn
        P/TbqzeQ==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au

Ever since commit d3afc7f12987 ("arm64: Allow IPIs to be handled as
normal interrupts") this function is called in regular IRQ context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/kernel/smp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -865,7 +865,7 @@ static void do_handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
+		trace_ipi_entry(ipi_types[ipinr]);
 
 	switch (ipinr) {
 	case IPI_RESCHEDULE:
@@ -914,7 +914,7 @@ static void do_handle_IPI(int ipinr)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+		trace_ipi_exit(ipi_types[ipinr]);
 }
 
 static irqreturn_t ipi_handler(int irq, void *data)


