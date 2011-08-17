From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 07/36] Hexagon: Add threadinfo
Date: Wed, 17 Aug 2011 21:37:18 +0200
Message-ID: <3022109.uYnQ9M7cUS@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163520.513397876@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163520.513397876@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:35:04 Richard Kuo wrote:

> +/*
> + * order is for __get_free_pages; see get_order()
> + */
> +
> +#ifdef CONFIG_PAGE_SIZE_4KB
> +#define THREAD_SIZE	(1<<13)
> +#define THREAD_SIZE_ORDER 1
> +#endif
> +
> +#ifdef CONFIG_PAGE_SIZE_16KB
> +#define THREAD_SIZE	(1<<14)
> +#define THREAD_SIZE_ORDER 0
> +#endif
> +
> +#ifdef CONFIG_PAGE_SIZE_64KB
> +#define THREAD_SIZE	(1<<16)
> +#define THREAD_SIZE_ORDER 0
> +#endif
> +
> +#ifdef CONFIG_PAGE_SIZE_256KB
> +#define THREAD_SIZE	(1<<18)
> +#define THREAD_SIZE_ORDER 0
> +#endif
>

If you use pages larger than 16KB, you probably want to use less than
a page for the kernel stack and use kmalloc to get it.
See arch/powerpc/include/asm/thread_info.h

> +
> +/*
> + * kmalloc is probably not appropriate because alignment seems
> + * not guaranteed out of kmalloc at all, and we assume thread_info
> + * is aligned to THREAD_SIZE all over the place, notably the switch and
> + * entry/exit routines.
> + */
> +
> +#if 0
> +#define __HAVE_ARCH_THREAD_INFO_ALLOCATOR
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +#define alloc_thread_info(tsk) \
> +	((struct thread_info *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, \
> +	THREAD_SIZE_ORDER))
> +
> +#else   /*  CONFIG_DEBUG_STACK_USAGE  */
> +#define alloc_thread_info(tsk) \
> +	((struct thread_info *)__get_free_pages(GFP_KERNEL, \
> +	THREAD_SIZE_ORDER))
> +#endif  /*  ! CONFIG_DEBUG_STACK_USAGE  */
> +

You don't have to align the thread_info if you use different implementation
of current_thread_info. One way to do it would be to have a per-cpu
variable pointing to the current thread_info and use the TLS mechanism
to point to percpu data, instead of getting the percpu offset from thread_info.

	Arnd
