From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 15/34] x86: Convert various functions to use ptdescs
Date: Wed, 14 Jun 2023 17:27:26 +0300
Message-ID: <20230614142726.GN52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-16-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686752884;
        bh=IAb9vqJ9ElNCqXJHA6Yv2u0lekZ+I9QDT850CHa542c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sb9Bicm006MQRaA2QJZIqPZuQdkLyF04mr929/fVCvQ7YypT0tAJ1UO18LeBHpTwB
         Rvh5Rz8gbGxaZSahDSeiH9r0Yz3iKE+GmnXF2aA2Dm48smesHM0aIKruGgo2DEo1bH
         yqBW4/hs/er7nkcZiUCTdpNMlb1ecIjI20wO5qfSFQMgO7IjC/Z6OtB7JPDuSoqyDB
         PbEWexd4YMPKGr9SzIWRiVHkqq5QUZvrMkkQ/1wJzpzgtjaQjy7CDpiRl5H1nDBjjg
         IRNGeQrV6izw2mQTgitk3o+/EZj4A4fQLPaXmWJkD+f2zPWe6D7L/cRZD+jKRK3gcE
         G59EadJXPqFYg==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-16-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Dave Hansen <dave.hansen@linux.intel.com>

On Mon, Jun 12, 2023 at 02:04:04PM -0700, Vishal Moola (Oracle) wrote:
> In order to split struct ptdesc from struct page, convert various
> functions to use ptdescs.
> 
> Some of the functions use the *get*page*() helper functions. Convert

Nit:                           *get_free_page*()

> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.

More importantly, get_free_pages() ensures a page won't be allocated from
HIGHMEM, and for 32-bits this is a must.
 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/x86/mm/pgtable.c | 46 +++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 15a8009a4480..6da7fd5d4782 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -52,7 +52,7 @@ early_param("userpte", setup_userpte);
>  
>  void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
>  {
> -	pgtable_pte_page_dtor(pte);
> +	pagetable_pte_dtor(page_ptdesc(pte));
>  	paravirt_release_pte(page_to_pfn(pte));
>  	paravirt_tlb_remove_table(tlb, pte);
>  }
> @@ -60,7 +60,7 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
>  #if CONFIG_PGTABLE_LEVELS > 2
>  void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>  {
> -	struct page *page = virt_to_page(pmd);
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
>  	paravirt_release_pmd(__pa(pmd) >> PAGE_SHIFT);
>  	/*
>  	 * NOTE! For PAE, any changes to the top page-directory-pointer-table
> @@ -69,8 +69,8 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>  #ifdef CONFIG_X86_PAE
>  	tlb->need_flush_all = 1;
>  #endif
> -	pgtable_pmd_page_dtor(page);
> -	paravirt_tlb_remove_table(tlb, page);
> +	pagetable_pmd_dtor(ptdesc);
> +	paravirt_tlb_remove_table(tlb, ptdesc_page(ptdesc));
>  }
>  
>  #if CONFIG_PGTABLE_LEVELS > 3
> @@ -92,16 +92,16 @@ void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
>  
>  static inline void pgd_list_add(pgd_t *pgd)
>  {
> -	struct page *page = virt_to_page(pgd);
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
>  
> -	list_add(&page->lru, &pgd_list);
> +	list_add(&ptdesc->pt_list, &pgd_list);
>  }
>  
>  static inline void pgd_list_del(pgd_t *pgd)
>  {
> -	struct page *page = virt_to_page(pgd);
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
>  
> -	list_del(&page->lru);
> +	list_del(&ptdesc->pt_list);
>  }
>  
>  #define UNSHARED_PTRS_PER_PGD				\
> @@ -112,12 +112,12 @@ static inline void pgd_list_del(pgd_t *pgd)
>  
>  static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
>  {
> -	virt_to_page(pgd)->pt_mm = mm;
> +	virt_to_ptdesc(pgd)->pt_mm = mm;
>  }
>  
>  struct mm_struct *pgd_page_get_mm(struct page *page)
>  {
> -	return page->pt_mm;
> +	return page_ptdesc(page)->pt_mm;
>  }
>  
>  static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)
> @@ -213,11 +213,14 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
>  static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>  {
>  	int i;
> +	struct ptdesc *ptdesc;
>  
>  	for (i = 0; i < count; i++)
>  		if (pmds[i]) {
> -			pgtable_pmd_page_dtor(virt_to_page(pmds[i]));
> -			free_page((unsigned long)pmds[i]);
> +			ptdesc = virt_to_ptdesc(pmds[i]);
> +
> +			pagetable_pmd_dtor(ptdesc);
> +			pagetable_free(ptdesc);
>  			mm_dec_nr_pmds(mm);
>  		}
>  }
> @@ -232,16 +235,21 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>  		gfp &= ~__GFP_ACCOUNT;
>  
>  	for (i = 0; i < count; i++) {
> -		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
> -		if (!pmd)
> +		pmd_t *pmd = NULL;
> +		struct ptdesc *ptdesc = pagetable_alloc(gfp, 0);
> +
> +		if (!ptdesc)
>  			failed = true;
> -		if (pmd && !pgtable_pmd_page_ctor(virt_to_page(pmd))) {
> -			free_page((unsigned long)pmd);
> -			pmd = NULL;
> +		if (ptdesc && !pagetable_pmd_ctor(ptdesc)) {
> +			pagetable_free(ptdesc);
> +			ptdesc = NULL;
>  			failed = true;
>  		}
> -		if (pmd)
> +		if (ptdesc) {
>  			mm_inc_nr_pmds(mm);
> +			pmd = ptdesc_address(ptdesc);
> +		}
> +
>  		pmds[i] = pmd;
>  	}
>  
> @@ -830,7 +838,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  
>  	free_page((unsigned long)pmd_sv);
>  
> -	pgtable_pmd_page_dtor(virt_to_page(pmd));
> +	pagetable_pmd_dtor(virt_to_ptdesc(pmd));
>  	free_page((unsigned long)pmd);
>  
>  	return 1;
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
