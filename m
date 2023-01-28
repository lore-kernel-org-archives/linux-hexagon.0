From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 3/3] mm, arch: add generic implementation of pfn_valid()
 for FLATMEM
Date: Sat, 28 Jan 2023 18:02:13 +0900
Message-ID: <Y9TklS4v8oHCvCu2@antec>
References: <20230125190757.22555-1-rppt@kernel.org>
 <20230125190757.22555-4-rppt@kernel.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7ARCz3cVaBFOjYkC77qL/HBEniL1qdQHS5E6K6GFOY=;
        b=aqbRojTHRCVjzGUAj7OwNNFidQtZRaRDHHmAjBWeAFhAl4EP6lU/HQ+DT3lz3ORLRs
         krDbFNMyaAoPDNNbr2Us4LfdqxvtQoKw/VqPFwWdtmeZaX2Yr/xMNSAvUp0bHiLiSOj3
         SN1iYBMZrJW6Tuoe05d5ixjoXDQyxOx+hHgkYRdk2YredIT5D868vyI7+JtGnCIwsINP
         AC8gyFLqm6XouHJKilNfBj6iNxK7cGu1Nhc9VlLOm0nqQCpyycdmijDtgityKjfCFibc
         kBECjMNCFbqcxj8dsEQrghcf75B90yP81hRDkvCSROQeKfuHc3hus0w8nNDlJyMcHou/
         rQVg==
Content-Disposition: inline
In-Reply-To: <20230125190757.22555-4-rppt@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourc>

On Wed, Jan 25, 2023 at 09:07:57PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
> 
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/alpha/include/asm/page.h      |  4 ----
>  arch/arc/include/asm/page.h        |  1 -
>  arch/csky/include/asm/page.h       |  1 -
>  arch/hexagon/include/asm/page.h    |  1 -
>  arch/ia64/include/asm/page.h       |  4 ----
>  arch/loongarch/include/asm/page.h  | 13 -------------
>  arch/m68k/include/asm/page_no.h    |  2 --
>  arch/microblaze/include/asm/page.h |  1 -
>  arch/mips/include/asm/page.h       | 13 -------------
>  arch/nios2/include/asm/page.h      |  9 ---------
>  arch/openrisc/include/asm/page.h   |  2 --
>  arch/parisc/include/asm/page.h     |  4 ----
>  arch/powerpc/include/asm/page.h    |  9 ---------
>  arch/riscv/include/asm/page.h      |  5 -----
>  arch/sh/include/asm/page.h         |  3 ---
>  arch/sparc/include/asm/page_32.h   |  1 -
>  arch/um/include/asm/page.h         |  1 -
>  arch/x86/include/asm/page_32.h     |  4 ----
>  arch/x86/include/asm/page_64.h     |  4 ----
>  arch/xtensa/include/asm/page.h     |  2 --
>  include/asm-generic/memory_model.h | 12 ++++++++++++
>  include/asm-generic/page.h         |  2 --
>  22 files changed, 12 insertions(+), 86 deletions(-)
> 
[...] 
> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> index aab6e64d6db4..52b0d7e76446 100644
> --- a/arch/openrisc/include/asm/page.h
> +++ b/arch/openrisc/include/asm/page.h
> @@ -80,8 +80,6 @@ typedef struct page *pgtable_t;
>  
>  #define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
>  
> -#define pfn_valid(pfn)          ((pfn) < max_mapnr)
> -
>  #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
>  
>  #endif /* __ASSEMBLY__ */

For OpenRISC

Acked-by: Stafford Horne <shorne@gmail.com>
