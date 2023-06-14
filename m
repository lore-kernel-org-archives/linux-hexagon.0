From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Wed, 14 Jun 2023 18:21:25 +0300
Message-ID: <20230614152125.GF52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-34-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686756123;
        bh=JJW2yi8jE1xj4PNXmFMp5BSxmEmVsW21Z/BKD3ijRqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haxUs5/rQ77/llId2yHHxl+zVtdTrLbyvMnIz3tsRFOuBfKBsufDFPpl6sJMFJSpX
         XdXGa/cXbRpEhaCxlcG6vxqZV4ZzAZgnbLFIXOUhwM8Ua9bXir/zJSNTjBAjZ03+JP
         UcP/tVhaYEkS/wXO6HoiCL3DGRWNQpiMx2frieXMXFBs/EuOP4yKcsZnjumnh7yMwt
         mljclEUSRo9j+Uj9+qbtKqWdq7GxEjZQSCnkNZEtTei1kMdLBLTj7XgI45NhwTOXr3
         4sBfJLEgvF707hwHqU6mKKWZix4M1FcPGJaAO0WdwWeDGAbdHkQfY6WNHFdb0Gm/o2
         ZyO+xqT///0Fg==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-34-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Richard Weinberger <richard@nod.at>

On Mon, Jun 12, 2023 at 02:04:22PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents. Also cleans up some spacing issues.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/um/include/asm/pgalloc.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
> index 8ec7cd46dd96..de5e31c64793 100644
> --- a/arch/um/include/asm/pgalloc.h
> +++ b/arch/um/include/asm/pgalloc.h
> @@ -25,19 +25,19 @@
>   */
>  extern pgd_t *pgd_alloc(struct mm_struct *);
>  
> -#define __pte_free_tlb(tlb,pte, address)		\
> -do {							\
> -	pgtable_pte_page_dtor(pte);			\
> -	tlb_remove_page((tlb),(pte));			\
> +#define __pte_free_tlb(tlb, pte, address)			\
> +do {								\
> +	pagetable_pte_dtor(page_ptdesc(pte));			\
> +	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  } while (0)
>  
>  #ifdef CONFIG_3_LEVEL_PGTABLES
>  
> -#define __pmd_free_tlb(tlb, pmd, address)		\
> -do {							\
> -	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
> -	tlb_remove_page((tlb),virt_to_page(pmd));	\
> -} while (0)						\
> +#define __pmd_free_tlb(tlb, pmd, address)			\
> +do {								\
> +	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
> +	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
> +} while (0)
>  
>  #endif
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
