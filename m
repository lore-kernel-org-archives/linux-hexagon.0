From: Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH v2 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon, 15 May 2023 12:11:46 -0700
Message-ID: <CAOzc2pz6y=gRcdfkQVgwRuzWeWf2Nx-UBtKnZBTs2qKJ+r7R0Q@mail.gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-31-vishal.moola@gmail.com> <c0677d21a4b6caa2e5018af000294a974121d9e8.camel@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684177917; x=1686769917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEdsDznoeQ0wGPMJWBs10mMvCj7VphDqPqR+uizklHY=;
        b=W/Z9qzmBUq3bCVhP8uewmPEIaZEVYfzpzeh9YTeAKrK3sWIwtOfql71JlvN0P+P5pK
         YKy9cml02fk4SnFQ2DdWQ6w4JijHunpNA4zsiud1GYDMnfuy8RTxF/bEehOFA+aPeByE
         DTSRG2bdMMqymbgvM1f+cbSlSYq+sQANl8uMoYLlmajJ3SyWJdGVyTNcYD0Ioakieviy
         BESs3L0iPHTKfiNNq75aO8FTJdn/BYay+E8sIKUXSqB49RgAR5VB2xxzW+nwEEKofO5F
         26ssX78nNr5JZdvfN8wyMBJyb6MRO06YlrKHWh/GpY8CaWKtewkcbGK5ZJkz6FL2Wiq9
         dAhA==
In-Reply-To: <c0677d21a4b6caa2e5018af000294a974121d9e8.camel@physik.fu-berlin.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

On Sat, May 6, 2023 at 4:35=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Vishal!
>
> On Mon, 2023-05-01 at 12:28 -0700, Vishal Moola (Oracle) wrote:
> > Part of the conversions to replace pgtable constructor/destructors with
> > ptdesc equivalents. Also cleans up some spacing issues.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  arch/sh/include/asm/pgalloc.h | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgallo=
c.h
> > index a9e98233c4d4..ce2ba99dbd84 100644
> > --- a/arch/sh/include/asm/pgalloc.h
> > +++ b/arch/sh/include/asm/pgalloc.h
> > @@ -2,6 +2,7 @@
> >  #ifndef __ASM_SH_PGALLOC_H
> >  #define __ASM_SH_PGALLOC_H
> >
> > +#include <linux/mm.h>
> >  #include <asm/page.h>
> >
> >  #define __HAVE_ARCH_PMD_ALLOC_ONE
> > @@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *m=
m, pmd_t *pmd,
> >       set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
> >  }
> >
> > -#define __pte_free_tlb(tlb,pte,addr)                 \
> > -do {                                                 \
> > -     pgtable_pte_page_dtor(pte);                     \
> > -     tlb_remove_page((tlb), (pte));                  \
> > +#define __pte_free_tlb(tlb, pte, addr)                               \
> > +do {                                                         \
> > +     ptdesc_pte_dtor(page_ptdesc(pte));                      \
> > +     tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
> >  } while (0)
> >
> >  #endif /* __ASM_SH_PGALLOC_H */
>
> Looking at the patch which introduces tlb_remove_page_ptdesc() [1], it se=
ems that
> tlb_remove_page_ptdesc() already calls tlb_remove_page() with ptdesc_page=
(pt), so
> I'm not sure whether the above tlb_remove_page_ptdesc((tlb), (page_ptdesc=
(pte)))
> is correct.
>
> Shouldn't it just be tlb_remove_page_ptdesc((tlb), (pte))?

As of this patchset all implementations of __pte_free_tlb() take in a
struct page. Eventually we'll want it to be tlb_remove_page_ptdesc(tlb, pte=
),
but for now the cast is necessary here.
