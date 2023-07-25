From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH mm-unstable v7 00/31] Split ptdesc from struct page
Date: Mon, 24 Jul 2023 21:41:36 -0700 (PDT)
Message-ID: <5296514f-cdd1-9526-2e83-a21e76e86e5@google.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690260106; x=1690864906;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tFc7lI8l/TAp6N4SH/RnjHMrhDjcjpOS0NvhRjK3tI=;
        b=syg9IyMH/gqJY1k4LT3S6JMx0fSLcgE37Cs+8KWCUO35fKCYg0MuLIIi0nsu37jtyV
         JWnNbNndjflxoqEknhV3drMoPO1rLP5Mf2NwuEGG3uNqc6WCc3lC70F16ZnEeLC+MDXA
         tlBtkvCExRePxNsWSrYSlIqtWo9fJaFXM7OzUrScUdzQ6XIpjZwJMknKg/XaSKKfA+Pp
         NHjPm93xL9xpQDR+q+3gjlysNDu5FD2n2xMli6SN590GUy6WkS3ghg4fMC/PcVORHv0z
         7pZwaHoSCWcs0DC0U/7aDMkjw3lDyZjRkGaSMnnCoKZ6Eh2nJ1AJW7AcIEll2MImoPAy
         2Dhg==
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>

On Mon, 24 Jul 2023, Vishal Moola (Oracle) wrote:

> The MM subsystem is trying to shrink struct page. This patchset
> introduces a memory descriptor for page table tracking - struct ptdesc.
> 
> This patchset introduces ptdesc, splits ptdesc from struct page, and
> converts many callers of page table constructor/destructors to use ptdescs.
> 
> Ptdesc is a foundation to further standardize page tables, and eventually
> allow for dynamic allocation of page tables independent of struct page.
> However, the use of pages for page table tracking is quite deeply
> ingrained and varied across archictectures, so there is still a lot of
> work to be done before that can happen.

Others may differ, but it remains the case that I see no point to this
patchset, until the minimal descriptor that replaces struct page is
working, and struct page then becomes just overhead.  Until that time,
let architectures continue to use struct page as they do - whyever not?

Hugh

> 
> This is rebased on mm-unstable.
> 
> v7:
>   Drop s390 gmap ptdesc conversions - gmap is unecessary complication
>     that can be dealt with later
>   Be more thorough with ptdesc struct sanity checks and comments
>   Rebase onto mm-unstable
> 
> Vishal Moola (Oracle) (31):
>   mm: Add PAGE_TYPE_OP folio functions
>   pgtable: Create struct ptdesc
>   mm: add utility functions for ptdesc
>   mm: Convert pmd_pgtable_page() callers to use pmd_ptdesc()
>   mm: Convert ptlock_alloc() to use ptdescs
>   mm: Convert ptlock_ptr() to use ptdescs
>   mm: Convert pmd_ptlock_init() to use ptdescs
>   mm: Convert ptlock_init() to use ptdescs
>   mm: Convert pmd_ptlock_free() to use ptdescs
>   mm: Convert ptlock_free() to use ptdescs
>   mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
>   powerpc: Convert various functions to use ptdescs
>   x86: Convert various functions to use ptdescs
>   s390: Convert various pgalloc functions to use ptdescs
>   mm: Remove page table members from struct page
>   pgalloc: Convert various functions to use ptdescs
>   arm: Convert various functions to use ptdescs
>   arm64: Convert various functions to use ptdescs
>   csky: Convert __pte_free_tlb() to use ptdescs
>   hexagon: Convert __pte_free_tlb() to use ptdescs
>   loongarch: Convert various functions to use ptdescs
>   m68k: Convert various functions to use ptdescs
>   mips: Convert various functions to use ptdescs
>   nios2: Convert __pte_free_tlb() to use ptdescs
>   openrisc: Convert __pte_free_tlb() to use ptdescs
>   riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
>   sh: Convert pte_free_tlb() to use ptdescs
>   sparc64: Convert various functions to use ptdescs
>   sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
>   um: Convert {pmd, pte}_free_tlb() to use ptdescs
>   mm: Remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers
> 
>  Documentation/mm/split_page_table_lock.rst    |  12 +-
>  .../zh_CN/mm/split_page_table_lock.rst        |  14 +-
>  arch/arm/include/asm/tlb.h                    |  12 +-
>  arch/arm/mm/mmu.c                             |   7 +-
>  arch/arm64/include/asm/tlb.h                  |  14 +-
>  arch/arm64/mm/mmu.c                           |   7 +-
>  arch/csky/include/asm/pgalloc.h               |   4 +-
>  arch/hexagon/include/asm/pgalloc.h            |   8 +-
>  arch/loongarch/include/asm/pgalloc.h          |  27 ++--
>  arch/loongarch/mm/pgtable.c                   |   7 +-
>  arch/m68k/include/asm/mcf_pgalloc.h           |  47 +++---
>  arch/m68k/include/asm/sun3_pgalloc.h          |   8 +-
>  arch/m68k/mm/motorola.c                       |   4 +-
>  arch/mips/include/asm/pgalloc.h               |  32 ++--
>  arch/mips/mm/pgtable.c                        |   8 +-
>  arch/nios2/include/asm/pgalloc.h              |   8 +-
>  arch/openrisc/include/asm/pgalloc.h           |   8 +-
>  arch/powerpc/mm/book3s64/mmu_context.c        |  10 +-
>  arch/powerpc/mm/book3s64/pgtable.c            |  32 ++--
>  arch/powerpc/mm/pgtable-frag.c                |  56 +++----
>  arch/riscv/include/asm/pgalloc.h              |   8 +-
>  arch/riscv/mm/init.c                          |  16 +-
>  arch/s390/include/asm/pgalloc.h               |   4 +-
>  arch/s390/include/asm/tlb.h                   |   4 +-
>  arch/s390/mm/pgalloc.c                        | 128 +++++++--------
>  arch/sh/include/asm/pgalloc.h                 |   9 +-
>  arch/sparc/mm/init_64.c                       |  17 +-
>  arch/sparc/mm/srmmu.c                         |   5 +-
>  arch/um/include/asm/pgalloc.h                 |  18 +--
>  arch/x86/mm/pgtable.c                         |  47 +++---
>  arch/x86/xen/mmu_pv.c                         |   2 +-
>  include/asm-generic/pgalloc.h                 |  88 +++++-----
>  include/asm-generic/tlb.h                     |  11 ++
>  include/linux/mm.h                            | 151 +++++++++++++-----
>  include/linux/mm_types.h                      |  18 ---
>  include/linux/page-flags.h                    |  30 +++-
>  include/linux/pgtable.h                       |  80 ++++++++++
>  mm/memory.c                                   |   8 +-
>  38 files changed, 585 insertions(+), 384 deletions(-)
> 
> -- 
> 2.40.1
