From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 21/21] dma-mapping: replace custom code with generic
 implementation
Date: Tue, 28 Mar 2023 00:25:15 +0200
Message-ID: <20230327222514.GA17904@lst.de>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-22-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-22-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich

> +static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
>  {
> +	dma_cache_wback(paddr, size);
> +}
>  
> +static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
> +{
> +	dma_cache_inv(paddr, size);
>  }

> +static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
>  {
> +	dma_cache_wback_inv(paddr, size);
> +}

There are the only calls for the three functions for each of the
involved functions.  So I'd rather rename the low-level symbols
(and drop the pointless exports for two of them) rather than adding
these wrapppers.

The same is probably true for many other architectures.

> +static inline bool arch_sync_dma_clean_before_fromdevice(void)
> +{
> +	return false;
> +}
>  
> +static inline bool arch_sync_dma_cpu_needs_post_dma_flush(void)
> +{
> +	return true;
>  }

Is there a way to cut down on this boilerplate code by just having
sane default, and Kconfig options to override them if they are not
runtime decisions?

> +#include <linux/dma-sync.h>

I can't really say I like the #include version here despite your
rationale in the commit log.  I can probably live with it if you
think it is absolutely worth it, but I'm really not in favor of it.

> +config ARCH_DMA_MARK_DCACHE_CLEAN
> +	def_bool y

What do we need this symbol for?  Unless I'm missing something it is
always enable for arm32, and only used in arm32 code.
