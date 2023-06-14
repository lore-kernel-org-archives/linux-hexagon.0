From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 01/34] mm: Add PAGE_TYPE_OP folio functions
Date: Wed, 14 Jun 2023 16:02:07 +0300
Message-ID: <20230614130207.GZ52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-2-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686747764;
        bh=Z0S2d/Eru6a8jIIub+wJj2QGnnAEIe7xODp5r4XEjY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ij1kaX2f2DmI7HK85FkEb/euMvHbhk1Yl6Bfkym5Y/V3n55SCcwdtHPiMl/Uaznfq
         /JPBcReV4N5cCfLGrjl0lmP3t1/xIRQ0sNu8SuNRKfJvFTG3ehEI7XrnyZzzj/mq5Z
         LIzsfSZJkFEA+VFk5od8SUJmz7a2MZahKi7y83tUViVFyHKqtoU7QmKJKuQUMruG+3
         ZBcXEtH/BdXI8p8nle54zxP2rJXEAQvrH6UElVJeso6ar3qrgbKRU7tK7ulw5ExB7M
         3MJes9iMWx7TD3tX2qF3/3jOSJV75iRXzB8fjYUsip9RPr0GERlktBmW7yBKguUpKQ
         +EDy1u2Ox8vrA==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-2-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

On Mon, Jun 12, 2023 at 02:03:50PM -0700, Vishal Moola (Oracle) wrote:
> No folio equivalents for page type operations have been defined, so
> define them for later folio conversions.
> 
> Also changes the Page##uname macros to take in const struct page* since
> we only read the memory here.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/page-flags.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 92a2063a0a23..e99a616b9bcd 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -908,6 +908,8 @@ static inline bool is_page_hwpoison(struct page *page)
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> +#define folio_test_type(folio, flag)					\
> +	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>  
>  static inline int page_type_has_type(unsigned int page_type)
>  {
> @@ -920,20 +922,34 @@ static inline int page_has_type(struct page *page)
>  }
>  
>  #define PAGE_TYPE_OPS(uname, lname)					\
> -static __always_inline int Page##uname(struct page *page)		\
> +static __always_inline int Page##uname(const struct page *page)		\
>  {									\
>  	return PageType(page, PG_##lname);				\
>  }									\
> +static __always_inline int folio_test_##lname(const struct folio *folio)\
> +{									\
> +	return folio_test_type(folio, PG_##lname);			\
> +}									\
>  static __always_inline void __SetPage##uname(struct page *page)		\
>  {									\
>  	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
>  	page->page_type &= ~PG_##lname;					\
>  }									\
> +static __always_inline void __folio_set_##lname(struct folio *folio)	\
> +{									\
> +	VM_BUG_ON_FOLIO(!folio_test_type(folio, 0), folio);		\
> +	folio->page.page_type &= ~PG_##lname;				\
> +}									\
>  static __always_inline void __ClearPage##uname(struct page *page)	\
>  {									\
>  	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
>  	page->page_type |= PG_##lname;					\
> -}
> +}									\
> +static __always_inline void __folio_clear_##lname(struct folio *folio)	\
> +{									\
> +	VM_BUG_ON_FOLIO(!folio_test_##lname(folio), folio);		\
> +	folio->page.page_type |= PG_##lname;				\
> +}									\
>  
>  /*
>   * PageBuddy() indicates that the page is free and in the buddy system
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
