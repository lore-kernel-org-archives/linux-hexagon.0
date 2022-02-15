From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 14/14] uaccess: drop set_fs leftovers
Date: Tue, 15 Feb 2022 09:10:05 +0100
Message-ID: <CAK8P3a1DPxgti+aRVUABQFZz-yT0KNU9QZpB9iGNCPkBHnv_xg@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-15-arnd@kernel.org>
 <YgsYD2nW9GjWJtn5@zeniv-ca.linux.org.uk> <215c0ddc-54b1-bcb1-c5aa-bd17c6b100a8@gmx.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644912623;
        bh=SSSBFam0X7wa1ZiCw7Mbgc9666G5ScJGR2eDM1GsaRo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GJaH8HwE/nyR+qQa8REdT0IBd6a1g1vdC7TjCVH+QKxG8exdyUSWaCsUK7KWHphPk
         tvJwSqnUx64jqz1n54LIqFenzDmCCidLTJduU74Q5vlyWYX7j4DNZDwpt3yWI1yggy
         uVAjNKpsQ/55wU4crkdhGYsBR6jczZb92p557GB19rCppp2hQm8idjgMHrieouMtUe
         BGFgP4YI3u/k4JjEKZvMFZMxgpcGVMSueNUds/WuePg8tSzQQwECVHk/BraBvFWKRw
         FVODNRMCkDbhgL/OgkzDyZhbXNvkdebH3pAU3g7SFEv2xKk93G1ExuOBsZgVpcgC1j
         wml0zK2sDBkbQ==
In-Reply-To: <215c0ddc-54b1-bcb1-c5aa-bd17c6b100a8@gmx.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller@gmx.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Michael Ellerman <mpe@ellerman>

On Tue, Feb 15, 2022 at 8:46 AM Helge Deller <deller@gmx.de> wrote:
>
> On 2/15/22 04:03, Al Viro wrote:
> > On Mon, Feb 14, 2022 at 05:34:52PM +0100, Arnd Bergmann wrote:
> >> diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
> >> index b5835325d44b..2f4a1b1ef387 100644
> >> --- a/arch/parisc/include/asm/futex.h
> >> +++ b/arch/parisc/include/asm/futex.h
> >> @@ -99,7 +99,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> >>      /* futex.c wants to do a cmpxchg_inatomic on kernel NULL, which is
> >>       * our gateway page, and causes no end of trouble...
> >>       */
> >> -    if (uaccess_kernel() && !uaddr)
> >> +    if (!uaddr)
> >>              return -EFAULT;
> >
> >       Huh?  uaccess_kernel() is removed since it becomes always false now,
> > so this looks odd.
> >
> >       AFAICS, the comment above that check refers to futex_detect_cmpxchg()
> > -> cmpxchg_futex_value_locked() -> futex_atomic_cmpxchg_inatomic() call chain.
> > Which had been gone since commit 3297481d688a (futex: Remove futex_cmpxchg
> > detection).  The comment *and* the check should've been killed off back
> > then.
> >       Let's make sure to get both now...
>
> Right. Arnd, can you drop this if() and the comment above it?

Done.

       Arnd
