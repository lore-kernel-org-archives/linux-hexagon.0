From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
Date: Thu, 24 Feb 2022 09:41:29 +0100
Message-ID: <CAK8P3a3Q6=yzX5hKX45=U80SoUXLU59sFqz-tN6U=Fr5t1m96Q@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
 <YhdB7tNDvtsYLUzr@antec>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645692107;
        bh=3OZhY8JjlWpvQtjxNVEtkpMscELhOM136ShyKCOjsEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IUh0x46q8STA6HKAlbLTizD8XGO+kXYr3toRmLVEmVGpouO/H6aYQ8xiLiANw2a+u
         HCL4KnuaohqNkiXxcP1D+/lRJl3QntwyWsCstJnQVu8ONZ3jI6BlSUPzyejrcAPQZV
         +nzKG39Q20gmRhX85bUsq4p1JphZ4DTJi1MSq5KJ4gkH6JLtlV5bg4qOHXvgO90+wI
         G81tJHNMGlOmgb18Uj2i0lzpFYLeKAgba5P0poH7ixneTHE+747gTxVEDOdEreg2CS
         CWeIv3qxk2GxmOqug9TFXr2ZvmxluPekB2kCL2kCQbjWzVYCFZXOv5nSavxW7y+xxm
         sJyHKVwF8yVng==
In-Reply-To: <YhdB7tNDvtsYLUzr@antec>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.a>

On Thu, Feb 24, 2022 at 9:29 AM Stafford Horne <shorne@gmail.com> wrote:

> > -
> > -#define access_ok(addr, size)                                                \
> > -({                                                                   \
> > -     __chk_user_ptr(addr);                                           \
> > -     __range_ok((unsigned long)(addr), (size));                      \
> > -})
> > +#include <asm-generic/access_ok.h>
>
> I was going to ask why we are missing __chk_user_ptr in the generic version.
> But this is basically now a no-op so I think its OK.

Correct, the type checking is implied by making __access_ok() an inline
function that takes a __user pointer.

> Acked-by: Stafford Horne <shorne@gmail.com> [openrisc, asm-generic]

Thanks!

       Arnd
