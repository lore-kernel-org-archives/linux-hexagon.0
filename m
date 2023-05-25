From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 13/34] mm: Create ptdesc equivalents for
 pgtable_{pte,pmd}_page_{ctor,dtor}
Date: Thu, 25 May 2023 12:19:00 +0300
Message-ID: <20230525091900.GY4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-14-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685006366;
        bh=wqsrR+VLdLpuPAmDdXqCVY2XwnsXyfpXvlaNwL8b95Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foE41UqPH1HgRiXHDcvmNVSgga8+6+movhrIvHcP0lKkim5d2C0CveXiAkrsugwUY
         mTMqHgjGefxYEA1DbMZBeEKmAQcDqRXgChs6yPJ6RFCubSjjaqUfXH5DibAVcYpUBA
         aCcKgzmG5mhVSa4fQNmh2lbUtoTD+weF0ODUHN0azy9cnLxTNG6czawfKdDGiZ3h9+
         eQhVfl9VDk2zYUu2V/zd6ljbuCqaKQw9PEhJG6TAu5DceAsH/0TRlb4M7Mib7O0vr6
         Y2yg35as+E26Oh74LjFv8mXxr+pdJYlNpysggvOKmpyB8i+xjdzE7MqNjdH/FF5KDP
         bMNE7SNyaBLAA==
Content-Disposition: inline
In-Reply-To: <20230501192829.17086-14-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Mon, May 01, 2023 at 12:28:08PM -0700, Vishal Moola (Oracle) wrote:
> Creates ptdesc_pte_ctor(), ptdesc_pmd_ctor(), ptdesc_pte_dtor(), and
> ptdesc_pmd_dtor() and make the original pgtable constructor/destructors
> wrappers.

I think pgtable_pXY_ctor/dtor names would be better.
 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 58c911341a33..dc61aeca9077 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2847,20 +2847,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
> -static inline bool pgtable_pte_page_ctor(struct page *page)
> +static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
>  {
> -	if (!ptlock_init(page_ptdesc(page)))
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	if (!ptlock_init(ptdesc))
>  		return false;
> -	__SetPageTable(page);
> -	inc_lruvec_page_state(page, NR_PAGETABLE);
> +	__folio_set_table(folio);
> +	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>  	return true;
>  }
>  
> +static inline bool pgtable_pte_page_ctor(struct page *page)
> +{
> +	return ptdesc_pte_ctor(page_ptdesc(page));
> +}
> +
> +static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	ptlock_free(ptdesc);
> +	__folio_clear_table(folio);
> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> +}
> +
>  static inline void pgtable_pte_page_dtor(struct page *page)
>  {
> -	ptlock_free(page_ptdesc(page));
> -	__ClearPageTable(page);
> -	dec_lruvec_page_state(page, NR_PAGETABLE);
> +	ptdesc_pte_dtor(page_ptdesc(page));
>  }
>  
>  #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
> @@ -2942,20 +2956,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
>  	return ptl;
>  }
>  
> -static inline bool pgtable_pmd_page_ctor(struct page *page)
> +static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
>  {
> -	if (!pmd_ptlock_init(page_ptdesc(page)))
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	if (!pmd_ptlock_init(ptdesc))
>  		return false;
> -	__SetPageTable(page);
> -	inc_lruvec_page_state(page, NR_PAGETABLE);
> +	__folio_set_table(folio);
> +	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>  	return true;
>  }
>  
> +static inline bool pgtable_pmd_page_ctor(struct page *page)
> +{
> +	return ptdesc_pmd_ctor(page_ptdesc(page));
> +}
> +
> +static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	pmd_ptlock_free(ptdesc);
> +	__folio_clear_table(folio);
> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> +}
> +
>  static inline void pgtable_pmd_page_dtor(struct page *page)
>  {
> -	pmd_ptlock_free(page_ptdesc(page));
> -	__ClearPageTable(page);
> -	dec_lruvec_page_state(page, NR_PAGETABLE);
> +	ptdesc_pmd_dtor(page_ptdesc(page));
>  }
>  
>  /*
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
