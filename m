From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Wed, 14 Jun 2023 18:19:21 +0300
Message-ID: <20230614151921.GC52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-31-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oKLgUJU0v04exKnVlRLfg36DgfaKitNrYRBaZGTmprM=; b=FfRy5UwF7SVQKD
	xf7cp0lBQcsvPnL/bOv3J9ioFYofkS2bEC+48dqnXMMwfDyLPmfy/HJ2Sn/Xl9Lm03YtXi+g1c/SW
	8833Io8tjenKgbgEbQQZJJio8knPDOcQnNWzWV3ekz3uLUFvK5nkxD3HqlpFSGprUbNXYpl6l67Mi
	fZJesLSjSI+JdIXrXJ2vCFUsufHCCj/OJZRX4cAVJoQ+TgFyG4SWa/DiLYe0ga7WCu44FkKnJE5YQ
	42Ns7wO1Xd3AHGdaHBCDhLGezIcRzEYoxPNE5Bx7gqlgqa0NXeSDz3QDn/h/yldN8xftB1vmLHSSd
	RYXNzB3myo5dR2EOo0GA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686756000;
	bh=pvs0YVME2yJhlMmiS60aNyWkmP4h1eZnbjNjnr8k7aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpQZOD1HFnMrM9fo4KdT8pfiKgkiDnXqITSqdsPxwtYIOIx2PBHkeiXHNgWscAcgu
	 7Ludmi0rX4hJke5WXXLAQEn2uCuzmmwp55/iPdSkzGfbm3/7b6D/ARVdqBcqHg2PuT
	 IpiZPKRPo311M/7dwEqLNTB4eEbaoSqrCh9SmEM/Nh700FMYjNTJ646BJmkGOl+ViX
	 wyn9wHmVrmWWVolNGJf0+VJI/kXJrLoD+WGEjfmqa8ga4rLQqqHlxKBhJuM4wDRcU2
	 FeUYfth8UqkvYnAB19GLBf6adak/YgfNGfdLVnkPWuFE7ylBYlwtenSYSzQgRBwuNz
	 fifauRpCnWIdg==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-31-vishal.moola@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert+renesas@glider.be>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On Mon, Jun 12, 2023 at 02:04:19PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents. Also cleans up some spacing issues.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sh/include/asm/pgalloc.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index a9e98233c4d4..5d8577ab1591 100644
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -2,6 +2,7 @@
>  #ifndef __ASM_SH_PGALLOC_H
>  #define __ASM_SH_PGALLOC_H
>  
> +#include <linux/mm.h>
>  #include <asm/page.h>
>  
>  #define __HAVE_ARCH_PMD_ALLOC_ONE
> @@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
>  }
>  
> -#define __pte_free_tlb(tlb,pte,addr)			\
> -do {							\
> -	pgtable_pte_page_dtor(pte);			\
> -	tlb_remove_page((tlb), (pte));			\
> +#define __pte_free_tlb(tlb, pte, addr)				\
> +do {								\
> +	pagetable_pte_dtor(page_ptdesc(pte));			\
> +	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  } while (0)
>  
>  #endif /* __ASM_SH_PGALLOC_H */
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
