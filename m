From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 23/36] arm64,smp: Remove trace_.*_rcuidle() usage
Date: Tue, 14 Jun 2022 17:24:48 +0100
Message-ID: <Yqi2UGb4alCAR5s4@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.380962958@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20220608144517.380962958@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

On Wed, Jun 08, 2022 at 04:27:46PM +0200, Peter Zijlstra wrote:
> Ever since commit d3afc7f12987 ("arm64: Allow IPIs to be handled as
> normal interrupts") this function is called in regular IRQ context.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[adding Marc since he authored that commit]

Makes sense to me:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/smp.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -865,7 +865,7 @@ static void do_handle_IPI(int ipinr)
>  	unsigned int cpu = smp_processor_id();
>  
>  	if ((unsigned)ipinr < NR_IPI)
> -		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
> +		trace_ipi_entry(ipi_types[ipinr]);
>  
>  	switch (ipinr) {
>  	case IPI_RESCHEDULE:
> @@ -914,7 +914,7 @@ static void do_handle_IPI(int ipinr)
>  	}
>  
>  	if ((unsigned)ipinr < NR_IPI)
> -		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
> +		trace_ipi_exit(ipi_types[ipinr]);
>  }
>  
>  static irqreturn_t ipi_handler(int irq, void *data)
> 
> 
