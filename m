From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 29/34] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Mon, 01 May 2023 13:59:24 -0700 (PDT)
Message-ID: <mhng-e6f12727-9abe-4a93-a361-15a6cd333f51@palmer-ri-x1c9a>
References: <20230501192829.17086-30-vishal.moola@gmail.com>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682974766; x=1685566766;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56zwdsQPzBA4Fq57F7zZq8xm3cbpRSpnOmcnA0Dh+zY=;
        b=dhuoKYDmXvVL9rcvID9l7RqV772Z8lTC+U0WXQUi0tYJbLE9a48GrmSzQs7bEghGbC
         JAz8rXoL1w4B9KKuEwX7POjH3Ox3r6V4zpIxvsvZpSsylQJD8ptmZ7+Vz+V8jAHJj04w
         T6FV37TSFDDCD7el69cwAEuuEXi6g8EgNvIcALlfkGBQgAio2kQ2a6bJAUGpYJRLsZzz
         ZNQyL545JSX++O1LCUyCJsybjwMgrDioUAedrjXfVSqEM2lGIt3XAkC5ujMjWrYDbKAU
         lx6fFu18ULaY/km5rliSpJC6ISEyi513He8uKlna726VX+0Zf3a2zrJJ6SJgvgEWorgq
         velw==
In-Reply-To: <20230501192829.17086-30-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, vishal.moola@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>

On Mon, 01 May 2023 12:28:24 PDT (-0700), vishal.moola@gmail.com wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
>
> Some of the functions use the *get*page*() helper functions. Convert
> these to use ptdesc_alloc() and ptdesc_address() instead to help
> standardize page tables further.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/riscv/include/asm/pgalloc.h |  8 ++++----
>  arch/riscv/mm/init.c             | 16 ++++++----------
>  2 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 59dc12b5b7e8..cb5536403bd8 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -153,10 +153,10 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
> -#define __pte_free_tlb(tlb, pte, buf)   \
> -do {                                    \
> -	pgtable_pte_page_dtor(pte);     \
> -	tlb_remove_page((tlb), pte);    \
> +#define __pte_free_tlb(tlb, pte, buf)			\
> +do {							\
> +	ptdesc_pte_dtor(page_ptdesc(pte));		\
> +	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
>  } while (0)
>  #endif /* CONFIG_MMU */
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index eb8173a91ce3..8f1982664687 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -353,12 +353,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
>
>  static phys_addr_t __init alloc_pte_late(uintptr_t va)
>  {
> -	unsigned long vaddr;
> -
> -	vaddr = __get_free_page(GFP_KERNEL);
> -	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)));
> +	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
>
> -	return __pa(vaddr);
> +	BUG_ON(!ptdesc || !ptdesc_pte_ctor(ptdesc));
> +	return __pa((pte_t *)ptdesc_address(ptdesc));
>  }
>
>  static void __init create_pte_mapping(pte_t *ptep,
> @@ -436,12 +434,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
>
>  static phys_addr_t __init alloc_pmd_late(uintptr_t va)
>  {
> -	unsigned long vaddr;
> -
> -	vaddr = __get_free_page(GFP_KERNEL);
> -	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page(vaddr)));
> +	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
>
> -	return __pa(vaddr);
> +	BUG_ON(!ptdesc || !ptdesc_pmd_ctor(ptdesc));
> +	return __pa((pmd_t *)ptdesc_address(ptdesc));
>  }
>
>  static void __init create_pmd_mapping(pmd_t *pmdp,

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
