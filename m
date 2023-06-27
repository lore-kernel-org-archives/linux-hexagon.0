From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
Date: Tue, 27 Jun 2023 13:13:49 -0700 (PDT)
Message-ID: <90e643ca-de72-2f4c-f4fe-35e06e1a9277@google.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com> <e8992eee-4140-427e-bacb-9449f346318@google.com> <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687896840; x=1690488840;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Omz0x3K5VJ2j7KfDH2649X9QbCItdU3t+DCvtH+dE30=;
        b=qLT/FXnF9fYy8bz41ZGqzPs/xLiMCCfewgfWuzZzcLVjcItB7JcMRZfi6IZL1dCSx3
         OsWOmERj0hyOKFLw3jnnNfW5CTsqZqse181Md9/KF69O7aJpxHwXe5KyY7KekYXV4G1r
         zVWUAFUddyly86sbQfglXGlLJ+Dw6fbYNcanLL/4qX6MAv9NG432kDe3kyebDDkyTfob
         goI5J8lS8Nlzpf0h6eGjsC3OSSCP5RIprmv8BuvIbtDrufzgn/Q2le4t+ExH2qGopi70
         i11eeGh9ltkwfbMdr3qGqDnVah9352dUuKEVj6Z46bgWdO+OozUTmUPxCUjV8K1vxlvi
         swng==
In-Reply-To: <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, 27 Jun 2023, David Hildenbrand wrote:
> On 27.06.23 06:44, Hugh Dickins wrote:
> > On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> > 
> >> The MM subsystem is trying to shrink struct page. This patchset
> >> introduces a memory descriptor for page table tracking - struct ptdesc.
> > ...
> >>   39 files changed, 686 insertions(+), 455 deletions(-)
> > 
> > I don't see the point of this patchset: to me it is just obfuscation of
> > the present-day tight relationship between page table and struct page.
> > 
> > Matthew already explained:
> > 
> >> The intent is to get ptdescs to be dynamically allocated at some point
> >> in the ~2-3 years out future when we have finished the folio project ...
> > 
> > So in a kindly mood, I'd say that this patchset is ahead of its time.
> > But I can certainly adapt to it, if everyone else sees some point to it.
> 
> I share your thoughts, that code churn which will help eventually in the far,
> far future (not wanting to sound too pessimistic, but it's not going to be
> there tomorrow ;) ).
> 
> However, if it's just the same as the other conversions we already did (e.g.,
> struct slab), then I guess there is no reason to stop now -- the obfuscation
> already happened.
> 
> ... or is there a difference regarding this conversion and the previous ones?

I was aware of the struct slab thing, didn't see much point there myself
either; but it was welcomed by Vlastimil, and barely affected outside of
slab allocators, so I had no reason to object.

You think that if a little unnecessary churn (a *lot* of churn if you
include folios, which did save some repeated calls to compound_head())
has already occurred, that's a good precedent for allowing more and more?
My opinion happens to differ on that.

Hugh
