From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 12/36] cpuidle,omap2: Push RCU-idle into driver
Date: Wed, 08 Jun 2022 16:27:35 +0200
Message-ID: <20220608144516.677524509@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=KHvAe13dC0TrHBuyrT47ebjbzLfzhz60TYCCkk8vbtw=; b=itZGmiVK2icgGpaxEUa4cF4lIi
 +0YlKT5EyDMJU/MWxEIYXD0gdpmN61uIirZw23P88WQR972g9551F5GQf2PqyIZiGqSM7Xb3E9Bfo
 5FJC2KAaPRvPAyYdtPgdvQXWbuqPmfD46eyn+WecUdijp92GxIoao/oz7pLSvWG+zLdB395Gr6udf
 SnHkd2/tnr0TU6wUvVXi0bK4I9GCbQFvJd8NnUWdzoAGBSqxHc+lDSifdza+NoDEIQlsu/cUajh/n
 135EoBmasvrh3QQ0nBdIwhHcrUsDu7hkMdqwZ9EbvT5fVJqK+jxBGdYTIkn8tf2ChYh88coEYmRqG
 IpB+K9xg==;
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: peterz@infradead.org
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, paul

Doing RCU-idle outside the driver, only to then temporarily enable it
again, some *four* times, before going idle is daft.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -105,7 +105,9 @@ static int omap_enter_idle_smp(struct cp
 	}
 	raw_spin_unlock_irqrestore(&mpu_lock, flag);
 
+	rcu_idle_enter();
 	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+	rcu_idle_exit();
 
 	raw_spin_lock_irqsave(&mpu_lock, flag);
 	if (cx->mpu_state_vote == num_online_cpus())
@@ -151,10 +153,10 @@ static int omap_enter_idle_coupled(struc
 				 (cx->mpu_logic_state == PWRDM_POWER_OFF);
 
 	/* Enter broadcast mode for periodic timers */
-	RCU_NONIDLE(tick_broadcast_enable());
+	tick_broadcast_enable();
 
 	/* Enter broadcast mode for one-shot timers */
-	RCU_NONIDLE(tick_broadcast_enter());
+	tick_broadcast_enter();
 
 	/*
 	 * Call idle CPU PM enter notifier chain so that
@@ -166,7 +168,7 @@ static int omap_enter_idle_coupled(struc
 
 	if (dev->cpu == 0) {
 		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
-		RCU_NONIDLE(omap_set_pwrdm_state(mpu_pd, cx->mpu_state));
+		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
 
 		/*
 		 * Call idle CPU cluster PM enter notifier chain
@@ -178,14 +180,16 @@ static int omap_enter_idle_coupled(struc
 				index = 0;
 				cx = state_ptr + index;
 				pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
-				RCU_NONIDLE(omap_set_pwrdm_state(mpu_pd, cx->mpu_state));
+				omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
 				mpuss_can_lose_context = 0;
 			}
 		}
 	}
 
+	rcu_idle_enter();
 	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
 	cpu_done[dev->cpu] = true;
+	rcu_idle_exit();
 
 	/* Wakeup CPU1 only if it is not offlined */
 	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
@@ -194,9 +198,9 @@ static int omap_enter_idle_coupled(struc
 		    mpuss_can_lose_context)
 			gic_dist_disable();
 
-		RCU_NONIDLE(clkdm_deny_idle(cpu_clkdm[1]));
-		RCU_NONIDLE(omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON));
-		RCU_NONIDLE(clkdm_allow_idle(cpu_clkdm[1]));
+		clkdm_deny_idle(cpu_clkdm[1]);
+		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
+		clkdm_allow_idle(cpu_clkdm[1]);
 
 		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD) &&
 		    mpuss_can_lose_context) {
@@ -222,7 +226,7 @@ static int omap_enter_idle_coupled(struc
 	cpu_pm_exit();
 
 cpu_pm_out:
-	RCU_NONIDLE(tick_broadcast_exit());
+	tick_broadcast_exit();
 
 fail:
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
@@ -247,7 +251,8 @@ static struct cpuidle_driver omap4_idle_
 			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
 			.exit_latency = 328 + 440,
 			.target_residency = 960,
-			.flags = CPUIDLE_FLAG_COUPLED,
+			.flags = CPUIDLE_FLAG_COUPLED |
+				 CPUIDLE_FLAG_RCU_IDLE,
 			.enter = omap_enter_idle_coupled,
 			.name = "C2",
 			.desc = "CPUx OFF, MPUSS CSWR",
@@ -256,7 +261,8 @@ static struct cpuidle_driver omap4_idle_
 			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
 			.exit_latency = 460 + 518,
 			.target_residency = 1100,
-			.flags = CPUIDLE_FLAG_COUPLED,
+			.flags = CPUIDLE_FLAG_COUPLED |
+				 CPUIDLE_FLAG_RCU_IDLE,
 			.enter = omap_enter_idle_coupled,
 			.name = "C3",
 			.desc = "CPUx OFF, MPUSS OSWR",
@@ -282,7 +288,8 @@ static struct cpuidle_driver omap5_idle_
 			/* C2 - CPU0 RET + CPU1 RET + MPU CSWR */
 			.exit_latency = 48 + 60,
 			.target_residency = 100,
-			.flags = CPUIDLE_FLAG_TIMER_STOP,
+			.flags = CPUIDLE_FLAG_TIMER_STOP |
+				 CPUIDLE_FLAG_RCU_IDLE,
 			.enter = omap_enter_idle_smp,
 			.name = "C2",
 			.desc = "CPUx CSWR, MPUSS CSWR",
