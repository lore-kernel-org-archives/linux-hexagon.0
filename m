From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm, arch: add generic implementation of pfn_valid()
 for FLATMEM
Date: Wed, 25 Jan 2023 17:45:12 -0800
Message-ID: <20230125174512.ce5aed444cc8b8870825d8c2@linux-foundation.org>
References: <20230125190757.22555-1-rppt@kernel.org>
        <20230125190757.22555-4-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674697514;
        bh=7RpoJrPZS6SJcilZwJlgfOcy8VI5bDbkm1rwJIiWgGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QrUq5ATjY2oqR+jEAeForg1RvYMYo+bDZxJkpPvGEAQMtF9Wex3AsF6pj45qmjarD
         FkXgKw35BmzCytgE7GIRGvCG25LoCH1q8w/sqjuafA+hP0s/EWoOXsqZwbktTsZyRq
         n3OCsv9RwqATlbboWAh4Ya/cfUooerJ2jtkrgbTo=
In-Reply-To: <20230125190757.22555-4-rppt@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mike Rapoport <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourceforge.j>

On Wed, 25 Jan 2023 21:07:57 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
> 
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions

arm allnoconfig:

./include/asm-generic/memory_model.h:23:19: error: static declaration of 'pfn_valid' follows non-static declaration
   23 | static inline int pfn_valid(unsigned long pfn)
      |                   ^~~~~~~~~
./arch/arm/include/asm/page.h:160:12: note: previous declaration of 'pfn_valid' with type 'int(long unsigned int)'
  160 | extern int pfn_valid(unsigned long);
      |            ^~~~~~~~~


I thought of doing

--- a/arch/arm/include/asm/page.h~mm-arch-add-generic-implementation-of-pfn_valid-for-flatmem-fix
+++ a/arch/arm/include/asm/page.h
@@ -156,10 +156,6 @@ extern void copy_page(void *to, const vo
 
 typedef struct page *pgtable_t;
 
-#ifdef CONFIG_HAVE_ARCH_PFN_VALID
-extern int pfn_valid(unsigned long);
-#endif
-
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
_

but I'm seeing a pfn_valid declaration in arch/arc/include/asm/page.h
which might be a problem.

v2, please ;)
