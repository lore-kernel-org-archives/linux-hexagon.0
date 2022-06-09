From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Date: Thu, 9 Jun 2022 12:14:42 +0200
Message-ID: <YqHIEthhhi5e+Mtb@alley>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.444659212@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654769687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DrcvBEFljM5p6TtbSeEidSTZ/fg57f/9Kkfw39rL09Y=;
        b=DMcdvAORR690fi8pr+U8fk3+hyZsj7Tt5x9qwl047KjZChmxVjUcAfS5VoE+jvBI94jRA8
        x1qWl9NmnYPcL1/wsN/jGmXJEl3+KOTwVVBHmebd33G6ciWPS6jZdzz9VOlvQCAFmLQ8Zj
        Z7XOIERpCYK8sshW0SQuT7wCuIg0KcE=
Content-Disposition: inline
In-Reply-To: <20220608144517.444659212@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 

Sending again. The previous attempt was rejected by several
recipients. It was caused by a mail server changes on my side.

I am sorry for spamming those who got the 1st mail already.

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
