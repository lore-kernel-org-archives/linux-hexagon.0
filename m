From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 36/51] cpuidle,omap3: Use WFI for omap3_pm_idle()
Date: Thu, 12 Jan 2023 20:43:50 +0100
Message-ID: <20230112195541.538053457@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KLAmYUkc5o4iaLgWEzyq0DD4W34Vw8wzkDDZ9nw8rNA=; b=ATY8kiKnvovNgLEm6qSQ1EQvbq
        whhVrHfsY0Boal85ZRoFmxTUxBK5B9bIvgSX8kVgT6BcX1L66jwQCdPl/BWOSqcQGl2XmwgaBL4PW
        OKdsLfeNG0cKIyK4qLBg5dTibPOilkbVEo3W2vYUVl/MzGrlgC59H1LNDjakisaklXFACDQXCVqgH
        X3HA2n0rfn3BN7gYs5ZEmCkrHIhhMF7I5lLP2nRilVRm9iYl7qlU43ypHe2kjKrxVavesmViWu98M
        YhMWMygFonCR9p+h3EzH9ve+5v/3v/1iCRvb+1bzQnO8SY3rlhjeY9n904kFy8Lg9quCma5so/ETV
        SIrS144Q==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au

arch_cpu_idle() is a very simple idle interface and exposes only a
single idle state and is expected to not require RCU and not do any
tracing/instrumentation.

As such, omap_sram_idle() is not a valid implementation. Replace it
with the simple (shallow) omap3_do_wfi() call. Leaving the more
complicated idle states for the cpuidle driver.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -294,7 +294,7 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
-	omap_sram_idle();
+	omap3_do_wfi();
 }
 
 #ifdef CONFIG_SUSPEND


