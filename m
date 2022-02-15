From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
Date: Tue, 15 Feb 2022 10:12:40 +0100
Message-ID: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644916378;
        bh=nPLs5v71E/xzzKRq/jdD2UxtX1DBSgxHKB2i8EHy1KY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j3kUIfoQTYxq0nCVjg3xJUAdSTCwwH8temh7NFjmZfpkIjAXQ/i5eqNNYmAAO/ny1
         Uhrqg321bjTbiL2bLfcsiw3L/YssCCJFSkB1FTV4deiCrv9oCd+WLuGBXT1JJy17rS
         k8cMdKEehveud6wTzU+zMEsNNO9j8HHxKx2E1NBNFWFufNsE2sT4ymojJeWA5L/d5h
         cw/DGlUHQEdW9cC4Q+y80YkhF8+ZZBz928QLF/gO6sphG+kkzt0wgVNEOYTAhGmy7s
         fFzb6USqyb2JRrGEB+Xy9zVF9/7CIibD5o8jjgMioj1JxGYIThdIqK2msRJNx3V5hb
         RhnYTF7LWjKEQ==
In-Reply-To: <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@eller>

On Tue, Feb 15, 2022 at 9:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
>
> With set_fs() out of the picture, wouldn't it be sufficient to check
> that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
> That would also remove the need to strip the tag from the address.
>
> Something like
>
>     asm goto("tbnz  %0, #55, %2     \n"
>              "tbnz  %1, #55, %2     \n"
>              :: "r"(addr), "r"(addr + size - 1) :: notok);
>     return 1;
> notok:
>     return 0;
>
> with an additional sanity check on the size which the compiler could
> eliminate for compile-time constant values.

That should work, but I don't see it as a clear enough advantage to
have a custom implementation. For the constant-size case, it probably
isn't better than a compiler-scheduled comparison against a
constant limit, but it does hurt maintainability when the next person
wants to change the behavior of access_ok() globally.

If we want to get into micro-optimizing uaccess, I think a better target
would be a CONFIG_CC_HAS_ASM_GOTO_OUTPUT version
of __get_user()/__put_user as we have on x86 and powerpc.

         Arnd
