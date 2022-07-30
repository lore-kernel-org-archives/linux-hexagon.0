From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Sat, 30 Jul 2022 11:16:39 -0700
Message-ID: <20220730181639.GS2860372@paulmck-ThinkPad-P17-Gen-1>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
 <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org>
 <20220729152622.GM2860372@paulmck-ThinkPad-P17-Gen-1>
 <20220730094032.GA1587@lespinasse.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659204999;
        bh=YJXP6A7d+KZPrg8HQv8x+gqLEMy1sjVdzXnl/qX62uw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gJSpKVSsAKz8pom4RuAB5Je2VfXHGMhI5S8QuPgLw6sbq0QnDrcsB984Q3KCjMEP4
         SYUjeqdnSm23czJoxrwT8/cSChg2wZ3j8oXxKHXQSMFJwdsOWYkZ8L3yHTrxHHHv/B
         PCAYHs9Jnrby4wbTToGryEY6Ex3TIpS7AHVXuUJU6nS/OoMCgZLC69/yQVKdeU26z2
         g1F1UjpLlSrDEHmQXbwyZ9oeANnc2U7/KwPArewe4hoBbjnHbzgEqXp6HAhF3f96Ro
         rfGOh77ykaTrG15ZCImyvdTTA95ZiEUj+F32tOHQ6Prrb5v2smeceYH3zHnZYF0uH1
         p/j3tMujFTrgw==
Content-Disposition: inline
In-Reply-To: <20220730094032.GA1587@lespinasse.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel Lespinasse <michel@lespinasse.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sif

On Sat, Jul 30, 2022 at 02:40:32AM -0700, Michel Lespinasse wrote:
> On Fri, Jul 29, 2022 at 08:26:22AM -0700, Paul E. McKenney wrote:> Would you be willing to try another shot in the dark, but untested
> > this time?  I freely admit that this is getting strange.
> > 
> > 							Thanx, Paul
> 
> Yes, adding this second change got rid of the boot time warning for me.

OK, I will make a real patch.  May I have your Tested-by?

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index e374c0c923dae..279f557bf60bb 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -394,7 +394,7 @@ notrace void sched_clock_tick(void)
> >  	if (!static_branch_likely(&sched_clock_running))
> >  		return;
> >  
> > -	lockdep_assert_irqs_disabled();
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
> >  
> >  	scd = this_scd();
> >  	__scd_stamp(scd);
