From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 14/36] cpuidle: Fix rcu_idle_*() usage
Date: Tue, 14 Jun 2022 18:40:53 +0200
Message-ID: <Yqi6Fd38ZCsDUnQG@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.808451191@infradead.org>
 <YqiB6YpVqq4wuDtO@FVFF77S0Q05N>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rwYFO4jRp4ZmBbbpQ/dlmC/s4443nixCio2KC7D4yLw=; b=Q/p58+5AIll1J3wwj9duE6joP8
        2YjrLVWMBq/QDljzX938yomfdduTqhCTkLr7QoXKmJFKAVbw2OLh/qX3V6ZNdS+JPLmmgpJf1SfIY
        tJDWeVO6lvj7Ll0I23GpN1mvudDqdBS+nOPCE6kzpamjlU8zsA7zAdCExPbyRNAwL9zRELe2Eod9B
        GsF54S7BNycteMhqcDH7uc17WfMBGrjomDM83+6j/N+qQaPKefG7lDtrncP7zKN2vwDN1lxYGVcwQ
        0DSt0M2Odg2SUPt6G1Y8DzuprGzjrzsjLdPuI+zknxqWuHe2d455VvYZ3hfJQNbQUfXwrEV7IoHb3
        UL519GRg==;
Content-Disposition: inline
In-Reply-To: <YqiB6YpVqq4wuDtO@FVFF77S0Q05N>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland@arm.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

On Tue, Jun 14, 2022 at 01:41:13PM +0100, Mark Rutland wrote:
> On Wed, Jun 08, 2022 at 04:27:37PM +0200, Peter Zijlstra wrote:
> > --- a/kernel/time/tick-broadcast.c
> > +++ b/kernel/time/tick-broadcast.c
> > @@ -622,9 +622,13 @@ struct cpumask *tick_get_broadcast_onesh
> >   * to avoid a deep idle transition as we are about to get the
> >   * broadcast IPI right away.
> >   */
> > -int tick_check_broadcast_expired(void)
> > +noinstr int tick_check_broadcast_expired(void)
> >  {
> > +#ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
> > +	return arch_test_bit(smp_processor_id(), cpumask_bits(tick_broadcast_force_mask));
> > +#else
> >  	return cpumask_test_cpu(smp_processor_id(), tick_broadcast_force_mask);
> > +#endif
> >  }
> 
> This is somewhat not-ideal. :/

I'll say.

> Could we unconditionally do the arch_test_bit() variant, with a comment, or
> does that not exist in some cases?

Loads of build errors ensued, which is how I ended up with this mess ...
