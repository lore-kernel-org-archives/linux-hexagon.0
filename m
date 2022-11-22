From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 12/44] cpuidle,dt: Push RCU-idle into driver
Date: Tue, 22 Nov 2022 17:04:33 +0100
Message-ID: <CAPDyKFqzmJdVVrcuJ6Hmr5nNgtpd9Oke_exmUKuTGZEb=PjvjQ@mail.gmail.com>
References: <20220919095939.761690562@infradead.org> <20220919101521.139727471@infradead.org>
 <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com> <Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKqixJN/8zapPMiYOY0ZA2E36N6vIQg16uLiOxlikFI=;
        b=Sxgb7NdwQ/FjyYXzMQLr2Ufh8inWhewppyg2kEhKfSMa5+4xLhcDZFgBkLe+YVojYR
         b1j/8R8eepdhz2QNEoN59UWxI0C8HtPNMN2hfsnJ2VXdsyzTbL+tlNksQKPnsWg/NtBp
         chCgU4N95aPK2lbuS5RzKtW5ffOhO3rTLhquzizFSUU3p/ux1MbE2BMO0btBQyCrWeJK
         WXzMJ1H0fbnItfONfrC7qjjeZVQUnHu7QZDLXM8ZsS1OkeorqU4Yt3+bnHeBb63EIVUM
         ARM0B0wTMD/PlD/5zjrBQjmOnBQvgdxEwxF1FwYHEN8lHlbB5RkK/8WK1b4hFP6jFplD
         FuDA==
In-Reply-To: <Y3UBwYNY15ETUKy9-Nxj+rRp3nVydTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: juri.lelli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bsegall-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, agordeev-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, chenhuacai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, vgupta-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org, pmladek-IBi9RG/b67k@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-um-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, andreyknvl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-perf-users-u79uwXL29TaqPxH82wqD4g@public.gmane.org

On Wed, 16 Nov 2022 at 16:29, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
>
> Sorry; things keep getting in the way of finishing this :/
>
> As such, I need a bit of time to get on-track again..
>
> On Tue, Oct 04, 2022 at 01:03:57PM +0200, Ulf Hansson wrote:
>
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
> > >                 state->target_residency = lpi->min_residency;
> > >                 if (lpi->arch_flags)
> > >                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > > +               if (lpi->entry_method == ACPI_CSTATE_FFH)
> > > +                       state->flags |= CPUIDLE_FLAG_RCU_IDLE;
> >
> > I assume the state index here will never be 0?
> >
> > If not, it may lead to that acpi_processor_ffh_lpi_enter() may trigger
> > CPU_PM_CPU_IDLE_ENTER_PARAM() to call ct_cpuidle_enter|exit() for an
> > idle-state that doesn't have the CPUIDLE_FLAG_RCU_IDLE bit set.
>
> I'm not quite sure I see how. AFAICT this condition above implies
> acpi_processor_ffh_lpi_enter() gets called, no?
>
> Which in turn is an unconditional __CPU_PM_CPU_IDLE_ENTER() user, so
> even if idx==0, it ends up in ct_idle_{enter,exit}().

Seems like I was overlooking something here, you are right, this
shouldn't really be a problem.

