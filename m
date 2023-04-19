From: Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH 4/33] mm: add utility functions for ptdesc
Date: Wed, 19 Apr 2023 21:33:54 +0800
Message-ID: <ZD/syK8RYO9FZ6ks@vernon-pc>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-5-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x/sNFN2bqHt/HIOXhdphmNGhcjS/NoGI23RjVmFZe5Y=; b=l4k/dM6GINl7PF
	FbZ/BRuEaeWF1OyGjMin7czUbx6ggT3KfBWMKnFMcLMwHmQ+cUSiQ5bamGgLTweZ9a3wlgOT1HDNL
	3u28dQ4BPceM+JZIcZxBSkWAjsCl+8vKksor3+gy2hdA23+h7H5NYLB0zc7b3j5t1tkn0E06Ch9KW
	7Rr5uiFXMA14/Z6Dj9jRw1o0sI8e/ZQuMug50gzL690tqZWQrGEsYNwdeg6TF2H4i0YbE3YY7wwGJ
	n84SY86VZvkXuhJC2stFOiKoHErGWAdYb4itKszITFqwItTJ1TkPt9VyCECAxDZi5LokJxzmC10vD
	kv7VZwmsuulWwOCX3hmw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681911243; x=1684503243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxKBdJz6P62xw3o1oOHy6gvL/UmSXqmJ0vRsGDHfXz4=;
        b=mzt7zUu9/LUJvSIPaNj+nC+ArFvk3Wmz36d7P4hExfQnu/+5EJ/luadmhJCFNiq8eA
         5mamh3uH/3u0VIJzJy4W31TNXYt1DvfBn6ZHGOaQZO/LaodxyaE7yMJE8BXQrMBetDD1
         or6ct0PxWqhNSzFTI7QUR0GNkBsKZpZ79DqaN9iIdwxdDsEv8FenNeci7+RSvuikuLAT
         68J4r2aw28njQbzjpScT2QNoBA3X+SSSqlRvn9uiCaccB9t2Uwb/G4C4D/IZDIaojb9q
         azW1GR2HjveVXh0qkoLiSeS/y+b+MPHfKKr5FHg+1Fk7e61fzU4VCdWEM74x3aiYuZwi
         ZxNA==
Content-Disposition: inline
In-Reply-To: <20230417205048.15870-5-vishal.moola@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Mon, Apr 17, 2023 at 01:50:19PM -0700, Vishal Moola wrote:
> Introduce utility functions setting the foundation for ptdescs. These
> will also assist in the splitting out of ptdesc from struct page.
>
> ptdesc_alloc() is defined to allocate new ptdesc pages as compound
> pages. This is to standardize ptdescs by allowing for one allocation
> and one free function, in contrast to 2 allocation and 2 free functions.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/asm-generic/tlb.h | 11 ++++++++++
>  include/linux/mm.h        | 44 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pgtable.h   | 13 ++++++++++++
>  3 files changed, 68 insertions(+)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index b46617207c93..6bade9e0e799 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -481,6 +481,17 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>  	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>  }
>
> +static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> +{
> +	tlb_remove_table(tlb, pt);
> +}
> +
> +/* Like tlb_remove_ptdesc, but for page-like page directories. */
> +static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
> +{
> +	tlb_remove_page(tlb, ptdesc_page(pt));
> +}
> +
>  static inline void tlb_change_page_size(struct mmu_gather *tlb,
>  						     unsigned int page_size)
>  {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b18848ae7e22..ec3cbe2fa665 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2744,6 +2744,45 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
>  }
>  #endif /* CONFIG_MMU */
>
> +static inline struct ptdesc *virt_to_ptdesc(const void *x)
> +{
> +	return page_ptdesc(virt_to_head_page(x));
> +}
> +
> +static inline void *ptdesc_to_virt(struct ptdesc *pt)
> +{
> +	return page_to_virt(ptdesc_page(pt));
> +}
> +
> +static inline void *ptdesc_address(struct ptdesc *pt)
> +{
> +	return folio_address(ptdesc_folio(pt));
> +}
> +
> +static inline bool ptdesc_is_reserved(struct ptdesc *pt)
> +{
> +	return folio_test_reserved(ptdesc_folio(pt));
> +}
> +
> +static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int order)
> +{
> +	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> +
> +	return page_ptdesc(page);
> +}
> +
> +static inline void ptdesc_free(struct ptdesc *pt)
> +{
> +	struct page *page = ptdesc_page(pt);
> +
> +	__free_pages(page, compound_order(page));
> +}
> +
> +static inline void ptdesc_clear(void *x)
> +{
> +	clear_page(x);
> +}
> +
>  #if USE_SPLIT_PTE_PTLOCKS
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
> @@ -2970,6 +3009,11 @@ static inline void mark_page_reserved(struct page *page)
>  	adjust_managed_page_count(page, -1);
>  }
>
> +static inline void free_reserved_ptdesc(struct ptdesc *pt)
> +{
> +	free_reserved_page(ptdesc_page(pt));
> +}
> +
>  /*
>   * Default method to free all the __init memory into the buddy system.
>   * The freed pages will be poisoned with pattern "poison" if it's within
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 7cc6ea057ee9..7cd803aa38eb 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -97,6 +97,19 @@ TABLE_MATCH(ptl, ptl);
>  #undef TABLE_MATCH
>  static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>
> +#define ptdesc_page(pt)			(_Generic((pt),			\
> +	const struct ptdesc *:		(const struct page *)(pt),	\
> +	struct ptdesc *:		(struct page *)(pt)))
> +
> +#define ptdesc_folio(pt)		(_Generic((pt),			\
> +	const struct ptdesc *:		(const struct folio *)(pt),	\
> +	struct ptdesc *:		(struct folio *)(pt)))
> +
> +static inline struct ptdesc *page_ptdesc(struct page *page)
> +{
> +	return (struct ptdesc *)page;
> +}

Hi Vishal,

I'm a little curious, why is the page_ptdesc() using inline functions instead of macro?
If this is any magic, please tell me, thank you very much.

> +
>  /*
>   * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
>   *
>
> --
> 2.39.2
>
