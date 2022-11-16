From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 12/44] cpuidle,dt: Push RCU-idle into driver
Date: Wed, 16 Nov 2022 16:29:05 +0100
Message-ID: <Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101521.139727471@infradead.org>
 <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4XDB6ZbR3Awa7mOslon9xFqMWj0psrdiARhozQeRyJA=; b=gYnS7fY4SiIk8LhruYi5TSnTVA
        fStgfkd5Z/zbz8yQZBnmnhyWOOmhlrhRObDB9G2KJoco51LBuhZxVkVxbSBrTCQ/HtHWliung+7ZZ
        HbZe3Froz8dQdsOphMI16X4jllstvINRTH3i5h+4adnzIV8bwm2odcxdw/4ACLq7NTIENgyfmZxmW
        flqbgkCx8yOd3LgZHd01MR5R1P5lI3CSROlGEycIvrRPVhabpLUb0rptouTmOLEERLT81z+aE6Z4G
        +eccUWkk2tCLQB+FJ0eM8fcpEENqemtpoKisOMtzDEaLdPH2PhfiSrDXw+vDx7DBnwdyTpMo06laG
        hxV51fpA==;
Content-Disposition: inline
In-Reply-To: <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.or


Sorry; things keep getting in the way of finishing this :/

As such, I need a bit of time to get on-track again..

On Tue, Oct 04, 2022 at 01:03:57PM +0200, Ulf Hansson wrote:

> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
> >                 state->target_residency = lpi->min_residency;
> >                 if (lpi->arch_flags)
> >                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > +               if (lpi->entry_method == ACPI_CSTATE_FFH)
> > +                       state->flags |= CPUIDLE_FLAG_RCU_IDLE;
> 
> I assume the state index here will never be 0?
> 
> If not, it may lead to that acpi_processor_ffh_lpi_enter() may trigger
> CPU_PM_CPU_IDLE_ENTER_PARAM() to call ct_cpuidle_enter|exit() for an
> idle-state that doesn't have the CPUIDLE_FLAG_RCU_IDLE bit set.

I'm not quite sure I see how. AFAICT this condition above implies
acpi_processor_ffh_lpi_enter() gets called, no?

Which in turn is an unconditional __CPU_PM_CPU_IDLE_ENTER() user, so
even if idx==0, it ends up in ct_idle_{enter,exit}().

> 
> >                 state->enter = acpi_idle_lpi_enter;
> >                 drv->safe_state_index = i;
> >         }
> > --- a/drivers/cpuidle/cpuidle-arm.c
> > +++ b/drivers/cpuidle/cpuidle-arm.c
> > @@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
> >          * handler for idle state index 0.
> >          */
> >         .states[0] = {
> > +               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> 
> Comparing arm64 and arm32 idle-states/idle-drivers, the $subject
> series ends up setting the CPUIDLE_FLAG_RCU_IDLE for the ARM WFI idle
> state (state zero), but only for the arm64 and psci cases (mostly
> arm64). For arm32 we would need to update the ARM_CPUIDLE_WFI_STATE
> too, as that is what most arm32 idle-drivers are using. My point is,
> the code becomes a bit inconsistent.

True.

> Perhaps it's easier to avoid setting the CPUIDLE_FLAG_RCU_IDLE bit for
> all of the ARM WFI idle states, for both arm64 and arm32?

As per the below?

> 
> >                 .enter                  = arm_enter_idle_state,
> >                 .exit_latency           = 1,
> >                 .target_residency       = 1,

> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
> >         int __ret = 0;                                                  \
> >                                                                         \
> >         if (!idx) {                                                     \
> > +               ct_idle_enter();                                        \
> 
> According to my comment above, we should then drop these calls to
> ct_idle_enter and ct_idle_exit() here. Right?

Yes, if we ensure idx==0 never has RCU_IDLE set then these must be
removed.

> >                 cpu_do_idle();                                          \
> > +               ct_idle_exit();                                         \
> >                 return idx;                                             \
> >         }                                                               \
> >                                                                         \
> >         if (!is_retention)                                              \
> >                 __ret =  cpu_pm_enter();                                \
> >         if (!__ret) {                                                   \
> > +               ct_idle_enter();                                        \
> >                 __ret = low_level_idle_enter(state);                    \
> > +               ct_idle_exit();                                         \
> >                 if (!is_retention)                                      \
> >                         cpu_pm_exit();                                  \
> >         }                                                               \
> >

So the basic premise is that everything that needs RCU inside the idle
callback must set CPUIDLE_FLAG_RCU_IDLE and by doing that promise to
call ct_idle_{enter,exit}() themselves.

Setting RCU_IDLE is required when there is RCU usage, however even if
there is no RCU usage, setting RCU_IDLE is fine, as long as
ct_idle_{enter,exit}() then get called.


So does the below (delta) look better to you?

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1218,7 +1218,7 @@ static int acpi_processor_setup_lpi_stat
 		state->target_residency = lpi->min_residency;
 		if (lpi->arch_flags)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
-		if (lpi->entry_method == ACPI_CSTATE_FFH)
+		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
 			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
 		state->enter = acpi_idle_lpi_enter;
 		drv->safe_state_index = i;
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -53,7 +53,7 @@ static struct cpuidle_driver arm_idle_dr
 	 * handler for idle state index 0.
 	 */
 	.states[0] = {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
+		.flags			= 0,
 		.enter                  = arm_enter_idle_state,
 		.exit_latency           = 1,
 		.target_residency       = 1,
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -357,7 +357,7 @@ static int psci_idle_init_cpu(struct dev
 	 * PSCI idle states relies on architectural WFI to be represented as
 	 * state index 0.
 	 */
-	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
+	drv->states[0].flags = 0;
 	drv->states[0].enter = psci_enter_idle_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -72,7 +72,7 @@ static struct cpuidle_driver qcom_spm_id
 	.owner = THIS_MODULE,
 	.states[0] = {
 		.enter			= spm_enter_idle_state,
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
+		.flags			= 0,
 		.exit_latency		= 1,
 		.target_residency	= 1,
 		.power_usage		= UINT_MAX,
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -337,7 +337,7 @@ static int sbi_cpuidle_init_cpu(struct d
 	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
 
 	/* RISC-V architectural WFI to be represented as state index 0. */
-	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
+	drv->states[0].flags = 0;
 	drv->states[0].enter = sbi_cpuidle_enter_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -282,9 +282,7 @@ extern s64 cpuidle_governor_latency_req(
 	int __ret = 0;							\
 									\
 	if (!idx) {							\
-		ct_idle_enter();					\
 		cpu_do_idle();						\
-		ct_idle_exit();						\
 		return idx;						\
 	}								\
 									\
