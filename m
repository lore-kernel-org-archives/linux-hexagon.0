From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 34.5/36] cpuidle,omap4: Push RCU-idle into
 omap4_enter_lowpower()
Date: Wed, 15 Jun 2022 00:12:06 +0200
Message-ID: <YqkHto+zgAPs4kQI@worktop.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.073801916@infradead.org>
 <Yqcv6crSNKuSWoTu@atomide.com>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ieYeEcrodnP9d8uMI6KazQ9YDccjAyjy/+PGF5Ov/Sc=; b=OliYmJSibamFQ0oRl2XkG2+oLG
        eUVxb3PF2WQS3d9O+63gY5P/Th5g3W0k/p07zjSFtfSstgpe5sY3UKPuYKK8U3d61xav16z47xA5h
        tkNVX1vBm9t+GM0XpJtkUArdAr+6C0D6QPwa3LyJL5W3wePUH4pa4u9UPo+aiZ0VxHDbCXoe4qfJ4
        E8Y2M6s9A8SopwISJUuliIWAcL2CXospZ4jCBSi0ba1Zs/HL4wyLHhGRHBuILPFIW3paG1eAzYhHw
        AXd8m8CPomKQfchnKb7uAGftq4wK1SsdTGzKQsjqacjeCk0RsPVRrEJUUy3okfnQk1gM5l81agP/h
        arzWLEHQ==;
Content-Disposition: inline
In-Reply-To: <Yqcv6crSNKuSWoTu@atomide.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@l

On Mon, Jun 13, 2022 at 03:39:05PM +0300, Tony Lindgren wrote:
> OMAP4 uses full SoC suspend modes as idle states, as such it needs the
> whole power-domain and clock-domain code from the idle path.
> 
> All that code is not suitable to run with RCU disabled, as such push
> RCU-idle deeper still.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Peter here's one more for your series, looks like this is needed to avoid
> warnings similar to what you did for omap3.

Thanks Tony!

I've had a brief look at omap2_pm_idle() and do I understand it right
that something like the below patch would reduce it to a simple 'WFI'?

What do I do with the rest of that code, because I don't think this
thing has a cpuidle driver to take over, effectively turning it into
dead code.

--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -126,10 +126,20 @@ static int omap2_allow_mpu_retention(voi
 	return 1;
 }
 
-static void omap2_enter_mpu_retention(void)
+static void omap2_do_wfi(void)
 {
 	const int zero = 0;
 
+	/* WFI */
+	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
+}
+
+#if 0
+/*
+ * possible cpuidle implementation between WFI and full_retention above
+ */
+static void omap2_enter_mpu_retention(void)
+{
 	/* The peripherals seem not to be able to wake up the MPU when
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {
@@ -146,8 +157,7 @@ static void omap2_enter_mpu_retention(vo
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 	}
 
-	/* WFI */
-	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
+	omap2_do_wfi();
 
 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 }
@@ -161,6 +171,7 @@ static int omap2_can_sleep(void)
 
 	return 1;
 }
+#endif
 
 static void omap2_pm_idle(void)
 {
@@ -169,6 +180,7 @@ static void omap2_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
+#if 0
 	error = cpu_cluster_pm_enter();
 	if (error || !omap2_can_sleep()) {
 		omap2_enter_mpu_retention();
@@ -179,6 +191,9 @@ static void omap2_pm_idle(void)
 
 out_cpu_cluster_pm:
 	cpu_cluster_pm_exit();
+#else
+	omap2_do_wfi();
+#endif
 }
 
 static void __init prcm_setup_regs(void)
