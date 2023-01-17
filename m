From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: Re: [PATCH v3 35/51] trace,hardirq: No moar _rcuidle() tracing
Date: Tue, 17 Jan 2023 13:24:46 +0900
Message-ID: <20230117132446.02ec12e4c10718de27790900@kernel.org>
References: <20230112194314.845371875@infradead.org>
        <20230112195541.477416709@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673929510;
        bh=LKPfAbcdavLMCpifQk05Aqw+1tD2xg5qsuB6VorVVnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rvDfVQk7Tsas4+LZFK04iCV/SqfYXmqYXLFi42JOngYW1dOP0QSo6CLiBkpjYosKx
         nKUcD4fx6Lu1RT5hJ5yblHd47Jqpvv59kmEAKtriWUWkTZ7hmC4Za3q3BgpEtr891G
         Uhe5azCk4FahsTTDCEc3lE2+MzsUQWKU5CAcTO6IYBsGKCz8NivYw+lk7qeBhykDxt
         x23XNA0A5LxituWhIHyg6sCe7NTSUKsY2ON6C3g6I/nFT8i/VEH7jmIvKLWoo8AYZN
         JlOlRfIFLAGKs5+FVWy9q/WwqqbuzK/Mvbqfsgyxm4gYqDdXx2B1Vx+ckQBMj8vEfk
         ICBnmkeUNpdwg==
In-Reply-To: <20230112195541.477416709@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au

Hi Peter,

On Thu, 12 Jan 2023 20:43:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
> _rcuidle() tracepoint through local_irq_{en,dis}able().
> 
> For 'sane' configs, these calls will only happen with RCU enabled and
> as such can use the regular tracepoint. This also means it's possible
> to trace them from NMI context again.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The code looks good to me. I just have a question about comment.

> ---
>  kernel/trace/trace_preemptirq.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -20,6 +20,15 @@
>  static DEFINE_PER_CPU(int, tracing_irq_cpu);
>  
>  /*
> + * ...

Is this intended? Wouldn't you leave any comment here?

Thank you,

> + */
> +#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> +#define trace(point)	trace_##point
> +#else
> +#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
> +#endif
> +
> +/*
>   * Like trace_hardirqs_on() but without the lockdep invocation. This is
>   * used in the low level entry code where the ordering vs. RCU is important
>   * and lockdep uses a staged approach which splits the lockdep hardirq
> @@ -28,8 +37,7 @@ static DEFINE_PER_CPU(int, tracing_irq_c
>  void trace_hardirqs_on_prepare(void)
>  {
>  	if (this_cpu_read(tracing_irq_cpu)) {
> -		if (!in_nmi())
> -			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
>  		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>  		this_cpu_write(tracing_irq_cpu, 0);
>  	}
> @@ -40,8 +48,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepar
>  void trace_hardirqs_on(void)
>  {
>  	if (this_cpu_read(tracing_irq_cpu)) {
> -		if (!in_nmi())
> -			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
>  		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>  		this_cpu_write(tracing_irq_cpu, 0);
>  	}
> @@ -63,8 +70,7 @@ void trace_hardirqs_off_finish(void)
>  	if (!this_cpu_read(tracing_irq_cpu)) {
>  		this_cpu_write(tracing_irq_cpu, 1);
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -		if (!in_nmi())
> -			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
>  	}
>  
>  }
> @@ -78,8 +84,7 @@ void trace_hardirqs_off(void)
>  	if (!this_cpu_read(tracing_irq_cpu)) {
>  		this_cpu_write(tracing_irq_cpu, 1);
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -		if (!in_nmi())
> -			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
>  	}
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
