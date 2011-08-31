From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 18/35] Hexagon: Add time and timer functions
Date: Wed, 31 Aug 2011 16:04:52 +0200
Message-ID: <201108311604.52634.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190801.448257740@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190801.448257740@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

> +#ifdef CONFIG_SMP
> +void setup_percpu_clockdev(void);
> +void ipi_timer(void);
> +#endif

You should never need to wrap declarations with #ifdef like this.

> +
> +#ifndef _ASM_TIMER_REGS_H
> +#define _ASM_TIMER_REGS_H
> +
> +/*  This stuff should go into a platform specific file  */
> +#define TCX0_CLK_RATE		19200
> +#define TIMER_ENABLE		0
> +#define TIMER_CLR_ON_MATCH	1

Same comment as for NR_IRQS. If this is platform specific, it should
not be a compile-time constant.


>+/*
>+ * For now, hard wire the simulated CPU/pcycle frequency.
>+ * XXX TODO fish it out of device tree!
>+ */
>+#define CPU_MHZ 600
>+
>+static struct resource rtos_timer_resources[] = {
>+       {
>+               .start  = RTOS_TIMER_REGS_ADDR,
>+               .end    = RTOS_TIMER_REGS_ADDR+PAGE_SIZE-1,
>+               .flags  = IORESOURCE_MEM,
>+       },
>+};

Yes, please do get it out of the device tree before merging the driver
upstream.

> +/*  A lot of this stuff should move into a platform specific section.  */
> +struct adsp_hw_timer_struct {
> +	unsigned int match;   /*  Match value  */
> +	unsigned int count;
> +	unsigned int enable;  /*  [1] - CLR_ON_MATCH_EN, [0] - EN  */
> +	unsigned int clear;   /*  one-shot register that clears the count  */
> +};
> +
> +/*  Look for "TCX0" for related constants.  */
> +static volatile struct adsp_hw_timer_struct *rtos_timer = (void *) 0x0;

There are multiple things wrong with this:

* No need to initialize static variables to zero

* This is an MMIO register, so the pointer must be "__iomem", not "volatile",
  see Documentation/volatile-considered-harmful.txt

* You should have found this when building with 'make C=1' using sparse.
  I would hope that all your code was compiled this way to find common
  errors. If not, please do so now.

* Use u32 instead of unsigned int when describing hardware structures.
  They are always identical, but u32 is more descriptive. Alternatively,
  use no structure at all but constant register numbers.

> +static struct clock_event_device hexagon_clockevent_dev = {
> +	.name		= "clockevent",
> +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> +	.rating		= 400,
> +	.shift		= 32,
> +	.irq		= RTOS_TIMER_INT,
> +	.set_next_event = set_next_event,
> +	.set_mode	= set_mode,
> +#ifdef CONFIG_SMP
> +	.broadcast	= broadcast
> +#endif
> +};

Always put a comma at the last entry, to allow adding more members
as necessary.

> +/*
> + * time_init_deferred - called by start_kernel to set up timer/clock source
> + *
> + * Install the IRQ handler for the clock, setup timers.
> + * This is done late, as that way, we can use ioremap().
> + *
> + * This runs just before the delay loop is calibrated, and
> + * is used for delay calibration.
> + */
> +void __init time_init_deferred(void)
> +{
> +	struct resource *resource = NULL;
> +	struct clock_event_device *ce_dev = &hexagon_clockevent_dev;
> +	struct device_node *dn;
> +	struct resource r;
> +	int err;
> +
> +#ifdef CONFIG_SMP
> +	ce_dev->cpumask = cpu_all_mask;
> +#else
> +	ce_dev->cpumask = cpumask_of(0);
> +#endif

No need for the #ifdef AFAICT, because the two cases are the same.

> +	if (!resource)
> +		resource = rtos_timer_device.resource;
> +
> +	/*  ioremap here means this has to run later, after paging init  */
> +	rtos_timer = ioremap(resource->start, resource->end
> +		- resource->start + 1);

When the device is in the device tree, you can simplify this a lot
by using of_iomap().

> +void __udelay(unsigned long usecs)
> +{
> +	unsigned long long start = __vmgettime();
> +	unsigned long long finish = (CPU_MHZ * usecs) - fudgefactor;
> +
> +	while ((__vmgettime() - start) < finish)
> +		; /*  not sure how this improves readability  */
> +}

Better use cpu_relax() or a direct hypervisor yield call here instead of
the ';'. It should improve both readability and power consumption during
long delays.

	Arnd
