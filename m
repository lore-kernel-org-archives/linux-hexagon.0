From: Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Sat, 30 Jul 2022 02:40:32 -0700
Message-ID: <20220730094032.GA1587@lespinasse.org>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
 <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org>
 <20220729152622.GM2860372@paulmck-ThinkPad-P17-Gen-1>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-79-ed;
 t=1659174032; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=weCa4etYCrU0JKpJO/Ui+2clGa/1cbP+1Ce8uxB4Z2U=;
 b=x/Ziq42GBYdLObjVTEjRxMr42JGNj1S6ikUonHkCSS9+QUAEIEusirhrUb1NLAhWCN9I/
 26gXmKmVFCvOvm8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-79-rsa; t=1659174032; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=weCa4etYCrU0JKpJO/Ui+2clGa/1cbP+1Ce8uxB4Z2U=;
 b=xjlyRJ2PLCvlHddIpET9xkdQ9b2YJIlAuRmqVD4Zi9LYcfMqzgs3mU4rkm/FKHLXNUOaJ
 LyyP89/nFeA6CHdOEfvoMWe+2hvIc5qWIl7OAgthzIj8J1BY1lyEpfvyFmhVmffdeRhfjdo
 vMuxuuddA8OZu54a34mTh9dLsyNfUY1VEPbkQXmB5bXD5tY51a2x0Dy7lPzCrgrdbPY9jea
 g6bR8AptJZSZjsf3hgGuxahRdvKbF0nVgvjROX7b4fAX0R64UDLs/zIoRFldyB9Yfr1EawK
 tm9ki9L5Z6WkfftzLymxjgxhP/KXmf4WU+QM/fsd13mCq3dze1SIRx1wUOGA==
Content-Disposition: inline
In-Reply-To: <20220729152622.GM2860372@paulmck-ThinkPad-P17-Gen-1>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Michel Lespinasse <michel@lespinasse.org>, Peter Zijlstra <peterz@infradead.org>, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashi

On Fri, Jul 29, 2022 at 08:26:22AM -0700, Paul E. McKenney wrote:> Would you be willing to try another shot in the dark, but untested
> this time?  I freely admit that this is getting strange.
> 
> 							Thanx, Paul

Yes, adding this second change got rid of the boot time warning for me.

> ------------------------------------------------------------------------
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index e374c0c923dae..279f557bf60bb 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -394,7 +394,7 @@ notrace void sched_clock_tick(void)
>  	if (!static_branch_likely(&sched_clock_running))
>  		return;
>  
> -	lockdep_assert_irqs_disabled();
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
>  
>  	scd = this_scd();
>  	__scd_stamp(scd);
