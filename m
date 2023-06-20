From: Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Date: Tue, 20 Jun 2023 13:01:39 -0700
Message-ID: <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com> <ZIxXw9ERkYv+ipdd@nvidia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291309; x=1689883309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4F3qXm8x1AVi+0TrKGx40m/sFxYrt6Lj9IeE/BrpeU=;
        b=g8Wha6YZBIQ4F35wQ8P6Y0c98+3LfOEjAen8YviDIN/VpMlvLwu/TwEQtEhwi2wLbk
         4/b97qENpIhbKycIE1G3aUVCeb+vz/rCN/gI0l10ch7iG8C6c3ywB5bQ5tQe6ryGYXul
         5XkEWnvnLWIaJ1vsJQRh6tPgKWpuL7AyPHBFZQZGhCATWoDKR1D2YRUNFvvEx6dCnM6X
         zMyQcs2OOhmWkXYBbd2Z3eHBKxjZIMZIeFLBGw0YYdvfY15fMS5Ra2rC/awJj+k/fir6
         OMXeho7/p64d1/Gcc6dtEtZlx65PVhnR78rxvmM8tH1fn8015FZgY0Ml6WWkfDm6BXzA
         dR7g==
In-Reply-To: <ZIxXw9ERkYv+ipdd@nvidia.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

On Fri, Jun 16, 2023 at 5:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Jun 12, 2023 at 02:03:53PM -0700, Vishal Moola (Oracle) wrote:
> > Currently, page table information is stored within struct page. As part
> > of simplifying struct page, create struct ptdesc for page table
> > information.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  include/linux/pgtable.h | 51 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index c5a51481bbb9..330de96ebfd6 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -975,6 +975,57 @@ static inline void ptep_modify_prot_commit(struct =
vm_area_struct *vma,
> >  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> >  #endif /* CONFIG_MMU */
> >
> > +
> > +/**
> > + * struct ptdesc - Memory descriptor for page tables.
> > + * @__page_flags: Same as page flags. Unused for page tables.
> > + * @pt_list: List of used page tables. Used for s390 and x86.
> > + * @_pt_pad_1: Padding that aliases with page's compound head.
> > + * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
> > + * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap on=
ly.
> > + * @pt_mm: Used for x86 pgds.
> > + * @pt_frag_refcount: For fragmented page table tracking. Powerpc and =
s390 only.
> > + * @ptl: Lock for the page table.
> > + *
> > + * This struct overlays struct page for now. Do not modify without a g=
ood
> > + * understanding of the issues.
> > + */
> > +struct ptdesc {
> > +     unsigned long __page_flags;
> > +
> > +     union {
> > +             struct list_head pt_list;
> > +             struct {
> > +                     unsigned long _pt_pad_1;
> > +                     pgtable_t pmd_huge_pte;
> > +             };
> > +     };
> > +     unsigned long _pt_s390_gaddr;
> > +
> > +     union {
> > +             struct mm_struct *pt_mm;
> > +             atomic_t pt_frag_refcount;
> > +     };
> > +
> > +#if ALLOC_SPLIT_PTLOCKS
> > +     spinlock_t *ptl;
> > +#else
> > +     spinlock_t ptl;
> > +#endif
> > +};
>
> I think you should include the memcg here too? It needs to be valid
> for a ptdesc, even if we don't currently deref it through the ptdesc
> type.

Yes, thanks for catching that! I'll add it to v5.

> Also, do you see a way to someday put a 'struct rcu_head' into here?

Eventually, when they're being dynamically allocated independent of
struct page. Although at that point I'm not sure if we'll need one.

> Thanks,
> Jason
