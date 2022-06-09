From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Date: Thu, 9 Jun 2022 11:16:46 +0200
Message-ID: <YqG6URbihTNCk9YR@alley>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.444659212@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654766212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d57/DrqDiiJ2foYz2ew+5Cqn+PqODCYrsHqzu7X2C2Q=;
        b=fo+sYmFjpmQOmpyD3JvJl9AYNinBjxAVeUE+HbamyvnKBmUJ4aJ/YSAu3A8+CqB7Ibeuz8
        5d8JOsM43+X+4Im3fKziKImYEhGOTr+/e/e7kKF981tYnqb1CU7vBLnpyqhaj1HOQaPm0q
        8dfR9EB/TBh2sOsSKiFiTu8q7nOVsPQ=
Content-Disposition: inline
In-Reply-To: <20220608144517.444659212@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 

On Wed 2022-06-08 16:27:47, Peter Zijlstra wrote:
> The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
> tracepoint"), was printk usage from the cpuidle path where RCU was
> already disabled.
> 
> Per the patches earlier in this series, this is no longer the case.

My understanding is that this series reduces a lot the amount
of code called with RCU disabled. As a result the particular printk()
call mentioned by commit fc98c3c8c9dc ("printk: use rcuidle console
tracepoint") is called with RCU enabled now. Hence this particular
problem is fixed better way now.

But is this true in general?
Does this "prevent" calling printk() a safe way in code with
RCU disabled?

I am not sure if anyone cares. printk() is the best effort
functionality because of the consoles code anyway. Also I wonder
if anyone uses this trace_console().

Therefore if this patch allows to remove some tricky tracing
code then it might be worth it. But if trace_console_rcuidle()
variant is still going to be available then I would keep using it.

Best Regards,
Petr

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/printk/printk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2238,7 +2238,7 @@ static u16 printk_sprint(char *text, u16
>  		}
>  	}
>  
> -	trace_console_rcuidle(text, text_len);
> +	trace_console(text, text_len);
>  
>  	return text_len;
>  }
> 
