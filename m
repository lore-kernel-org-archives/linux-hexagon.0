From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 18/34] mm: Remove page table members from struct page
Date: Wed, 14 Jun 2023 17:53:28 +0300
Message-ID: <20230614145328.GQ52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-19-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686754446;
        bh=aUxoRMWQndKzGf4Pu7KWMeOI/WoSZl9BaSxpwilOg7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZwYpBVV3Znjt/2r1/XmhShCVNutgqeq3trQicfEgjJSgiA24WGgfoHn4JPicd8He
         rS8NLkit65oXPztWCIk1plc/L0WWZ1stJCGO0xc9wMl4POqoTrOZPublJSijHPF4oz
         YlEcjE5Kwe8W73hiYvKQSbG68Y5Kyn6lFrlJJDjGKeMTC6UZAwh79rs3bU7nluQGBU
         tiS60ivJdA1OXEq/xKwuvgxelAM+i8GtKwUxe5gT00CZzdwQsaCSrG5/5u9c1vIGyV
         elULRRCAhePhL/Al9xGEtorsHTDGauC6YCgaYOxRHSZ2eYhHw9pEXNQZFB7ZzH7n03
         HSw2Jfv0l97fA==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-19-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

On Mon, Jun 12, 2023 at 02:04:07PM -0700, Vishal Moola (Oracle) wrote:
> The page table members are now split out into their own ptdesc struct.
> Remove them from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm_types.h | 14 --------------
>  include/linux/pgtable.h  |  3 ---
>  2 files changed, 17 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6161fe1ae5b8..31ffa1be21d0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -141,20 +141,6 @@ struct page {
>  		struct {	/* Tail pages of compound page */
>  			unsigned long compound_head;	/* Bit zero is set */
>  		};
> -		struct {	/* Page table pages */
> -			unsigned long _pt_pad_1;	/* compound_head */
> -			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> -			unsigned long _pt_s390_gaddr;	/* mapping */
> -			union {
> -				struct mm_struct *pt_mm; /* x86 pgds only */
> -				atomic_t pt_frag_refcount; /* powerpc */
> -			};
> -#if ALLOC_SPLIT_PTLOCKS
> -			spinlock_t *ptl;
> -#else
> -			spinlock_t ptl;
> -#endif
> -		};
>  		struct {	/* ZONE_DEVICE pages */
>  			/** @pgmap: Points to the hosting device page map. */
>  			struct dev_pagemap *pgmap;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c405f74d3875..33cc19d752b3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1019,10 +1019,7 @@ struct ptdesc {
>  TABLE_MATCH(flags, __page_flags);
>  TABLE_MATCH(compound_head, pt_list);
>  TABLE_MATCH(compound_head, _pt_pad_1);
> -TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
>  TABLE_MATCH(mapping, _pt_s390_gaddr);
> -TABLE_MATCH(pt_mm, pt_mm);
> -TABLE_MATCH(ptl, ptl);
>  #undef TABLE_MATCH
>  static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
