From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 10/18] m68k: fix access_ok for coldfire
Date: Fri, 18 Feb 2022 10:24:50 +0100
Message-ID: <CAK8P3a2hrjxzzAWk3ut3VTD3h=ZLpDwPdvqs+uKaC4_b6+Vbfg@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-11-arnd@kernel.org>
 <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645176308;
        bh=mMLLIykgh57Awf38lSwA8MWwDlZ8x8pcozF3MLrCnRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbqIylmo6uIMQW9t/Ad/7tK2u11mWG8WjB4qa2lfLenjhGPPxOrSXmBbl29vFdLsz
         RLSm/eXkXWAyaPeir93OV55usyXVm2w4yQlbEJGSBjhJPbxxP/WpH5jZFZohcdGJuc
         6Zfpxe/6xPCRfwA2642xwgzl3OAOgkS6RUG2lx02px9lCShpTvSBFlhAXh9Xt0WesF
         y9upM5KMvL2LkL8Lg6Wt2QOBAR4Z85feGVCvbHOzS9xm+0Yr+UJLxIFlCq0FBHO81q
         m9xWZTMnBTKzYFvFyVALCx1xdi73gd+l2HgxVcagVdTW3ua0wYvd/SpcRFCaI9A6Sk
         sF8vt4Yo6OTWg==
In-Reply-To: <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Peter

On Fri, Feb 18, 2022 at 10:00 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> >  /* We let the MMU do all checking */
> > -static inline int access_ok(const void __user *addr,
> > +static inline int access_ok(const void __user *ptr,
> >                             unsigned long size)
> >  {
> > +       unsigned long limit = TASK_SIZE;
> > +       unsigned long addr = (unsigned long)ptr;
> > +
> >         /*
> >          * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
> >          * for TASK_SIZE!
> > +        * Removing this helper is probably sufficient.
> >          */
>
> Shouldn't the above comment block be removed completely,
> as this is now implemented below?

Yes, obviously. Fixed now.

> > -       return 1;
> > +       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES))
> > +               return 1;

I just noticed this should have the same change that I made for the
generic version, changed it now to

+       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES) ||
+           !IS_ENABLED(CONFIG_MMU))

This is gone again after the cleanup patch, when the generic version
is used instead.

> > +       return (size <= limit) && (addr <= (limit - size));
> >  }
>
> Any pesky compilers that warn (or worse with -Werror) about
> "condition always true" for TASK_SIZE = 0xFFFFFFFFUL?

No, using a local variable avoids this warning.

        Arnd
