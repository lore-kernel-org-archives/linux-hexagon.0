From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 05/35] Hexagon: Add syscalls
Date: Wed, 31 Aug 2011 15:34:50 +0200
Message-ID: <201108311534.51001.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190800.195204162@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190800.195204162@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> +/*
> + * Many archictures support both sys_mmap and sys_mmap2, which use
> + * a common do_mmap2 function to do the work.  So long as we support
> + * only mmap2, we do it all in-line here.
> + */
> +asmlinkage int sys_mmap2(unsigned long addr, size_t len, unsigned long prot,
> +                        unsigned long flags, unsigned long fd,
> +                        unsigned long pgoff)
> +{

> +}
> +
> +/*  apparently this should only map on page boundaries  */
> +asmlinkage int sys_mmap(unsigned long addr, size_t len,
> +                       unsigned long prot, unsigned long flags,
> +                       unsigned long fd, off_t off)

The first comment doesn't make sense when you have the seconf function
as well. I thought I had commented that you should not provide either one
anyway and just use sys_mmap_pgoff() directly, like openrisc does.

It would probably be useful to change asm-generic/unistd.h to do that by
default, and change the architectures that still use mmap2 with
asm-generic/unistd.h to do a manual override.

	Arnd
