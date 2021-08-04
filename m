From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] hexagon: Clean up timer-regs.h
Date: Wed, 4 Aug 2021 11:31:13 -0700
Message-ID: <YQrc8SE+T7++BLaG@Ryzen-9-3900X.localdomain>
References: <20210728001729.1960182-1-nathan@kernel.org>
 <03bc01d783c2$52e6f200$f8b4d600$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628101876;
        bh=dA9albDNHjmnEUuUUEGet3tMJ5oUy+/d4FLXbY1CZuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpDZH+KFgtU8Kl1ygeTU2R3tMl+E6fPZohcD38Xo7eh7HCMt8/Puyi4ubAxhe2KnG
         28XE3vWuG42L4i2lyQ9h/u4c2vb0buzAnFpmSXu/HmJNWtqGl/MAxNTn3HLyRcreMM
         YQKP8TimGS58oRrGiEYi1Rxfz5dOEq8otH6HFm0VH2woLkmr2CEgz/nED/K4FH7tg3
         5w73rHNgpJ9g6aIYT1UAKziTa55o41lX39r6LSxQ3ry3ob0K1w3/EEJnjx+l6BpDym
         TuR1uWqgPf+Im1bZijzCHCuB3pbPR2A+WORn0UaMj8NO3rpaeCp/i+Vx8I1LMrdVzY
         cxvdPtBWr2xyA==
Content-Disposition: inline
In-Reply-To: <03bc01d783c2$52e6f200$f8b4d600$@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@codeaurora.org>

On Wed, Jul 28, 2021 at 10:07:45AM -0500, Brian Cain wrote:
> > -----Original Message-----
> > From: Nathan Chancellor <nathan@kernel.org>
> ...
> > When building allmodconfig, there is a warning about TIMER_ENABLE being
> > redefined:
> > 
> >  drivers/clocksource/timer-oxnas-rps.c:39:9: warning: 'TIMER_ENABLE'
> >  macro redefined [-Wmacro-redefined]
> >  #define TIMER_ENABLE            BIT(7)
> >          ^
> >  arch/hexagon/include/asm/timer-regs.h:13:9: note: previous definition
> >  is here
> >  #define TIMER_ENABLE            0
> >          ^
> >  1 warning generated.
> > 
> > The values in this header are only used in one file each, if they are
> > used at all. Remove the header and sink all of the constants into their
> > respective files.
> > 
> > TCX0_CLK_RATE is only used in arch/hexagon/include/asm/timex.h
> > 
> > TIMER_ENABLE, RTOS_TIMER_INT, RTOS_TIMER_REGS_ADDR are only used in
> > arch/hexagon/kernel/time.c.
> > 
> > SLEEP_CLK_RATE and TIMER_CLR_ON_MATCH have both been unused since
> > the
> > file's introduction in commit 71e4a47f32f4 ("Hexagon: Add time and timer
> > functions").
> > 
> > TIMER_ENABLE is redefined as BIT(0) so the shift is moved into the
> > definition, rather than its use.
> > 
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  arch/hexagon/include/asm/timer-regs.h | 26 --------------------------
> >  arch/hexagon/include/asm/timex.h      |  3 +--
> >  arch/hexagon/kernel/time.c            | 12 ++++++++++--
> >  3 files changed, 11 insertions(+), 30 deletions(-)
> >  delete mode 100644 arch/hexagon/include/asm/timer-regs.h
> > 
> > diff --git a/arch/hexagon/include/asm/timer-regs.h
> > b/arch/hexagon/include/asm/timer-regs.h
> > deleted file mode 100644
> > index ee6c61423a05..000000000000
> > --- a/arch/hexagon/include/asm/timer-regs.h
> > +++ /dev/null
> > @@ -1,26 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only */
> > -/*
> > - * Timer support for Hexagon
> > - *
> > - * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> > - */
> > -
> > -#ifndef _ASM_TIMER_REGS_H
> > -#define _ASM_TIMER_REGS_H
> > -
> > -/*  This stuff should go into a platform specific file  */
> > -#define TCX0_CLK_RATE		19200
> > -#define TIMER_ENABLE		0
> > -#define TIMER_CLR_ON_MATCH	1
> > -
> > -/*
> > - * 8x50 HDD Specs 5-8.  Simulator co-sim not fixed until
> > - * release 1.1, and then it's "adjustable" and probably not defaulted.
> > - */
> > -#define RTOS_TIMER_INT		3
> > -#ifdef CONFIG_HEXAGON_COMET
> > -#define RTOS_TIMER_REGS_ADDR	0xAB000000UL
> > -#endif
> > -#define SLEEP_CLK_RATE		32000
> > -
> > -#endif
> > diff --git a/arch/hexagon/include/asm/timex.h
> > b/arch/hexagon/include/asm/timex.h
> > index 8d4ec76fceb4..dfe69e118b2b 100644
> > --- a/arch/hexagon/include/asm/timex.h
> > +++ b/arch/hexagon/include/asm/timex.h
> > @@ -7,11 +7,10 @@
> >  #define _ASM_TIMEX_H
> > 
> >  #include <asm-generic/timex.h>
> > -#include <asm/timer-regs.h>
> >  #include <asm/hexagon_vm.h>
> > 
> >  /* Using TCX0 as our clock.  CLOCK_TICK_RATE scheduled to be removed. */
> > -#define CLOCK_TICK_RATE              TCX0_CLK_RATE
> > +#define CLOCK_TICK_RATE              19200
> > 
> >  #define ARCH_HAS_READ_CURRENT_TIMER
> > 
> > diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
> > index feffe527ac92..febc95714d75 100644
> > --- a/arch/hexagon/kernel/time.c
> > +++ b/arch/hexagon/kernel/time.c
> > @@ -17,9 +17,10 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/module.h>
> > 
> > -#include <asm/timer-regs.h>
> >  #include <asm/hexagon_vm.h>
> > 
> > +#define TIMER_ENABLE		BIT(0)
> > +
> >  /*
> >   * For the clocksource we need:
> >   *	pcycle frequency (600MHz)
> > @@ -33,6 +34,13 @@ cycles_t	pcycle_freq_mhz;
> >  cycles_t	thread_freq_mhz;
> >  cycles_t	sleep_clk_freq;
> > 
> > +/*
> > + * 8x50 HDD Specs 5-8.  Simulator co-sim not fixed until
> > + * release 1.1, and then it's "adjustable" and probably not defaulted.
> > + */
> > +#define RTOS_TIMER_INT		3
> > +#define RTOS_TIMER_REGS_ADDR	0xAB000000UL
> > +
> >  static struct resource rtos_timer_resources[] = {
> >  	{
> >  		.start	= RTOS_TIMER_REGS_ADDR,
> > @@ -80,7 +88,7 @@ static int set_next_event(unsigned long delta, struct
> > clock_event_device *evt)
> >  	iowrite32(0, &rtos_timer->clear);
> > 
> >  	iowrite32(delta, &rtos_timer->match);
> > -	iowrite32(1 << TIMER_ENABLE, &rtos_timer->enable);
> > +	iowrite32(TIMER_ENABLE, &rtos_timer->enable);
> >  	return 0;
> >  }
> > 
> > 
> > base-commit: 7d549995d4e0d99b68e8a7793a0d23da6fc40fe8
> 
> Acked-by: Brian Cain <bcain@codeaurora.org>

Thanks Brian. Andrew, if you would not mind picking this up, I would
appreciate it!

Cheers,
Nathan
