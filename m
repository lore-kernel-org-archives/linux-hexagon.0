From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
Date: Fri, 18 Feb 2022 08:23:29 +0100
Message-ID: <CAK8P3a17kdz0gKYz3cDSpvWa80TY6QNSom11HVAb8h91RZn0Jg@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
 <20220218063450.GI22576@lst.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645169026;
        bh=iX8k9YjATKpR4c62jPbZyUcM9GG/inNR2Rws8vh+5TI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MfE3DRj6hdmUnJC8PWE/J8NI5Xb7vzLSvmjxSj68RWTh2bxrEi4FDRZ7SQTVRhmUD
         CDmwYHK0HmoQ3JbzKSSWTyPKs0iDYpxb+V5PVYnhGTNLzIdT2kFtsQg9+RHXO7qlFv
         JwaKWZU94TsLOz/wPP4ho9HfsvwhYYkqmms7Ghj6RLE6YDZ+FbBWJxq/EGg562ZeQi
         NhSVDDRjxnzTpOPLdXdNVvcgQ+lCZzrLL/rqJ9mBNS7wpoywp5NUtuj1ow9gQEpzz9
         qTE6XwVlHR2bJnyQ0N5ldqQ5ydxv63l0XvT/OVF109xLw40SUpl/VU7vKeVPVgvfOE
         4yEkwx9CYDyzg==
In-Reply-To: <20220218063450.GI22576@lst.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.i>

On Fri, Feb 18, 2022 at 7:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#include <asm-generic/access_ok.h>
>
> Instead of the asm-generic games, shouldn't we just define access_ok in
> <linux/uaccess.h> if not already defined by the architecture?

I tried, but couldn't actually make it work because asm/uaccess.h tends
to contain inline functions that rely on access_ok(). It could work once we
move all the high-level functions into linux/uaccess.h, but that would likely
require another long patch series.

One option that can work is to require architectures to have an
asm/access_ok.h header that gets included by linux/uaccess.h.
On most architectures, that would be redirected to
asm-generic/access_ok.h, as only ia64, x86, arm64 and um
need to override the definition.

      Arnd
