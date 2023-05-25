From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Date: Thu, 25 May 2023 23:25:37 +0300
Message-ID: <20230525202537.GA4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685046362;
        bh=q0CSXKuNpY/cOn/THS8/5Wy4aJR83TTmgU6zxWwJSXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQE8oA8lQRwEus253i9PgXAYxS+1hfEWgxQkG8dNMuK5+C2MzFWHC2gCVa/sCTaIh
         mINB5DgFECw+pGenAIWbq/ant+MDQxcFaxJeNamZqmWfH2SE50ljnoCt5WDkZMFN/y
         zSsFGUWBnPo7WzVzFj57OnJKTLZv8v06II8J4E2+FMu/J0lzw0cg8/Um5wKRhTuiBz
         M1a9kePx9hC6/XnF66pTT3tDmfydVWOZ+PUuN61Pd1nQtUDi8l6wozX8HGFWMhSLig
         QS2F5MDwxfui88OZl1d4xhMuIeMffwSLM7NnRPkICdlmFaTyYVH5nOaWhDuFI01iqL
         PEjExdKRm1jxQ==
Content-Disposition: inline
In-Reply-To: <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Thu, May 25, 2023 at 11:04:28AM -0700, Vishal Moola wrote:
> On Thu, May 25, 2023 at 2:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
> > > +
> > > +static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int or=
der)
> > > +{
> > > +     struct page *page =3D alloc_pages(gfp | __GFP_COMP, order);
> > > +
> > > +     return page_ptdesc(page);
> > > +}
> > > +
> > > +static inline void ptdesc_free(struct ptdesc *pt)
> > > +{
> > > +     struct page *page =3D ptdesc_page(pt);
> > > +
> > > +     __free_pages(page, compound_order(page));
> > > +}
> >
> > The ptdesc_{alloc,free} API does not sound right to me. The name
> > ptdesc_alloc() implies the allocation of the ptdesc itself, rather than
> > allocation of page table page. The same goes for free.
>=20
> I'm not sure I see the difference. Could you elaborate?

I read ptdesc_alloc() as "allocate a ptdesc" rather than as "allocate a
page for page table and return ptdesc pointing to that page". Seems very
confusing to me already and it will be even more confusion when we'll start
allocating actual ptdescs.
=20
--=20
Sincerely yours,
Mike.
