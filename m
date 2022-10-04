From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 38/44] cpuidle,powerdomain: Remove trace_.*_rcuidle()
Date: Tue, 4 Oct 2022 13:12:42 +0200
Message-ID: <CAPDyKFqDiqXSi5Gn9eyvhHhqHxJAPAt-HzmEDwYWaGvso2yn=w@mail.gmail.com>
References: <20220919095939.761690562@infradead.org> <20220919101522.908560022@infradead.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UHE2x7YnT+avJBdJRK8fICu4tqbTB0zv1A8Jd5IOhrw=;
        b=DQ7AqshQw7pAlndMjmyEf3HDNlexUBF+jB73J+4SoV4OjFHAeL9d93Pkb0EJq27wmV
         fMsaB2Ugk2jANVVFsgCVCwsCPcqfEpNwL8Phil7GBZGqFbBPLY20X/vyyyMA3GQqxwqr
         9GitSfUr/lUWnkoEFyKfW1UEPWDsM/lhvI/GgsbbZeTjM/BKXmE2CDDRkoVqqPha6oPu
         qT7JzbFbc8JYxA1Hnfg8ebCiWushyc4cczI9HWkbShP/pG31SGJukNeZLdU4X/4Dr/J1
         nBm7WS/ywrZAsUI2kefDBEEPXrA2HSCWcStoD/F24lMd+RQ2O+RyHYdGsKRKL5ywBm+U
         IhvQ==
In-Reply-To: <20220919101522.908560022@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.or

On Mon, 19 Sept 2022 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> OMAP was the one and only user.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

There are changes to the runtime PM core as part of $subject patch.
Perhaps move those parts into a separate patch? In any case, the code
looks good to me.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/mach-omap2/powerdomain.c |   10 +++++-----
>  drivers/base/power/runtime.c      |   24 ++++++++++++------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -187,9 +187,9 @@ static int _pwrdm_state_switch(struct po
>                         trace_state = (PWRDM_TRACE_STATES_FLAG |
>                                        ((next & OMAP_POWERSTATE_MASK) << 8) |
>                                        ((prev & OMAP_POWERSTATE_MASK) << 0));
> -                       trace_power_domain_target_rcuidle(pwrdm->name,
> -                                                         trace_state,
> -                                                         raw_smp_processor_id());
> +                       trace_power_domain_target(pwrdm->name,
> +                                                 trace_state,
> +                                                 raw_smp_processor_id());
>                 }
>                 break;
>         default:
> @@ -541,8 +541,8 @@ int pwrdm_set_next_pwrst(struct powerdom
>
>         if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>                 /* Trace the pwrdm desired target state */
> -               trace_power_domain_target_rcuidle(pwrdm->name, pwrst,
> -                                                 raw_smp_processor_id());
> +               trace_power_domain_target(pwrdm->name, pwrst,
> +                                         raw_smp_processor_id());
>                 /* Program the pwrdm desired target state */
>                 ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>         }
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -442,7 +442,7 @@ static int rpm_idle(struct device *dev,
>         int (*callback)(struct device *);
>         int retval;
>
> -       trace_rpm_idle_rcuidle(dev, rpmflags);
> +       trace_rpm_idle(dev, rpmflags);
>         retval = rpm_check_suspend_allowed(dev);
>         if (retval < 0)
>                 ;       /* Conditions are wrong. */
> @@ -481,7 +481,7 @@ static int rpm_idle(struct device *dev,
>                         dev->power.request_pending = true;
>                         queue_work(pm_wq, &dev->power.work);
>                 }
> -               trace_rpm_return_int_rcuidle(dev, _THIS_IP_, 0);
> +               trace_rpm_return_int(dev, _THIS_IP_, 0);
>                 return 0;
>         }
>
> @@ -493,7 +493,7 @@ static int rpm_idle(struct device *dev,
>         wake_up_all(&dev->power.wait_queue);
>
>   out:
> -       trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
> +       trace_rpm_return_int(dev, _THIS_IP_, retval);
>         return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
>  }
>
> @@ -557,7 +557,7 @@ static int rpm_suspend(struct device *de
>         struct device *parent = NULL;
>         int retval;
>
> -       trace_rpm_suspend_rcuidle(dev, rpmflags);
> +       trace_rpm_suspend(dev, rpmflags);
>
>   repeat:
>         retval = rpm_check_suspend_allowed(dev);
> @@ -708,7 +708,7 @@ static int rpm_suspend(struct device *de
>         }
>
>   out:
> -       trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
> +       trace_rpm_return_int(dev, _THIS_IP_, retval);
>
>         return retval;
>
> @@ -760,7 +760,7 @@ static int rpm_resume(struct device *dev
>         struct device *parent = NULL;
>         int retval = 0;
>
> -       trace_rpm_resume_rcuidle(dev, rpmflags);
> +       trace_rpm_resume(dev, rpmflags);
>
>   repeat:
>         if (dev->power.runtime_error) {
> @@ -925,7 +925,7 @@ static int rpm_resume(struct device *dev
>                 spin_lock_irq(&dev->power.lock);
>         }
>
> -       trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
> +       trace_rpm_return_int(dev, _THIS_IP_, retval);
>
>         return retval;
>  }
> @@ -1081,7 +1081,7 @@ int __pm_runtime_idle(struct device *dev
>                 if (retval < 0) {
>                         return retval;
>                 } else if (retval > 0) {
> -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> +                       trace_rpm_usage(dev, rpmflags);
>                         return 0;
>                 }
>         }
> @@ -1119,7 +1119,7 @@ int __pm_runtime_suspend(struct device *
>                 if (retval < 0) {
>                         return retval;
>                 } else if (retval > 0) {
> -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> +                       trace_rpm_usage(dev, rpmflags);
>                         return 0;
>                 }
>         }
> @@ -1202,7 +1202,7 @@ int pm_runtime_get_if_active(struct devi
>         } else {
>                 retval = atomic_inc_not_zero(&dev->power.usage_count);
>         }
> -       trace_rpm_usage_rcuidle(dev, 0);
> +       trace_rpm_usage(dev, 0);
>         spin_unlock_irqrestore(&dev->power.lock, flags);
>
>         return retval;
> @@ -1566,7 +1566,7 @@ void pm_runtime_allow(struct device *dev
>         if (ret == 0)
>                 rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
>         else if (ret > 0)
> -               trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> +               trace_rpm_usage(dev, RPM_AUTO | RPM_ASYNC);
>
>   out:
>         spin_unlock_irq(&dev->power.lock);
> @@ -1635,7 +1635,7 @@ static void update_autosuspend(struct de
>                         atomic_inc(&dev->power.usage_count);
>                         rpm_resume(dev, 0);
>                 } else {
> -                       trace_rpm_usage_rcuidle(dev, 0);
> +                       trace_rpm_usage(dev, 0);
>                 }
>         }
>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
