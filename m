From: Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Date: Thu, 25 May 2023 13:53:24 -0700
Message-ID: <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com> <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com> <20230525202537.GA4967@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048015; x=1687640015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e72vGCwhPoa8gN25X6qmdDXVUsdWWJFQx8MjqDcoGDA=;
        b=PRDb4uH8g3Vv6gZWsZ1gkHY+ANMWnqtSqEQNi+t68NKJyRAPGtGIjXS+o6ABKHZ7yv
         q51K7Vr8Q1brsvSZQkdt4WeLJo6vXr04Grr6RxGrB/PY5E3pp1cBQWvGni0wb9TWYIbM
         5FWOkPlw4M42rE2TxcMBGldDhB3WLqb55j0CqgwQEW0TmVHxxCeHx2Zs7VLCqGumlN8c
         PmQWTAjBOIMu7fHadjtAjQF7IDQQLa3x/OUyFY2aJiBpGADt0K07OCNxrHer3KqiVV69
         GxawL7cJdKwcX3ZUAGYa8EVBTKoLWza/yXtntrwGkP8KyxHL6U40gF5XovIoxt2V2Fr9
         5Wvw==
In-Reply-To: <20230525202537.GA4967@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Thu, May 25, 2023 at 1:26=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, May 25, 2023 at 11:04:28AM -0700, Vishal Moola wrote:
> > On Thu, May 25, 2023 at 2:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > > > +
> > > > +static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int =
order)
> > > > +{
> > > > +     struct page *page =3D alloc_pages(gfp | __GFP_COMP, order);
> > > > +
> > > > +     return page_ptdesc(page);
> > > > +}
> > > > +
> > > > +static inline void ptdesc_free(struct ptdesc *pt)
> > > > +{
> > > > +     struct page *page =3D ptdesc_page(pt);
> > > > +
> > > > +     __free_pages(page, compound_order(page));
> > > > +}
> > >
> > > The ptdesc_{alloc,free} API does not sound right to me. The name
> > > ptdesc_alloc() implies the allocation of the ptdesc itself, rather th=
an
> > > allocation of page table page. The same goes for free.
> >
> > I'm not sure I see the difference. Could you elaborate?
>
> I read ptdesc_alloc() as "allocate a ptdesc" rather than as "allocate a
> page for page table and return ptdesc pointing to that page". Seems very
> confusing to me already and it will be even more confusion when we'll sta=
rt
> allocating actual ptdescs.

Hmm, I see what you're saying. I'm envisioning this function evolving into
one that allocates a ptdesc later. I don't see why we would need to have bo=
th a
page table page AND ptdesc at any point, but that may be a lack of knowledg=
e
from my part.

I was thinking later, if necessary, we could make another function
(only to be used internally) to allocate page table pages.
