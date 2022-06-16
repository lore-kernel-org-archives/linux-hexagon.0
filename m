From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Thu, 16 Jun 2022 14:26:56 -0700
Message-ID: <20220616142656.4b1acc4a@jacob-builder>
References: <20220608142723.103523089@infradead.org>
        <20220608144516.172460444@infradead.org>
        <20220609164921.5e61711d@jacob-builder>
        <Yqb45vclY2KVL0wZ@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655414572; x=1686950572;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIVB2Wcg0d4KNkOlM5BOJs0iOIDhUm5jxxQVobMAAIM=;
  b=RP2YCFWJTKa74eNpADc52RfwyjDAvZ8LbqtQ+29QXXL8TwRbvjSWS7Ba
   pq99M69aIQ9JNjTvJTyVDW//G+jY7TSkumi1VWip/2CpHCCXM6c6TDOdt
   ovkJ3Yi3iryHnvVyD2y26qw2tMuSleKA/emETgYWmPoT1kmV2lQAziBjw
   O3q86x2LyuYnnhk+Vs+DKTvFCxrgF97TC4OmRtb6/SSLEM/JP4XfqNzIy
   uBWpPFsIMbGc2UKu+E2AO9bfY2POAwfylNkeUEpgS6fQsCe6X4buSH60h
   /gpL6lhB831yaHj1bisym9RyaHXfKLRndrfm290x2hFX1FL/TzwTh4/0s
   A==;
In-Reply-To: <Yqb45vclY2KVL0wZ@hirez.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Hi Peter,

On Mon, 13 Jun 2022 10:44:22 +0200, Peter Zijlstra <peterz@infradead.org>
wrote:

> On Thu, Jun 09, 2022 at 04:49:21PM -0700, Jacob Pan wrote:
> > Hi Peter,
> > 
> > On Wed, 08 Jun 2022 16:27:27 +0200, Peter Zijlstra
> > <peterz@infradead.org> wrote:
> >   
> > > Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> > > Xeons") wrecked intel_idle in two ways:
> > > 
> > >  - must not have tracing in idle functions
> > >  - must return with IRQs disabled
> > > 
> > > Additionally, it added a branch for no good reason.
> > > 
> > > Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on
> > > Xeons") Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  drivers/idle/intel_idle.c |   48
> > > +++++++++++++++++++++++++++++++++++----------- 1 file changed, 37
> > > insertions(+), 11 deletions(-)
> > > 
> > > --- a/drivers/idle/intel_idle.c
> > > +++ b/drivers/idle/intel_idle.c
> > > @@ -129,21 +137,37 @@ static unsigned int mwait_substates __in
> > >   *
> > >   * Must be called under local_irq_disable().
> > >   */  
> > nit: this comment is no long true, right?  
> 
> It still is, all the idle routines are called with interrupts disabled,
> but must also exit with interrupts disabled.
> 
> If the idle method requires interrupts to be enabled, it must be sure to
> disable them again before returning. Given all the RCU/tracing concerns
> it must use raw_local_irq_*() for this though.
Makes sense, it is just little confusing when the immediate caller does
raw_local_irq_enable() which does not cancel out local_irq_disable().

Thanks,

Jacob
