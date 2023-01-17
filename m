From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Date: Tue, 17 Jan 2023 14:21:40 +0000
Message-ID: <20230117142140.g423hxisv7djudof@bogus>
References: <20230112194314.845371875@infradead.org>
 <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
 <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
 <Y8afpbHtDOqAHq9M@FVFF77S0Q05N.cambridge.arm.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Y8afpbHtDOqAHq9M@FVFF77S0Q05N.cambridge.arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.

On Tue, Jan 17, 2023 at 01:16:21PM +0000, Mark Rutland wrote:
> On Tue, Jan 17, 2023 at 11:26:29AM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 16, 2023 at 04:59:04PM +0000, Mark Rutland wrote:
> > 
> > > I'm sorry to have to bear some bad news on that front. :(
> > 
> > Moo, something had to give..
> > 
> > 
> > > IIUC what's happenign here is the PSCI cpuidle driver has entered idle and RCU
> > > is no longer watching when arm64's cpu_suspend() manipulates DAIF. Our
> > > local_daif_*() helpers poke lockdep and tracing, hence the call to
> > > trace_hardirqs_off() and the RCU usage.
> > 
> > Right, strictly speaking not needed at this point, IRQs should have been
> > traced off a long time ago.
> 
> True, but there are some other calls around here that *might* end up invoking
> RCU stuff (e.g. the MTE code).
> 
> That all needs a noinstr cleanup too, which I'll sort out as a follow-up.
> 
> > > I think we need RCU to be watching all the way down to cpu_suspend(), and it's
> > > cpu_suspend() that should actually enter/exit idle context. That and we need to
> > > make cpu_suspend() and the low-level PSCI invocation noinstr.
> > > 
> > > I'm not sure whether 32-bit will have a similar issue or not.
> > 
> > I'm not seeing 32bit or Risc-V have similar issues here, but who knows,
> > maybe I missed somsething.
> 
> I reckon if they do, the core changes here give us the infrastructure to fix
> them if/when we get reports.
> 
> > In any case, the below ought to cure the ARM64 case and remove that last
> > known RCU_NONIDLE() user as a bonus.
> 
> The below works for me testing on a Juno R1 board with PSCI, using defconfig +
> CONFIG_PROVE_LOCKING=y + CONFIG_DEBUG_LOCKDEP=y + CONFIG_DEBUG_ATOMIC_SLEEP=y.
> I'm not sure how to test the LPI / FFH part, but it looks good to me.
> 
> FWIW:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Sudeep, would you be able to give the LPI/FFH side a spin with the kconfig
> options above?
> 

Not sure if I have messed up something in my mail setup, but I did reply
earlier. I did test both DT/cpuidle-psci driver and  ACPI/LPI+FFH driver
with the fix Peter sent. I was seeing same splat as you in both DT and
ACPI boot which the patch fixed it. I used the same config as described by
you above.

-- 
Regards,
Sudeep
