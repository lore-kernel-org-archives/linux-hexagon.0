From: Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Date: Tue, 20 Jun 2023 16:10:22 -0700
Message-ID: <CAOzc2pwNc-9bRbAV8=_yROU5uq96q6v-dEfcYuzJyDrRygNsbA@mail.gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com> <ZIxXw9ERkYv+ipdd@nvidia.com>
 <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com> <ZJIwpO68kc3zMB/c@nvidia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687302633; x=1689894633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nozU+u202dwuRZdJGKz18i7nEQxa/ZPqnuIXPcARxTk=;
        b=Srt/QiH6vSlV6ltPf9H8KdAeCpbz7L591o99Craxfn8w/jM66I5hACYYF7kGTNoYRf
         37MNDI/F8R1g44q3mAPdvv0ch2USGp6Xr2QpXeRs4zwys088B20V4rigZMbQAUtCAcnv
         ujlqxNx2s65vbfsZd3k+2DjIHKhHJIWAfpgn7QYgmI+NGmP+FiWPPp675PKwGH44ORfj
         zOUT1l13zV/ZQbeHYvFRsincMrSLLgcM09n9imSEGZWNpBzKYFGwq1+DONOYFih8u36L
         jrVhBZXiCnjwgLIXcNbQ+C7KfkKQcJy9rAKazTyykVFlz02AVb/RzeIKJrXQdve86D2m
         bp4A==
In-Reply-To: <ZJIwpO68kc3zMB/c@nvidia.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

On Tue, Jun 20, 2023 at 4:05=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jun 20, 2023 at 01:01:39PM -0700, Vishal Moola wrote:
> > On Fri, Jun 16, 2023 at 5:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Mon, Jun 12, 2023 at 02:03:53PM -0700, Vishal Moola (Oracle) wrote=
:
> > > > Currently, page table information is stored within struct page. As =
part
> > > > of simplifying struct page, create struct ptdesc for page table
> > > > information.
> > > >
> > > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > > ---
> > > >  include/linux/pgtable.h | 51 +++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 51 insertions(+)
> > > >
> > > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > > index c5a51481bbb9..330de96ebfd6 100644
> > > > --- a/include/linux/pgtable.h
> > > > +++ b/include/linux/pgtable.h
> > > > @@ -975,6 +975,57 @@ static inline void ptep_modify_prot_commit(str=
uct vm_area_struct *vma,
> > > >  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> > > >  #endif /* CONFIG_MMU */
> > > >
> > > > +
> > > > +/**
> > > > + * struct ptdesc - Memory descriptor for page tables.
> > > > + * @__page_flags: Same as page flags. Unused for page tables.
> > > > + * @pt_list: List of used page tables. Used for s390 and x86.
> > > > + * @_pt_pad_1: Padding that aliases with page's compound head.
> > > > + * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
> > > > + * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gma=
p only.
> > > > + * @pt_mm: Used for x86 pgds.
> > > > + * @pt_frag_refcount: For fragmented page table tracking. Powerpc =
and s390 only.
> > > > + * @ptl: Lock for the page table.
> > > > + *
> > > > + * This struct overlays struct page for now. Do not modify without=
 a good
> > > > + * understanding of the issues.
> > > > + */
> > > > +struct ptdesc {
> > > > +     unsigned long __page_flags;
> > > > +
> > > > +     union {
> > > > +             struct list_head pt_list;
> > > > +             struct {
> > > > +                     unsigned long _pt_pad_1;
> > > > +                     pgtable_t pmd_huge_pte;
> > > > +             };
> > > > +     };
> > > > +     unsigned long _pt_s390_gaddr;
> > > > +
> > > > +     union {
> > > > +             struct mm_struct *pt_mm;
> > > > +             atomic_t pt_frag_refcount;
> > > > +     };
> > > > +
> > > > +#if ALLOC_SPLIT_PTLOCKS
> > > > +     spinlock_t *ptl;
> > > > +#else
> > > > +     spinlock_t ptl;
> > > > +#endif
> > > > +};
> > >
> > > I think you should include the memcg here too? It needs to be valid
> > > for a ptdesc, even if we don't currently deref it through the ptdesc
> > > type.
> >
> > Yes, thanks for catching that! I'll add it to v5.
> >
> > > Also, do you see a way to someday put a 'struct rcu_head' into here?
> >
> > Eventually, when they're being dynamically allocated independent of
> > struct page. Although at that point I'm not sure if we'll need one.
>
> Sooner than dynamic struct page?
>
> Probably it can overlap pt_list in alot of arches?

Ah yes, there will be one if v5 overlapping with pt_list
(it already does in struct page anyways).
