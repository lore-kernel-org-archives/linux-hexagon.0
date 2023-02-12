From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Date: Sun, 12 Feb 2023 18:26:06 +0200
Message-ID: <Y+kTHsaq8FAG72CX@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676219190;
        bh=PHaVWIiDiKuPiyj9CpZVeYgSGEpSXGrmMvcZSQN2a1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHZ1dOpcNlciKJV60ceMatG/ln4gwqhaZjp3ZE5RHjwYiIsNbKgPfiLOmHrkEtBNT
         0LBqZ54vZ15wL/dO9fbXmNbGA5IZXywhsLgmuVeT8Mxh6nsVQ2XXz5mIslqXmGe9/g
         AzIa8vrmuhuYMA0WsrKUzqY1iJ2X6VnzRjkJW1xeJOjb+i+e+3nJ6w3tM54rnCLk9r
         bZn+yK6CEohAWfFi7LJuH0EYEVZLCz4dM4UGrtoZL997U+pcfquEEXsVB3fsWZbkQi
         9pDJGG+mrF8objq54yFjgqFeB5zDvEOjRdynh9jYkrT7/GybhbLGr2AHJa/rTTFxa0
         QsuwvU4Larsqw==
Content-Disposition: inline
In-Reply-To: <20230212161320.GA3784076@roeck-us.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel>

Hi Guenter,

On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
> On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Every architecture that supports FLATMEM memory model defines its own
> > version of pfn_valid() that essentially compares a pfn to max_mapnr.
> > 
> > Use mips/powerpc version implemented as static inline as a generic
> > implementation of pfn_valid() and drop its per-architecture definitions.
> > 
> 
> With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
> Reverting this patch fixes the problem.
 
Can you please test with only partial revert for arch/sh?

> Guenter

-- 
Sincerely yours,
Mike.
