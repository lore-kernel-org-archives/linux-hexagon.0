From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 03/44] cpuidle/poll: Ensure IRQ state is invariant
Date: Mon, 19 Sep 2022 15:19:27 +0200
Message-ID: <20220919131927.GA58444@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.534233547@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663593571;
        bh=CWxeSKy8kiP3vLBtnTdjMO9HxV48EKwdW/OqmPtC6l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSt/tYd0fqkRxl3AMLkOfW8jOo29uPNAUTrqCEiKcW4GPIFYazQI+7GdaoR9WjHP/
         C3f1Cn90J1fcSJRomBPO2R4SafD0GeCOnjMu8GrC0DI9SRc41HhHQAuGu6/ePf7CIl
         1tpNMlSYxVEEkgVVGnt9sORkREiG3UwgD6k+rAvp+k8Ymdzy6EmONNUtQQ0FPwJrZz
         E4kynvoBow0vT5f8AL2kEtRjwbRixVHhtNIY4x7IXbFVctpkPsLDVFZ3AmASNufD84
         LJuwBz9RlC4vCLjpY3pQPKjt4W7RUs6cFBM07ypkDZ4M4AFgldiHx3H7zbxKMROjNw
         AklJSa90tpIbg==
Content-Disposition: inline
In-Reply-To: <20220919101520.534233547@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:42AM +0200, Peter Zijlstra wrote:
> cpuidle_state::enter() methods should be IRQ invariant

Got a bit confused with the invariant thing since the first chunck I
see in this patch is a conversion to an non-traceable local_irq_enable().

Maybe just add a short mention about that and why?

Thanks.

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/poll_state.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -17,7 +17,7 @@ static int __cpuidle poll_idle(struct cp
>  
>  	dev->poll_time_limit = false;
>  
> -	local_irq_enable();
> +	raw_local_irq_enable();
>  	if (!current_set_polling_and_test()) {
>  		unsigned int loop_count = 0;
>  		u64 limit;
> @@ -36,6 +36,8 @@ static int __cpuidle poll_idle(struct cp
>  			}
>  		}
>  	}
> +	raw_local_irq_disable();
> +
>  	current_clr_polling();
>  
>  	return index;
> 
> 
