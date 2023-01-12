From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 38/51] cpuidle,omap4: Push RCU-idle into omap4_enter_lowpower()
Date: Thu, 12 Jan 2023 20:43:52 +0100
Message-ID: <20230112195541.660272394@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ChWtbTrciVV3G1vvtlVpdXBjaP89UEdojcC0eA3JIzQ=; b=J5s1H3wJuyV1ZrYX35oWuMFT6u
        T7rkONaA7mOhYkZTPvPq7xCUfh89Ra86y5u0xgauRwd+PDKaMYpqa7ySs0cD65BuP9TlSYfchNae9
        rHo3fB2jWIjes9nzkMjRdOry4NCkFwJa4nFQ3iESRw0ldiDaahTuRrbz/u4fOwdkQ7dPd1ZOukRfa
        ietaYuJhWetE6Rm/+Hjq8TYl+1zO/sGKsYAlND/4FsyKOfe/afpWWY3jSLNYcDyycmwWD5UQgOUAw
        72qyauSQ5/8uDhzNtIN7j0cH7dMgtkVOtlqBUgLK/A0s3w8n28e1SaeQPCCMocxdiXwUDMbXXdabs
        xHfJPjOA==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au

From: Tony Lindgren <tony@atomide.com>

OMAP4 uses full SoC suspend modes as idle states, as such it needs the
whole power-domain and clock-domain code from the idle path.

All that code is not suitable to run with RCU disabled, as such push
RCU-idle deeper still.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lkml.kernel.org/r/Yqcv6crSNKuSWoTu@atomide.com
---
 arch/arm/mach-omap2/common.h              |    6 ++++--
 arch/arm/mach-omap2/cpuidle44xx.c         |    8 ++------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   12 +++++++++++-
 arch/arm/mach-omap2/pm44xx.c              |    2 +-
 4 files changed, 18 insertions(+), 10 deletions(-)

--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -284,11 +284,13 @@ extern u32 omap4_get_cpu1_ns_pa_addr(voi
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
 extern int omap4_mpuss_init(void);
-extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
+extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
+				bool rcuidle);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
-					unsigned int power_state)
+					unsigned int power_state,
+					bool rcuidle)
 {
 	cpu_do_idle();
 	return 0;
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -105,9 +105,7 @@ static int omap_enter_idle_smp(struct cp
 	}
 	raw_spin_unlock_irqrestore(&mpu_lock, flag);
 
-	ct_cpuidle_enter();
-	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
-	ct_cpuidle_exit();
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state, true);
 
 	raw_spin_lock_irqsave(&mpu_lock, flag);
 	if (cx->mpu_state_vote == num_online_cpus())
@@ -186,10 +184,8 @@ static int omap_enter_idle_coupled(struc
 		}
 	}
 
-	ct_cpuidle_enter();
-	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state, true);
 	cpu_done[dev->cpu] = true;
-	ct_cpuidle_exit();
 
 	/* Wakeup CPU1 only if it is not offlined */
 	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -33,6 +33,7 @@
  * and first to wake-up when MPUSS low power states are excercised
  */
 
+#include <linux/cpuidle.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/errno.h>
@@ -214,6 +215,7 @@ static void __init save_l2x0_context(voi
  * of OMAP4 MPUSS subsystem
  * @cpu : CPU ID
  * @power_state: Low power state.
+ * @rcuidle: RCU needs to be idled
  *
  * MPUSS states for the context save:
  * save_state =
@@ -222,7 +224,8 @@ static void __init save_l2x0_context(voi
  *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
  *	3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
  */
-int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
+int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
+			 bool rcuidle)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int save_state = 0, cpu_logic_state = PWRDM_POWER_RET;
@@ -268,6 +271,10 @@ int omap4_enter_lowpower(unsigned int cp
 	cpu_clear_prev_logic_pwrst(cpu);
 	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
 	pwrdm_set_logic_retst(pm_info->pwrdm, cpu_logic_state);
+
+	if (rcuidle)
+		ct_cpuidle_enter();
+
 	set_cpu_wakeup_addr(cpu, __pa_symbol(omap_pm_ops.resume));
 	omap_pm_ops.scu_prepare(cpu, power_state);
 	l2x0_pwrst_prepare(cpu, save_state);
@@ -283,6 +290,9 @@ int omap4_enter_lowpower(unsigned int cp
 	if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD) && cpu)
 		gic_dist_enable();
 
+	if (rcuidle)
+		ct_cpuidle_exit();
+
 	/*
 	 * Restore the CPUx power state to ON otherwise CPUx
 	 * power domain can transitions to programmed low power
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -76,7 +76,7 @@ static int omap4_pm_suspend(void)
 	 * domain CSWR is not supported by hardware.
 	 * More details can be found in OMAP4430 TRM section 4.3.4.2.
 	 */
-	omap4_enter_lowpower(cpu_id, cpu_suspend_state);
+	omap4_enter_lowpower(cpu_id, cpu_suspend_state, false);
 
 	/* Restore next powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {


