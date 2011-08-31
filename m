From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 17/35] Hexagon: Add interrupts
Date: Wed, 31 Aug 2011 15:50:23 +0200
Message-ID: <201108311550.23240.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190801.353140948@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190801.353140948@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +
> +/* Number of first-level interrupts associated with the CPU core. */
> +#define HEXAGON_CPUINTS 32
> +
> +/*
> + * XXX TODO FIXME this should be pulled from a platform file!
> + * Must define NR_IRQS before including <asm-generic/irq.h>
> + * 64 == the two SIRC's, 176 == the two gpio's
> + */
> +#define NR_IRQS (HEXAGON_CPUINTS + 64 + 176)

I disagree with that comment: NR_IRQS is a constant and should
not be platform specific. There should be no compile-time settings
that are strictly specific to one platform, otherwise you are not
able to run the same kernel on multiple platforms, which is very
valuable for testing purposes.

Just make the constant large enough to always fit. Use sparse IRQs
if necessary.

> +#include <asm-generic/irq.h>
> +
> +extern void __init hexagon_cpu_irq_init(void);
> +

I don't think you actually need to declare hexagon_cpu_irq_init(), just
rename that function to init_IRQ() and remove the wrapper.

	Arnd
