From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Date: Tue, 20 Jun 2023 20:05:08 -0300
Message-ID: <ZJIwpO68kc3zMB/c@nvidia.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com>
 <ZIxXw9ERkYv+ipdd@nvidia.com>
 <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltTIiBtZe5keN/2eRCeT5n726rQ4ogdJ3lncN2+uErk=;
 b=QlGuaa3Qx7T1/sBNlW/z3ccnCwjn/R1SShPsOeCqw4kB5ojYj5pPLBiAkHc0PKwg209K+9Fxl6ilpmMV18URVAeC5u9+Os/y1rDR2dcxrej0URZf0CtriqhjJI7vGFWn0vFCjCBS1k3a/16ldDjXUJvcQ2x3EzFgz/MSiU0DiEmwGq2FemrFz74ERGE0l3qZNL6eyQPSU2eTCraX7zcfbwGCkCJUAqt0CLVrEko/134SAirS55HhAEoeREwIN/pe3w/PA0sGx26Y4OvpPUjZxfBoQojIo1hQ5ZgiQ5aZnrQftdnMcwnBU1hl0vibL0jSfKtZ3JjEwzP4yejLH5os6g==
Content-Disposition: inline
In-Reply-To: <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

On Tue, Jun 20, 2023 at 01:01:39PM -0700, Vishal Moola wrote:
> On Fri, Jun 16, 2023 at 5:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > On Mon, Jun 12, 2023 at 02:03:53PM -0700, Vishal Moola (Oracle) wrote:
> > > Currently, page table information is stored within struct page. As pa=
rt
> > > of simplifying struct page, create struct ptdesc for page table
> > > information.
> > >
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > ---
> > >  include/linux/pgtable.h | 51 +++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 51 insertions(+)
> > >
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index c5a51481bbb9..330de96ebfd6 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -975,6 +975,57 @@ static inline void ptep_modify_prot_commit(struc=
t vm_area_struct *vma,
> > >  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> > >  #endif /* CONFIG_MMU */
> > >
> > > +
> > > +/**
> > > + * struct ptdesc - Memory descriptor for page tables.
> > > + * @__page_flags: Same as page flags. Unused for page tables.
> > > + * @pt_list: List of used page tables. Used for s390 and x86.
> > > + * @_pt_pad_1: Padding that aliases with page's compound head.
> > > + * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
> > > + * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap =
only.
> > > + * @pt_mm: Used for x86 pgds.
> > > + * @pt_frag_refcount: For fragmented page table tracking. Powerpc an=
d s390 only.
> > > + * @ptl: Lock for the page table.
> > > + *
> > > + * This struct overlays struct page for now. Do not modify without a=
 good
> > > + * understanding of the issues.
> > > + */
> > > +struct ptdesc {
> > > +     unsigned long __page_flags;
> > > +
> > > +     union {
> > > +             struct list_head pt_list;
> > > +             struct {
> > > +                     unsigned long _pt_pad_1;
> > > +                     pgtable_t pmd_huge_pte;
> > > +             };
> > > +     };
> > > +     unsigned long _pt_s390_gaddr;
> > > +
> > > +     union {
> > > +             struct mm_struct *pt_mm;
> > > +             atomic_t pt_frag_refcount;
> > > +     };
> > > +
> > > +#if ALLOC_SPLIT_PTLOCKS
> > > +     spinlock_t *ptl;
> > > +#else
> > > +     spinlock_t ptl;
> > > +#endif
> > > +};
> >
> > I think you should include the memcg here too? It needs to be valid
> > for a ptdesc, even if we don't currently deref it through the ptdesc
> > type.
>=20
> Yes, thanks for catching that! I'll add it to v5.
>=20
> > Also, do you see a way to someday put a 'struct rcu_head' into here?
>=20
> Eventually, when they're being dynamically allocated independent of
> struct page. Although at that point I'm not sure if we'll need one.

Sooner than dynamic struct page?

Probably it can overlap pt_list in alot of arches?

Jason
