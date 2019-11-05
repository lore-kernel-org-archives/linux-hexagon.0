From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 07/21] parisc: remove __ioremap
Date: Tue, 5 Nov 2019 15:29:05 +0100
Message-ID: <23dd12c1-8af2-dd97-18f2-da3203d49a48@gmx.de>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xU3/SjnYc0vg7m6PuBiA0Ngr6pnFCRlsKlRt8Wybdhc=; b=Pg1/QobcgImx9r
	BDXRChwaVmlUb6Ixfn6PZChZLZOn1pJIWWtBHDwhi4u4VrEZKsC9vakwQgzbtT9+lkSulTq6lkurN
	lkplav1wu6UeG2jdoWFAZtaXWmP7LJtggGC+kw1dOj0/UblRW04AmJc0/u1kAETP2yzl/jSQ4QWGC
	pWKEjVbR3JV7bLFa+8iBqOpPubntjXNwPEuTsnTVj1P0atDzGHIMp5fMPviLqKMY/xVbTquSjSimc
	UgnpT3EQcrzuW9y3fdq4zBuO6aHceCwRDcgZxlpCW3kL3c+oJ5Wj+y81MJel4YIOWeJc3SIlVeRTl
	wAhSIfcrI70beeYu7mdA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1572964151;
 bh=1ccRhMfOjQfCWgxZtJzM4hP1zgDfrNPilzzEdo9nVpk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Y0fiQZVlL53W17TOlZbi6XyMv5zjwVPRrWuOHJMTc50mzth8UTL/m2E1lYcbSheEF
 8jorhA7eYWbpK5PWaPEPGi/wJtl+L33sVAQqL300Yc0SHDjTKJjeHWLOB6GN35q3YS
 +a7NPrubb/JJYnsmHtwYU8sEHifg8Yl87BpLmw98=
In-Reply-To: <20191029064834.23438-8-hch@lst.de>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, nios2-dev@lists.rocketboards.org, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mtd@lists.infradead.org

On 29.10.19 07:48, Christoph Hellwig wrote:
> __ioremap is always called with the _PAGE_NO_CACHE, so fold the whole
> thing and rename it to ioremap.  This also allows to remove the special
> EISA quirk to force _PAGE_NO_CACHE.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Helge Deller <deller@gmx.de>

Helge

> ---
>  arch/parisc/include/asm/io.h | 11 +----------
>  arch/parisc/mm/ioremap.c     | 10 ++++------
>  2 files changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
> index 93d37010b375..46212b52c23e 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -127,16 +127,7 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
>  /*
>   * The standard PCI ioremap interfaces
>   */
> -
> -extern void __iomem * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
> -
> -/* Most machines react poorly to I/O-space being cacheable... Instead let's
> - * define ioremap() in terms of ioremap_nocache().
> - */
> -static inline void __iomem * ioremap(unsigned long offset, unsigned long size)
> -{
> -	return __ioremap(offset, size, _PAGE_NO_CACHE);
> -}
> +void __iomem *ioremap(unsigned long offset, unsigned long size);
>  #define ioremap_nocache(off, sz)	ioremap((off), (sz))
>  #define ioremap_wc			ioremap_nocache
>  #define ioremap_uc			ioremap_nocache
> diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
> index f29f682352f0..6e7c005aa09b 100644
> --- a/arch/parisc/mm/ioremap.c
> +++ b/arch/parisc/mm/ioremap.c
> @@ -25,7 +25,7 @@
>   * have to convert them into an offset in a page-aligned mapping, but the
>   * caller shouldn't need to know that small detail.
>   */
> -void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
> +void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
>  {
>  	void __iomem *addr;
>  	struct vm_struct *area;
> @@ -36,10 +36,8 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
>  	unsigned long end = phys_addr + size - 1;
>  	/* Support EISA addresses */
>  	if ((phys_addr >= 0x00080000 && end < 0x000fffff) ||
> -	    (phys_addr >= 0x00500000 && end < 0x03bfffff)) {
> +	    (phys_addr >= 0x00500000 && end < 0x03bfffff))
>  		phys_addr |= F_EXTEND(0xfc000000);
> -		flags |= _PAGE_NO_CACHE;
> -	}
>  #endif
>
>  	/* Don't allow wraparound or zero size */
> @@ -65,7 +63,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
>  	}
>
>  	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
> -			  _PAGE_ACCESSED | flags);
> +			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
>
>  	/*
>  	 * Mappings have to be page-aligned
> @@ -90,7 +88,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned l
>
>  	return (void __iomem *) (offset + (char __iomem *)addr);
>  }
> -EXPORT_SYMBOL(__ioremap);
> +EXPORT_SYMBOL(ioremap);
>
>  void iounmap(const volatile void __iomem *io_addr)
>  {
>
