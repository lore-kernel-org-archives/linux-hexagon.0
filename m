From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 34.5/36] cpuidle,omap4: Push RCU-idle into
 omap4_enter_lowpower()
Date: Wed, 15 Jun 2022 08:35:38 +0300
Message-ID: <YqlvqhdlFsNvUBeG@atomide.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.073801916@infradead.org>
 <Yqcv6crSNKuSWoTu@atomide.com>
 <YqkHto+zgAPs4kQI@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <YqkHto+zgAPs4kQI-IIpfhp3q70z/8w/KjCw3T+5/BudmfyzbbVWyRVo5IupeoWH0uzbU5w@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org, ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org, mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vgupta-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcain-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, chenhuacai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-f95k8chpbVdBDLzU/O5InQ@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org, palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org, aou-aFE07iDfcCIb0cFwG/AQJIdd74u8MsAO@public.gmane.org, hca@l

Hi,

Adding Aaro Koskinen and Peter Vasil for pm24xx for n800 and n810 related
idle.

* Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> [220614 22:07]:
> On Mon, Jun 13, 2022 at 03:39:05PM +0300, Tony Lindgren wrote:
> > OMAP4 uses full SoC suspend modes as idle states, as such it needs the
> > whole power-domain and clock-domain code from the idle path.
> > 
> > All that code is not suitable to run with RCU disabled, as such push
> > RCU-idle deeper still.
> > 
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> > 
> > Peter here's one more for your series, looks like this is needed to avoid
> > warnings similar to what you did for omap3.
> 
> Thanks Tony!
> 
> I've had a brief look at omap2_pm_idle() and do I understand it right
> that something like the below patch would reduce it to a simple 'WFI'?

Yes that should do for omap2_do_wfi().

> What do I do with the rest of that code, because I don't think this
> thing has a cpuidle driver to take over, effectively turning it into
> dead code.

As we are establishing a policy where deeper idle states must be
handled by cpuidle, and for most part that has been the case for at least
10 years, I'd just drop the unused functions with an explanation in the
patch why we're doing it. Or the functions could be tagged with
__maybe_unused if folks prefer that.

In the pm24xx case we are not really causing a regression for users as
there are still pending patches to make n800 and n810 truly usable with
the mainline kernel. At least the PMIC and LCD related patches need some
work [0]. The deeper idle states can be added back later using cpuidle
as needed so we have a clear path.

Aaro & Peter V, do you have any better suggestions here as this will
mostly affect you guys currently?

Regards,

Tony

[0] https://lore.kernel.org/linux-omap/20211224214512.1583430-1-peter.vasil-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org/


> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -126,10 +126,20 @@ static int omap2_allow_mpu_retention(voi
>  	return 1;
>  }
>  
> -static void omap2_enter_mpu_retention(void)
> +static void omap2_do_wfi(void)
>  {
>  	const int zero = 0;
>  
> +	/* WFI */
> +	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
> +}
> +
> +#if 0
> +/*
> + * possible cpuidle implementation between WFI and full_retention above
> + */
> +static void omap2_enter_mpu_retention(void)
> +{
>  	/* The peripherals seem not to be able to wake up the MPU when
>  	 * it is in retention mode. */
>  	if (omap2_allow_mpu_retention()) {
> @@ -146,8 +157,7 @@ static void omap2_enter_mpu_retention(vo
>  		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
>  	}
>  
> -	/* WFI */
> -	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
> +	omap2_do_wfi();
>  
>  	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
>  }
> @@ -161,6 +171,7 @@ static int omap2_can_sleep(void)
>  
>  	return 1;
>  }
> +#endif
>  
>  static void omap2_pm_idle(void)
>  {
> @@ -169,6 +180,7 @@ static void omap2_pm_idle(void)
>  	if (omap_irq_pending())
>  		return;
>  
> +#if 0
>  	error = cpu_cluster_pm_enter();
>  	if (error || !omap2_can_sleep()) {
>  		omap2_enter_mpu_retention();
> @@ -179,6 +191,9 @@ static void omap2_pm_idle(void)
>  
>  out_cpu_cluster_pm:
>  	cpu_cluster_pm_exit();
> +#else
> +	omap2_do_wfi();
> +#endif
>  }
>  
>  static void __init prcm_setup_regs(void)
