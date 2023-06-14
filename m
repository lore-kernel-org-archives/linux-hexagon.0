From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 20/34] arm: Convert various functions to use ptdescs
Date: Wed, 14 Jun 2023 18:03:27 +0300
Message-ID: <20230614150327.GS52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-21-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686755045;
        bh=9A+PDe1vPCUMDrQYdu5z8EQPSeOjm0q+6tl+clXFAfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5Ugc1koC28gH2KkEPLkPoTIPNK11ApEJ+qx3mv6eyx57zInMns1iK9e2ZeYWZtaS
         d6VTROxAYi4QnXIkn3k8NB95BIGVtq/48gNq3/0I/WMA49BRIKydm5cPzbMITNJFuZ
         ukIwVNbIGFF0ylO7WubZ38JabSGFDmsGB/tgUH9+2GD4DtHbeAr300i11RRFVklrjO
         zXwlgRZnQv07KKoC7y7mb9Y81PZOH2N9ueNVcmIy2/IhSmwSzwFpOrdGsiFw0fBA3k
         Xwkm0A1j+e4mOhYVoVB8lslu0VNwTEUQ6zk7ZxZcwqL0ZAjNIDJH5uFFjVn0dxTv++
         vvViLh1xvoRTQ==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-21-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Catalin Marinas <catalin.marinas@arm.com>

On Mon, Jun 12, 2023 at 02:04:09PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> late_alloc() also uses the __get_free_pages() helper function. Convert
> this to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

One comment below.

> ---
>  arch/arm/include/asm/tlb.h | 12 +++++++-----
>  arch/arm/mm/mmu.c          |  6 +++---
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index b8cbe03ad260..f40d06ad5d2a 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -39,7 +39,9 @@ static inline void __tlb_remove_table(void *_table)
>  static inline void
>  __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
>  {
> -	pgtable_pte_page_dtor(pte);
> +	struct ptdesc *ptdesc = page_ptdesc(pte);
> +
> +	pagetable_pte_dtor(ptdesc);
>  
>  #ifndef CONFIG_ARM_LPAE
>  	/*
> @@ -50,17 +52,17 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
>  	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
>  #endif
>  
> -	tlb_remove_table(tlb, pte);
> +	tlb_remove_ptdesc(tlb, ptdesc);
>  }
>  
>  static inline void
>  __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
>  {
>  #ifdef CONFIG_ARM_LPAE
> -	struct page *page = virt_to_page(pmdp);
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
>  
> -	pgtable_pmd_page_dtor(page);
> -	tlb_remove_table(tlb, page);
> +	pagetable_pmd_dtor(ptdesc);
> +	tlb_remove_ptdesc(tlb, ptdesc);
>  #endif
>  }
>  
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 22292cf3381c..294518fd0240 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -737,11 +737,11 @@ static void __init *early_alloc(unsigned long sz)
>  
>  static void *__init late_alloc(unsigned long sz)
>  {
> -	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
> +	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, get_order(sz));
>  
> -	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
> +	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
>  		BUG();
> -	return ptr;
> +	return ptdesc;

should be

	return  ptdesc_to_virt(ptdesc);

>  }
>  
>  static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
