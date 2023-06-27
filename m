From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
Date: Tue, 27 Jun 2023 13:25:52 -0700 (PDT)
Message-ID: <8f1f3dd-50a-3726-87f2-b66d35804ba7@google.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com> <e8992eee-4140-427e-bacb-9449f346318@google.com> <ZJsG3oMF+FaH0iMw@casper.infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687897556; x=1690489556;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZAV5n644nbF2fspex915RKKOQRg7bETsj2bpveqEMY=;
        b=xNz2k+2fBy79SBSN7O3Nv7cLANq5HCaENIBFu+yQEGe96a1YOHtJEoPaKnyife8HRe
         5dU95/2GVD5K+lpOCTP593eJsZJwf/2wZp9yo1OQfO/oNZwywWrdmA09H1o2gjeFBMGa
         2z17oC13XR4C8ajUueC5PeNsuXdi61YrDmFXBoVZVdvnVAtqQrU5JobTasqjeN7xrIeJ
         MpmBPZJhwD6ptkxugjRgmTxswvpeogN6O0bHDNZg4lSF5UmKAFt+JTRw6jFkbjRuUe/7
         Do+RKbNuWG1nZ+QFgPFa8R4odd5nhFz3t0Eq/rbGXPI4aHvGzMWePtxiLYZ9tzwtN2+N
         73Ng==
In-Reply-To: <ZJsG3oMF+FaH0iMw@casper.infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.frank>

On Tue, 27 Jun 2023, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 09:44:08PM -0700, Hugh Dickins wrote:
> > On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> > 
> > > The MM subsystem is trying to shrink struct page. This patchset
> > > introduces a memory descriptor for page table tracking - struct ptdesc.
> > ...
> > >  39 files changed, 686 insertions(+), 455 deletions(-)
> > 
> > I don't see the point of this patchset: to me it is just obfuscation of
> > the present-day tight relationship between page table and struct page.
> > 
> > Matthew already explained:
> > 
> > > The intent is to get ptdescs to be dynamically allocated at some point
> > > in the ~2-3 years out future when we have finished the folio project ...
> > 
> > So in a kindly mood, I'd say that this patchset is ahead of its time.
> > But I can certainly adapt to it, if everyone else sees some point to it.
> 
> If you think this patchset is ahead of its time, we can certainly put
> it on hold.  We're certainly prepared to redo it to be merged after your
> current patch series.

Thank you, but I can adapt.  That was not my point:
I'm claiming this patchset is ~2-3 years ahead of its time.

> 
> I think you can see the advantage of the destination, so I don't think
> you're against that.

Maybe - I have some scepticism, but I'll be happy for that to be dissolved.

> Are you opposed to the sequencing of the work to
> get us there?  I'd be happy to discuss another way to do it.

Yes, I'm opposed to churn for no benefit.

> 
> For example, we could dynamically allocate ptdescs right now.  We'd get
> the benefit of having an arbitrary amount of space in the ptdesc,
> although not the benefit of a smaller memmap until everything else is
> also dynamically allocated.

That sounded much better, at first: churn serving good purpose.  But now
I suspect you're offering to dynamically allocate a ptdesc, in addition
to the struct page of the page table(s) itself, which will be wasted:
more memory consumption to no advantage.  If that's so, no thanks.

Hugh
