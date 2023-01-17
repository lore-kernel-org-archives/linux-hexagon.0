From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Date: Tue, 17 Jan 2023 12:39:31 +0000
Message-ID: <20230117123931.3ocl3ckkf72kusbz@bogus>
References: <20230112194314.845371875@infradead.org>
 <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
 <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.co

On Tue, Jan 17, 2023 at 11:26:29AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 16, 2023 at 04:59:04PM +0000, Mark Rutland wrote:
> 
> > I'm sorry to have to bear some bad news on that front. :(
> 
> Moo, something had to give..
> 
> 
> > IIUC what's happenign here is the PSCI cpuidle driver has entered idle and RCU
> > is no longer watching when arm64's cpu_suspend() manipulates DAIF. Our
> > local_daif_*() helpers poke lockdep and tracing, hence the call to
> > trace_hardirqs_off() and the RCU usage.
> 
> Right, strictly speaking not needed at this point, IRQs should have been
> traced off a long time ago.
> 
> > I think we need RCU to be watching all the way down to cpu_suspend(), and it's
> > cpu_suspend() that should actually enter/exit idle context. That and we need to
> > make cpu_suspend() and the low-level PSCI invocation noinstr.
> > 
> > I'm not sure whether 32-bit will have a similar issue or not.
> 
> I'm not seeing 32bit or Risc-V have similar issues here, but who knows,
> maybe I missed somsething.
> 
> In any case, the below ought to cure the ARM64 case and remove that last
> known RCU_NONIDLE() user as a bonus.
>

Thanks for the fix. I tested the series and did observe the same splat
with both DT and ACPI boot(they enter idle in different code paths). Thanks
to Mark for reminding me about ACPI. With this fix, I see the splat is
gone in both DT(cpuidle-psci.c) and ACPI(acpi_processor_idle.c).

You can add:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
