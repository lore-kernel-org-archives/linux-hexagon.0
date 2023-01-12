From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 06/51] cpuidle,tegra: Push RCU-idle into driver
Date: Thu, 12 Jan 2023 20:43:20 +0100
Message-ID: <20230112195539.699546331@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Z3KKcWa6kIo8XxnBPrwezUQgJ6x9WmWZQX/flafg2tU=; b=PpHISELXEmnMHJvLFAt16OXB0d
        DPSGScXaLcWEZ28c+crVEelhP+2NctCyeJdqyEH14VNT937QvaCtPAT1SUKwrARUTyZZPN/9eNb0N
        uBYDeE24g3byzsfh/5Ct6sdoJZUVTepI+8uCWJIEqNlajiNKddekUu7U1Xb+Li3UjgEkSYGgSw1bo
        EcmAdpfUVjMr1DpMmSS9iZVU8P2OoWNhWBj+ZOzWdPEE0bEMxVs96sP0ZCKBSQ6IhlV36k/oZtssk
        ImqoJMqVIwHxbSBtzvjC0yQnFNZYX6rGb5Gd1lIRsPHN44o/4fikx4Sq60jL3JDvn5ueQX8YywLDn
        WavqFquQ==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au

Doing RCU-idle outside the driver, only to then temporarily enable it
again, at least twice, before going idle is daft.

Notably once implicitly through the cpu_pm_*() calls and once
explicitly doing RCU_NONIDLE().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-tegra.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -180,9 +180,11 @@ static int tegra_cpuidle_state_enter(str
 	}
 
 	local_fiq_disable();
-	RCU_NONIDLE(tegra_pm_set_cpu_in_lp2());
+	tegra_pm_set_cpu_in_lp2();
 	cpu_pm_enter();
 
+	ct_idle_enter();
+
 	switch (index) {
 	case TEGRA_C7:
 		err = tegra_cpuidle_c7_enter();
@@ -197,8 +199,10 @@ static int tegra_cpuidle_state_enter(str
 		break;
 	}
 
+	ct_idle_exit();
+
 	cpu_pm_exit();
-	RCU_NONIDLE(tegra_pm_clear_cpu_in_lp2());
+	tegra_pm_clear_cpu_in_lp2();
 	local_fiq_enable();
 
 	return err ?: index;
@@ -226,6 +230,7 @@ static int tegra_cpuidle_enter(struct cp
 			       struct cpuidle_driver *drv,
 			       int index)
 {
+	bool do_rcu = drv->states[index].flags & CPUIDLE_FLAG_RCU_IDLE;
 	unsigned int cpu = cpu_logical_map(dev->cpu);
 	int ret;
 
@@ -233,9 +238,13 @@ static int tegra_cpuidle_enter(struct cp
 	if (dev->states_usage[index].disable)
 		return -1;
 
-	if (index == TEGRA_C1)
+	if (index == TEGRA_C1) {
+		if (do_rcu)
+			ct_idle_enter();
 		ret = arm_cpuidle_simple_enter(dev, drv, index);
-	else
+		if (do_rcu)
+			ct_idle_exit();
+	} else
 		ret = tegra_cpuidle_state_enter(dev, index, cpu);
 
 	if (ret < 0) {
@@ -285,7 +294,8 @@ static struct cpuidle_driver tegra_idle_
 			.exit_latency		= 2000,
 			.target_residency	= 2200,
 			.power_usage		= 100,
-			.flags			= CPUIDLE_FLAG_TIMER_STOP,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP |
+						  CPUIDLE_FLAG_RCU_IDLE,
 			.name			= "C7",
 			.desc			= "CPU core powered off",
 		},
@@ -295,6 +305,7 @@ static struct cpuidle_driver tegra_idle_
 			.target_residency	= 10000,
 			.power_usage		= 0,
 			.flags			= CPUIDLE_FLAG_TIMER_STOP |
+						  CPUIDLE_FLAG_RCU_IDLE   |
 						  CPUIDLE_FLAG_COUPLED,
 			.name			= "CC6",
 			.desc			= "CPU cluster powered off",


