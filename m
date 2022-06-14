From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 15/36] cpuidle,cpu_pm: Remove RCU fiddling from
 cpu_pm_{enter,exit}()
Date: Tue, 14 Jun 2022 18:42:14 +0200
Message-ID: <Yqi6Zp+DTm22dLB9@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.871305980@infradead.org>
 <YqiznJL7qB9uSQ9c@FVFF77S0Q05N>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=47+tWvYfTyzzIcAfKg2dikUAXvzTciJT7x9ArpBU0cQ=; b=WhjpnYz1DKB/ghxhQBYKZr1QWz
        84Rt1GI0YXBpWpQ+Rpq7OdaNTLjSPvHCVKLFiVIOCLsRCFy4DqvtOiDgSLHRe8OVkGLFTex3SSmV8
        GohZ4ojxrTeP3ET5b4IFii7FfH5UbRGPxexOa+//wX1ieayjZ2GRIBUTTRmWuqKFS+bMiVDFKRSHa
        IV/MEvx0ElZNGt7kUqMr8NdHhRUFOmSCcqPcU9jSeSr7SVt4T0z3jKsQ6pCYU45ZyxeCj6DorIHXj
        CZmBSb2KSbTYN4gQwzBcOOqwVgJL0yEm9Ud5o0YTPtfXZ0pRZucUs+sMUdTCsznw5yKZXiWmZw8aF
        sEV0aFJg==;
Content-Disposition: inline
In-Reply-To: <YqiznJL7qB9uSQ9c@FVFF77S0Q05N>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland@arm.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

On Tue, Jun 14, 2022 at 05:13:16PM +0100, Mark Rutland wrote:
> On Wed, Jun 08, 2022 at 04:27:38PM +0200, Peter Zijlstra wrote:
> > All callers should still have RCU enabled.
> 
> IIUC with that true we should be able to drop the RCU_NONIDLE() from
> drivers/perf/arm_pmu.c, as we only needed that for an invocation via a pm
> notifier.
> 
> I should be able to give that a spin on some hardware.
> 
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/cpu_pm.c |    9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > --- a/kernel/cpu_pm.c
> > +++ b/kernel/cpu_pm.c
> > @@ -30,16 +30,9 @@ static int cpu_pm_notify(enum cpu_pm_eve
> >  {
> >  	int ret;
> >  
> > -	/*
> > -	 * This introduces a RCU read critical section, which could be
> > -	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
> > -	 * this.
> > -	 */
> > -	rcu_irq_enter_irqson();
> >  	rcu_read_lock();
> >  	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
> >  	rcu_read_unlock();
> > -	rcu_irq_exit_irqson();
> 
> To make this easier to debug, is it worth adding an assertion that RCU is
> watching here? e.g.
> 
> 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> 			 "cpu_pm_notify() used illegally from EQS");
> 

My understanding is that rcu_read_lock() implies something along those
lines when PROVE_RCU.
