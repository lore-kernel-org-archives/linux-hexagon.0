From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 33/36] Hexagon: Platform-generic support.
Date: Wed, 17 Aug 2011 22:20:59 +0200
Message-ID: <1965116.89cf5iXWOV@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163522.946736379@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163522.946736379@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Wednesday 17 August 2011 11:35:30 Richard Kuo wrote:
> We understand that devtree is preferred for platform support and
> will be switching to that in the foreseeable future.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>
> 
> ---
>  arch/hexagon/include/asm/angel_console.h     |   24 +++
>  arch/hexagon/include/asm/clock.h             |  172 ++++++++++++++++++++++
>  arch/hexagon/include/asm/gpio.h              |   32 ++++
>  arch/hexagon/include/asm/platform.h          |   49 ++++++
>  arch/hexagon/include/asm/platform/sirc.h     |   71 +++++++++
>  arch/hexagon/platform/common/Makefile        |   12 +
>  arch/hexagon/platform/common/angel_console.c |   89 +++++++++++
>  arch/hexagon/platform/common/angel_misc.c    |   56 +++++++
>  arch/hexagon/platform/common/clock.c         |  100 ++++++++++++
>  arch/hexagon/platform/common/irq.c           |   23 ++
>  arch/hexagon/platform/common/platform.c      |   82 ++++++++++
>  arch/hexagon/platform/common/sirc.c          |  208 +++++++++++++++++++++++++++
>  12 files changed, 918 insertions(+)

I think it would be better not to start with a 'platform' directory then:
Ideally you should be able to handle all systems with a single kernel, and
so far there is only one platform.

Just move the contents into an appropriate location, and at the point in the
distant future where you need multiple platforms, split out just the parts
that are different.

Also, my feeling is that we should not merge the platform code into mainline
until it has been converted to device tree based probing.

> Index: linux-hexagon-kernel/arch/hexagon/include/asm/platform.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-hexagon-kernel/arch/hexagon/include/asm/platform.h	2011-07-20 15:19:45.035151233 -0500
> +#ifndef __PLATFORM_H
> +#define __PLATFORM_H
> +
> +extern int on_simulator;
> +extern unsigned long bootmem_lastpg;
> +
> +/* Platforms */
> +enum {
> +	PLATFORM_COMET	= 1,	/*  Comet/Simulator  */
> +};
> +
> +/*
> + * Function pointers to all our platform specific callouts
> + */
> +struct platform_ops_t {
> +	void (*register_early_console)(void);
> +	void (*clock_init)(void);
> +	void (*irq_init)(void);
> +};
> +
> +void platform_setup_ops(struct platform_ops_t *);
> +void __init comet_setup_ops(struct platform_ops_t * ops);
> +void __init amazon_setup_ops(struct platform_ops_t * ops);
> +
> +extern void __init plat_clock_init(void);
> +
> +extern void __init angel_get_command_line(char *s, unsigned n);
> +
> +#endif

The platform_ops_t structure looks a bit out of place here. I'd recommend
starting without it and just calling the appropriate functions directly,
at least as long as there is only one version anyway.

> Index: linux-hexagon-kernel/arch/hexagon/platform/common/Makefile
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-hexagon-kernel/arch/hexagon/platform/common/Makefile	2011-07-20 15:19:45.035151233 -0500
> @@ -0,0 +1,12 @@
> +
> +obj-y += platform.o irq.o
> +
> +obj-y += clock.o
> +
> +ifdef CONFIG_HEXAGON_ANGEL_TRAPS
> +obj-y += angel_misc.o angel_console.o
> +endif
> +
> +ifdef CONFIG_HEXAGON_COMET
> +obj-y += sirc.o
> +endif

The normal syntax for this is

obj-$(CONFIG_HEXAGON_ANGEL_TRAPS)	+= angel_misc.o angel_console.o
obj-$(CONFIG_HEXAGON_COMET)		+= sirc.o


> Index: linux-hexagon-kernel/arch/hexagon/platform/common/sirc.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-hexagon-kernel/arch/hexagon/platform/common/sirc.c	2011-07-20 15:19:45.035151233 -0500
> @@ -0,0 +1,208 @@
> +/*
> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.

Is this the same hardware as in arch/arm/mach-msm/sirc.c?
If so, better merge the drivers and put them into a common location.
There was some talk of starting a drivers/irqchip/ directory for interrupt
controller drivers that are not architecture specific.

	Arnd
