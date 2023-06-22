From: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Thu, 22 Jun 2023 17:05:13 -0500
Message-ID: <bf396b3f-a3f3-817e-8241-222591f88c97@kernel.org>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687471516;
        bh=dnifwmEwN5EPVqltpiQCF3MdFT37QyzPJA5VU9yHeeQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RzL6J1fXaBDz0XMnNSx8x8mXcyvopQkvOXbep39IPzJX6IZTiyxdwE2nHfhbPls3L
         N+mS72rPbV5Hplxc5fgNpJiDPbV/HNUcjlNM0k72bojGJ4KjFY1InlFqwVw3x6nnQC
         91+lFDGDXPX57EeoiKgvynYAipkz9J96TnpYMaik9KnCYZuHYn0BitFhgrP4G1fgbY
         6R4Jpwcj42qDrlJ2D+uH33pP6SPXmc0IbmA4+yG9XAiy7RYgb0iOqdFeCCR7TQblLZ
         fmEHl1XvZkPJVwZHZ1ypNXpY1N8YMHO70VuR9LvpNAy1Wj1k/paRgs0NZSlBf4+f5g
         0uQe2Ka6aNE0g==
Content-Language: en-US
In-Reply-To: <20230622205745.79707-27-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>



On 6/22/23 15:57, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/nios2/include/asm/pgalloc.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index ecd1657bb2ce..ce6bb8e74271 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>   
>   extern pgd_t *pgd_alloc(struct mm_struct *mm);
>   
> -#define __pte_free_tlb(tlb, pte, addr)				\
> -	do {							\
> -		pgtable_pte_page_dtor(pte);			\
> -		tlb_remove_page((tlb), (pte));			\
> +#define __pte_free_tlb(tlb, pte, addr)					\
> +	do {								\
> +		pagetable_pte_dtor(page_ptdesc(pte));			\
> +		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>   	} while (0)
>   
>   #endif /* _ASM_NIOS2_PGALLOC_H */

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
