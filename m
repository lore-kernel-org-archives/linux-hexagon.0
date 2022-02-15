From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
Date: Tue, 15 Feb 2022 10:21:16 +0100
Message-ID: <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com> <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644916891;
        bh=RZSvrBa9M+3bZFIsmIZDqZd7d5VDsf+KxZINLGmOa8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RAHiiSoOT+qkGjStonZhYrYy/J3OZkS+nBm5D1plR6odf8spdLFI55sA0GVSG+gX1
         FmPcCDRzKeNuLVHvCjfGJTHBTxbwgzR030DFU2LsjuGz8pZEhKbeR/hgIeCQIxEcqx
         HIj4CCTOLKxrGhK2W31aOh+D7o/B8cTcO951Ev77NRvhE6lAtkLsACcoUhM/z6tTLu
         qhTXBSD0ylFj48SjE2u2QLeEZrRNw+HEiuL8QU8JNZPpShvXVrQypqOZsWhDE9yRc2
         D5rdiVAwgITkzu5kXiFsxejSLdB78l1bk+Ac3J6FFkDPU8n6d+5fZ9lqTH30MQ3R7+
         eJDiITKNJvo0Q==
In-Reply-To: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@eller>

On Tue, 15 Feb 2022 at 10:13, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Feb 15, 2022 at 9:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> >
> > With set_fs() out of the picture, wouldn't it be sufficient to check
> > that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
> > That would also remove the need to strip the tag from the address.
> >
> > Something like
> >
> >     asm goto("tbnz  %0, #55, %2     \n"
> >              "tbnz  %1, #55, %2     \n"
> >              :: "r"(addr), "r"(addr + size - 1) :: notok);
> >     return 1;
> > notok:
> >     return 0;
> >
> > with an additional sanity check on the size which the compiler could
> > eliminate for compile-time constant values.
>
> That should work, but I don't see it as a clear enough advantage to
> have a custom implementation. For the constant-size case, it probably
> isn't better than a compiler-scheduled comparison against a
> constant limit, but it does hurt maintainability when the next person
> wants to change the behavior of access_ok() globally.
>

arm64 also has this leading up to the range check, and I think we'd no
longer need it:

    if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
        (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
            addr = untagged_addr(addr);

> If we want to get into micro-optimizing uaccess, I think a better target
> would be a CONFIG_CC_HAS_ASM_GOTO_OUTPUT version
> of __get_user()/__put_user as we have on x86 and powerpc.
>
>          Arnd
