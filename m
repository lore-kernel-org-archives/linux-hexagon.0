From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Date: Mon, 30 Jan 2023 16:06:21 +1100
Message-ID: <87o7qgsjaq.fsf@mpe.ellerman.id.au>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1675055194;
        bh=POOClJ+owuBj9sqRPRjffc3znhNYliSlDQdzT8YO/i8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L+Neft2adsFGU4wPfkdQqIkCCGEbr0KQklfStEOOSubA4D5/b8QWn1Ym/KJAv6xRm
         TUPYPpT88DNlhDmu8F6Zq0+Eg9/CqOQ7vjZ2tzDW9COm2h6kbQ9aR9CgKDe6jB7oUN
         qbkny9xOnw6qtVzbwY2BQEDmrhadqj+bjJEBVbHomTuJEKrCDFpofvG56kNiVlQ2h/
         4kZhpVx3EpSRTAM6jXtFLXQAZAY3/mQ2GHog2lMch2wJzrLcG7TkdRQuYdqLp8OdqG
         ahVRL+XE6UXObccshlEZ6yQOBI9fBlohqkPxNq06FIH8Kl9t0Zt68ScSYNpNUYJhy7
         uUVQKm0hFQMqg==
In-Reply-To: <20230129124235.209895-5-rppt@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourceforge.jp>

Mike Rapoport <rppt@kernel.org> writes:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Guo Ren <guoren@kernel.org>		# csky
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>	# LoongArch
> Acked-by: Stafford Horne <shorne@gmail.com>	# OpenRISC
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

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
