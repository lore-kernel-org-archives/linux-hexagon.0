From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 00/36] cpuidle,rcu: Cleanup the mess
Date: Tue, 14 Jun 2022 12:19:29 +0100
Message-ID: <YqhuwQjmZyOVSiLI@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20220608142723.103523089@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

On Wed, Jun 08, 2022 at 04:27:23PM +0200, Peter Zijlstra wrote:
> Hi All! (omg so many)

Hi Peter,

Sorry for the delay; my plate has also been rather full recently. I'm beginning
to page this in now.

> These here few patches mostly clear out the utter mess that is cpuidle vs rcuidle.
> 
> At the end of the ride there's only 2 real RCU_NONIDLE() users left
> 
>   arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());
>   drivers/perf/arm_pmu.c:                 RCU_NONIDLE(armpmu_start(event, PERF_EF_RELOAD));

The latter of these is necessary because apparently PM notifiers are called
with RCU not watching. Is that still the case today (or at the end of this
series)? If so, that feels like fertile land for more issues (yaey...). If not,
we should be able to drop this.

I can go dig into that some more.

>   kernel/cfi.c:   RCU_NONIDLE({
> 
> (the CFI one is likely dead in the kCFI rewrite) and there's only a hand full
> of trace_.*_rcuidle() left:
> 
>   kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>   kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>   kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
>   kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
>   kernel/trace/trace_preemptirq.c:                trace_preempt_enable_rcuidle(a0, a1);
>   kernel/trace/trace_preemptirq.c:                trace_preempt_disable_rcuidle(a0, a1);
> 
> All of them are in 'deprecated' code that is unused for GENERIC_ENTRY.

I think those are also unused on arm64 too?

If not, I can go attack that.

> I've touched a _lot_ of code that I can't test and likely broken some of it :/
> In particular, the whole ARM cpuidle stuff was quite involved with OMAP being
> the absolute 'winner'.
> 
> I'm hoping Mark can help me sort the remaining ARM64 bits as he moves that to
> GENERIC_ENTRY.

Moving to GENERIC_ENTRY as a whole is going to take a tonne of work
(refactoring both arm64 and the generic portion to be more amenable to each
other), but we can certainly move closer to that for the bits that matter here.

Maybe we want a STRICT_ENTRY option to get rid of all the deprecated stuff that
we can select regardless of GENERIC_ENTRY to make that easier.

> I've also got a note that says ARM64 can probably do a WFE based
> idle state and employ TIF_POLLING_NRFLAG to avoid some IPIs.

Possibly; I'm not sure how much of a win that'll be given that by default we'll
have a ~10KHz WFE wakeup from the timer, but we could take a peek.

Thanks,
Mark.
