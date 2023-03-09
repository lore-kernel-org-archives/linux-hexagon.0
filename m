From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Date: Thu, 9 Mar 2023 15:36:21 +0100
Message-ID: <20230309143621.GA12350@alpha.franken.de>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20230308130710.368085-4-bhe@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, Mar 08, 2023 at 09:07:09PM +0800, Baoquan He wrote:
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior. So remove the ioremap_uc() definition in architecutures
> other than x86 and ia64. These architectures all have asm-generic/io.h
> included and will have the default ioremap_uc() definition which
> returns NULL.
> 
> This changes the existing behaviour, while no need to worry about
> any breakage because in the only callsite of ioremap_uc(), code
> has been adjusted to eliminate the impact. Please see
> atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
> 
> If any new invocation of ioremap_uc() need be added, please consider
> using ioremap() intead or adding a ARCH specific version if necessary.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  Documentation/driver-api/device-io.rst | 9 +++++----
>  arch/alpha/include/asm/io.h            | 1 -
>  arch/hexagon/include/asm/io.h          | 3 ---
>  arch/m68k/include/asm/kmap.h           | 1 -
>  arch/mips/include/asm/io.h             | 1 -
>  arch/parisc/include/asm/io.h           | 2 --
>  arch/powerpc/include/asm/io.h          | 1 -
>  arch/sh/include/asm/io.h               | 2 --
>  arch/sparc/include/asm/io_64.h         | 1 -
>  9 files changed, 5 insertions(+), 16 deletions(-)

this doesn't apply to v6.3-rc1... what tree is this based on ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