>
> >
> > >                 state->enter = acpi_idle_lpi_enter;
> > >                 drv->safe_state_index = i;
> > >         }
> > > --- a/drivers/cpuidle/cpuidle-arm.c
> > > +++ b/drivers/cpuidle/cpuidle-arm.c
> > > @@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
> > >          * handler for idle state index 0.
> > >          */
> > >         .states[0] = {
> > > +               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> >
> > Comparing arm64 and arm32 idle-states/idle-drivers, the $subject
> > series ends up setting the CPUIDLE_FLAG_RCU_IDLE for the ARM WFI idle
> > state (state zero), but only for the arm64 and psci cases (mostly
> > arm64). For arm32 we would need to update the ARM_CPUIDLE_WFI_STATE
> > too, as that is what most arm32 idle-drivers are using. My point is,
> > the code becomes a bit inconsistent.
>
> True.
>
> > Perhaps it's easier to avoid setting the CPUIDLE_FLAG_RCU_IDLE bit for
> > all of the ARM WFI idle states, for both arm64 and arm32?
>
> As per the below?
>
> >
> > >                 .enter                  = arm_enter_idle_state,
> > >                 .exit_latency           = 1,
> > >                 .target_residency       = 1,
>
> > > --- a/include/linux/cpuidle.h
> > > +++ b/include/linux/cpuidle.h
> > > @@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
> > >         int __ret = 0;                                                  \
> > >                                                                         \
> > >         if (!idx) {                                                     \
> > > +               ct_idle_enter();                                        \
> >
> > According to my comment above, we should then drop these calls to
> > ct_idle_enter and ct_idle_exit() here. Right?
>
> Yes, if we ensure idx==0 never has RCU_IDLE set then these must be
> removed.
>
> > >                 cpu_do_idle();                                          \
> > > +               ct_idle_exit();                                         \
> > >                 return idx;                                             \
> > >         }                                                               \
> > >                                                                         \
> > >         if (!is_retention)                                              \
> > >                 __ret =  cpu_pm_enter();                                \
> > >         if (!__ret) {                                                   \
> > > +               ct_idle_enter();                                        \
> > >                 __ret = low_level_idle_enter(state);                    \
> > > +               ct_idle_exit();                                         \
> > >                 if (!is_retention)                                      \
> > >                         cpu_pm_exit();                                  \
> > >         }                                                               \
> > >
>
> So the basic premise is that everything that needs RCU inside the idle
> callback must set CPUIDLE_FLAG_RCU_IDLE and by doing that promise to
> call ct_idle_{enter,exit}() themselves.
>
> Setting RCU_IDLE is required when there is RCU usage, however even if
> there is no RCU usage, setting RCU_IDLE is fine, as long as
> ct_idle_{enter,exit}() then get called.

Right, I was thinking that it could make sense to shrink the window
for users getting this wrong. In other words, we shouldn't set the
CPUIDLE_FLAG_RCU_IDLE unless we really need to.

And as I said, consistent behaviour is also nice to have.

>
>
> So does the below (delta) look better to you?

Yes, it does!

Although, one minor comment below.

>
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1218,7 +1218,7 @@ static int acpi_processor_setup_lpi_stat
>                 state->target_residency = lpi->min_residency;
>                 if (lpi->arch_flags)
>                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> -               if (lpi->entry_method == ACPI_CSTATE_FFH)
> +               if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>                         state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>                 state->enter = acpi_idle_lpi_enter;
>                 drv->safe_state_index = i;
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -53,7 +53,7 @@ static struct cpuidle_driver arm_idle_dr
>          * handler for idle state index 0.
>          */
>         .states[0] = {
> -               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> +               .flags                  = 0,

Nitpick: I don't think we need to explicitly clear the flag, as it
should already be zeroed by the compiler from its static declaration.
Right?

>                 .enter                  = arm_enter_idle_state,
>                 .exit_latency           = 1,
>                 .target_residency       = 1,
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -357,7 +357,7 @@ static int psci_idle_init_cpu(struct dev
>          * PSCI idle states relies on architectural WFI to be represented as
>          * state index 0.
>          */
> -       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> +       drv->states[0].flags = 0;
>         drv->states[0].enter = psci_enter_idle_state;
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -72,7 +72,7 @@ static struct cpuidle_driver qcom_spm_id
>         .owner = THIS_MODULE,
>         .states[0] = {
>                 .enter                  = spm_enter_idle_state,
> -               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> +               .flags                  = 0,
>                 .exit_latency           = 1,
>                 .target_residency       = 1,
>                 .power_usage            = UINT_MAX,
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -337,7 +337,7 @@ static int sbi_cpuidle_init_cpu(struct d
>         drv->cpumask = (struct cpumask *)cpumask_of(cpu);
>
>         /* RISC-V architectural WFI to be represented as state index 0. */
> -       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> +       drv->states[0].flags = 0;
>         drv->states[0].enter = sbi_cpuidle_enter_state;
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -282,9 +282,7 @@ extern s64 cpuidle_governor_latency_req(
>         int __ret = 0;                                                  \
>                                                                         \
>         if (!idx) {                                                     \
> -               ct_idle_enter();                                        \
>                 cpu_do_idle();                                          \
> -               ct_idle_exit();                                         \
>                 return idx;                                             \
>         }                                                               \
>                                                                         \

Kind regards
Uffe
