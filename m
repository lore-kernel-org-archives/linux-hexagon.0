From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 13/36] cpuidle,dt: Push RCU-idle into driver
Date: Wed, 08 Jun 2022 16:27:36 +0200
Message-ID: <20220608144516.743744529@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ou5L3Xuucqh3BNNcA7ggTsb03AZP3YIS722c+bYuzBQ=; b=BlrojMz/WbhW29sFV97MzV8OkQ
        RbPl1tJnHXIxdvTZTXTAPTmSz82CraWzijvfQReGUaxdfpAVsIqf9Bb7I3yG0HKOfVEo+V/hsP2Tv
        xAP72un6N9viz+BOTJqpO3xb9FBcnrwXu0Gqj13RaQnBFwYVICpLsQ8t1YVJW3yIqgPUGxlKeZQQa
        wm9PfHjlB6b5hxLvDrFrmSoKqCA8FrBYK4ijrnoK9S26gtG5d7JvNQgnB3qFhJdY6O5LRL7OKQml2
        wR/6W03N4QPRSI/uLHemk8EACeFDyHzTzxsOWMn7vQaYtoNYqZ8KVlqIi2qkvjgfrO7eQCRMWk3/x
        gAoOvSaw==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Doing RCU-idle outside the driver, only to then temporarily enable it
again before going idle is daft.

Notably: this converts all dt_init_idle_driver() and
__CPU_PM_CPU_IDLE_ENTER() users for they are inextrably intertwined.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c    |    4 ++--
 drivers/acpi/processor_idle.c        |    2 ++
 drivers/cpuidle/cpuidle-arm.c        |    1 +
 drivers/cpuidle/cpuidle-big_little.c |    8 ++++++--
 drivers/cpuidle/cpuidle-psci.c       |    1 +
 drivers/cpuidle/cpuidle-qcom-spm.c   |    1 +
 drivers/cpuidle/cpuidle-riscv-sbi.c  |    1 +
 drivers/cpuidle/dt_idle_states.c     |    2 +-
 include/linux/cpuidle.h              |    4 ++++
 9 files changed, 19 insertions(+), 5 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
 		state->target_residency = lpi->min_residency;
 		if (lpi->arch_flags)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+		if (lpi->entry_method == ACPI_CSTATE_FFH)
+			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
 		state->enter = acpi_idle_lpi_enter;
 		drv->safe_state_index = i;
 	}
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
 	 * handler for idle state index 0.
 	 */
 	.states[0] = {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter                  = arm_enter_idle_state,
 		.exit_latency           = 1,
 		.target_residency       = 1,
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -64,7 +64,8 @@ static struct cpuidle_driver bl_idle_lit
 		.enter			= bl_enter_powerdown,
 		.exit_latency		= 700,
 		.target_residency	= 2500,
-		.flags			= CPUIDLE_FLAG_TIMER_STOP,
+		.flags			= CPUIDLE_FLAG_TIMER_STOP |
+					  CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "C1",
 		.desc			= "ARM little-cluster power down",
 	},
@@ -85,7 +86,8 @@ static struct cpuidle_driver bl_idle_big
 		.enter			= bl_enter_powerdown,
 		.exit_latency		= 500,
 		.target_residency	= 2000,
-		.flags			= CPUIDLE_FLAG_TIMER_STOP,
+		.flags			= CPUIDLE_FLAG_TIMER_STOP |
+					  CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "C1",
 		.desc			= "ARM big-cluster power down",
 	},
@@ -124,11 +126,13 @@ static int bl_enter_powerdown(struct cpu
 				struct cpuidle_driver *drv, int idx)
 {
 	cpu_pm_enter();
+	rcu_idle_enter();
 
 	cpu_suspend(0, bl_powerdown_finisher);
 
 	/* signals the MCPM core that CPU is out of low power state */
 	mcpm_cpu_powered_up();
+	rcu_idle_exit();
 
 	cpu_pm_exit();
 
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -357,6 +357,7 @@ static int psci_idle_init_cpu(struct dev
 	 * PSCI idle states relies on architectural WFI to be represented as
 	 * state index 0.
 	 */
+	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[0].enter = psci_enter_idle_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -72,6 +72,7 @@ static struct cpuidle_driver qcom_spm_id
 	.owner = THIS_MODULE,
 	.states[0] = {
 		.enter			= spm_enter_idle_state,
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.exit_latency		= 1,
 		.target_residency	= 1,
 		.power_usage		= UINT_MAX,
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -332,6 +332,7 @@ static int sbi_cpuidle_init_cpu(struct d
 	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
 
 	/* RISC-V architectural WFI to be represented as state index 0. */
+	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[0].enter = sbi_cpuidle_enter_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -77,7 +77,7 @@ static int init_state_node(struct cpuidl
 	if (err)
 		desc = state_node->name;
 
-	idle_state->flags = 0;
+	idle_state->flags = CPUIDLE_FLAG_RCU_IDLE;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 	/*
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
 	int __ret = 0;							\
 									\
 	if (!idx) {							\
+		rcu_idle_enter();					\
 		cpu_do_idle();						\
+		rcu_idle_exit();					\
 		return idx;						\
 	}								\
 									\
 	if (!is_retention)						\
 		__ret =  cpu_pm_enter();				\
 	if (!__ret) {							\
+		rcu_idle_enter();					\
 		__ret = low_level_idle_enter(state);			\
+		rcu_idle_exit();					\
 		if (!is_retention)					\
 			cpu_pm_exit();					\
 	}								\


