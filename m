From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Thu, 9 Jun 2022 16:49:21 -0700
Message-ID: <20220609164921.5e61711d@jacob-builder>
References: <20220608142723.103523089@infradead.org>
        <20220608144516.172460444@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654818322; x=1686354322;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qix89+4Yux2UyS3QMBWmKLCne+VvkXES21cCGFIhLs=;
  b=EkaTUs0rea+454rYaBsqSroRFg0PamD4jU6O0eq1wv/5itn58fVYLUXz
   hlWtv1Ogpl7/5XIS618tIb0uG/q2+eGCMXsttxiOJDTm6dvjif29rcsmN
   nWpOfx8wOz2WQB1f6Ul8b7EGNqASBsmk3lVSAAbjuyEvvEhAIHeX8zQmg
   +ufj+64/oRf3ev5vJZH5Yejs7zEtNES51/2LxU4etWbj7BVv+kw0q1QiP
   unGfwpuQghUcTK8rXLxr286tVxF9gYfN+irF5pYrEItvr0xmkc2yTnQok
   EbNfwxaIzp9UCsQ8gskKbD4HfjRVXi6KKS6myyqzqnJkOJaWOKufoYQaK
   A==;
In-Reply-To: <20220608144516.172460444@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Hi Peter,

On Wed, 08 Jun 2022 16:27:27 +0200, Peter Zijlstra <peterz@infradead.org>
wrote:

> Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> Xeons") wrecked intel_idle in two ways:
> 
>  - must not have tracing in idle functions
>  - must return with IRQs disabled
> 
> Additionally, it added a branch for no good reason.
> 
> Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/idle/intel_idle.c |   48
> +++++++++++++++++++++++++++++++++++----------- 1 file changed, 37
> insertions(+), 11 deletions(-)
> 
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -129,21 +137,37 @@ static unsigned int mwait_substates __in
>   *
>   * Must be called under local_irq_disable().
>   */
nit: this comment is no long true, right?

> +
> -static __cpuidle int intel_idle(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv, int index)
> +static __always_inline int __intel_idle(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int
> index) {
>  	struct cpuidle_state *state = &drv->states[index];
>  	unsigned long eax = flg2MWAIT(state->flags);
>  	unsigned long ecx = 1; /* break on interrupt flag */
>  
> -	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
> -		local_irq_enable();
> -
>  	mwait_idle_with_hints(eax, ecx);
>  
>  	return index;
>  }
>  
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	return __intel_idle(dev, drv, index);
> +}
> +
> +static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
> +				    struct cpuidle_driver *drv, int
> index) +{
> +	int ret;
> +
> +	raw_local_irq_enable();
> +	ret = __intel_idle(dev, drv, index);
> +	raw_local_irq_disable();
> +
> +	return ret;
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> @@ -1801,6 +1824,9 @@ static void __init intel_idle_init_cstat
>  		/* Structure copy. */
>  		drv->states[drv->state_count] =
> cpuidle_state_table[cstate]; 
> +		if (cpuidle_state_table[cstate].flags &
> CPUIDLE_FLAG_IRQ_ENABLE)
> +			drv->states[drv->state_count].enter =
> intel_idle_irq; +
>  		if ((disabled_states_mask & BIT(drv->state_count)) ||
>  		    ((icpu->use_acpi || force_use_acpi) &&
>  		     intel_idle_off_by_default(mwait_hint) &&
> 
> 


Thanks,

Jacob
