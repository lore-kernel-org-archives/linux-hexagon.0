From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 26 Jun 2023 22:47:49 -0700
Message-ID: <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <kvm-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687844871; x=1690436871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjTPMlxWt9nC/sXrGsrew1h8LID7KP4FRrxfXfknacs=;
        b=CKCXCuWl0gYpQ4q8YGqBYIHt4kiR1AhHpEiDPYQrq6u+C1EcCN199Rf+TEI2yZgN+R
         yHF4vksLQaZZNCW1AKLUCeBUhO/zz1T+Q9/6Dn0kQ15ZW6K5TqPmtUB9rSpHUKgxZgiA
         HSTUVKDZ4xM6L9+zGQEVzY8EH5rZJBCsvXHjcbbzvbKrE2StJxwwReSDEN5b3GfPvLfH
         eqtt0xPcEOboGwjNakJZJtyOpw0n8CltvqJLvaWUUnjMuBH5yNe38AlJDiG6mzZTOhDy
         hB/teSyin+eBzVwUgFatWumtP7LykGuBvZNNj+IJUNFfPVWNZBZUcFVQKEBMH4tHKOww
         HTig==
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Disposition: inline
In-Reply-To: <20230622205745.79707-27-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>, Mike Rapoport <rppt@kernel.org>

On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

This patch causes all nios2 builds to fail.

Building nios2:allnoconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from mm/memory.c:85:
mm/memory.c: In function 'free_pte_range':
arch/nios2/include/asm/pgalloc.h:33:17: error: implicit declaration of function 'pagetable_pte_dtor'; did you mean 'pgtable_pte_page_dtor'? [-Werror=implicit-function-declaration]
   33 |                 pagetable_pte_dtor(page_ptdesc(pte));                   \
      |                 ^~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);
      |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:33:36: error: implicit declaration of function 'page_ptdesc' [-Werror=implicit-function-declaration]
   33 |                 pagetable_pte_dtor(page_ptdesc(pte));                   \
      |                                    ^~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);
      |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:34:17: error: implicit declaration of function 'tlb_remove_page_ptdesc'; did you mean 'tlb_remove_page_size'? [-Werror=implicit-function-declaration]
   34 |                 tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
      |                 ^~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);

> ---
>  arch/nios2/include/asm/pgalloc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index ecd1657bb2ce..ce6bb8e74271 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  
>  extern pgd_t *pgd_alloc(struct mm_struct *mm);
>  
> -#define __pte_free_tlb(tlb, pte, addr)				\
> -	do {							\
> -		pgtable_pte_page_dtor(pte);			\
> -		tlb_remove_page((tlb), (pte));			\
> +#define __pte_free_tlb(tlb, pte, addr)					\
> +	do {								\
> +		pagetable_pte_dtor(page_ptdesc(pte));			\
> +		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  	} while (0)
>  
>  #endif /* _ASM_NIOS2_PGALLOC_H */
> -- 
> 2.40.1
> 
> 
