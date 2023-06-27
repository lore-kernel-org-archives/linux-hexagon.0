From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
Date: Tue, 27 Jun 2023 16:57:18 +0100
Message-ID: <ZJsG3oMF+FaH0iMw@casper.infradead.org>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <e8992eee-4140-427e-bacb-9449f346318@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yFi0QS0ym+RlgsW99ZnN9RxEn8UDxGZPhAsS5DRsLvI=; b=AWdSoMZoQJA6Zy
	VJZ/SdU5rwymmbRqUNuesQDsu/97rSGyK+NjmLJu7NelLovWbyxPfrlL5Sd+QE2GeGkapbPJxI0fZ
	1JT6q1scSe6sgZSMiwKjpoZ50wg7AZipWoHWWA05T5KDDBgFqLHjemmU7ium/ULoX3YZjS/1InxFc
	9NFxW0sIO+EFIJ5e7h5+xLcmHNssXqo4HfvSQqU0M8oy26FeensiJkY3Z3W4SjdePIl2KECQd1hVC
	Nn3/ylX2WFuQGhm7Kon+AgzIoN2G2KvbLLEyLn05Sw69WXTZnb8CYt0Br3voLzCQrFgdnIUk9WrtL
	5VOxQgdWDy4MLDHoMU+w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=grdde8Xiu7qmn+xeWQjS6jhM9eMOIEx2FTKQKHA0qcE=; b=O4LgnaJa+96/pjOun/grMWRgf0
	LntDzHo/Nz16KvqxiEr1HwXvA//H8Xwaltp+tupPUb4EjOFyVKwNxLm4bicLOTqp/7aKDRUtZ+Ti+
	YkZNFYgufWM7VfJ37zBwafjppANl7Ov4YfJ/3SNrxho42WxRJ90YRkLRkEz9110OQT69JgyQix3bE
	1UUN6JmWKzg8Bc5AERWCg8k1In+54bOFEIjoHmAhuJ48uTlyrsgS9ASEoWWfFX2oCx8vHeEKiHBK2
	0ATl5M0lbW4dygkvrSWQNrInCol2nuI3Fn1fE8BBqWu2s6F5FIZzUwvO8Dgsb04PN8JGsMx2K7RYi
	V5QQ1b6Q==;
Content-Disposition: inline
In-Reply-To: <e8992eee-4140-427e-bacb-9449f346318@google.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org
To: Hugh Dickins <hughd@google.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, David Hildenbrand <david@redhat.com>, Claudio

On Mon, Jun 26, 2023 at 09:44:08PM -0700, Hugh Dickins wrote:
> On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> 
> > The MM subsystem is trying to shrink struct page. This patchset
> > introduces a memory descriptor for page table tracking - struct ptdesc.
> ...
> >  39 files changed, 686 insertions(+), 455 deletions(-)
> 
> I don't see the point of this patchset: to me it is just obfuscation of
> the present-day tight relationship between page table and struct page.
> 
> Matthew already explained:
> 
> > The intent is to get ptdescs to be dynamically allocated at some point
> > in the ~2-3 years out future when we have finished the folio project ...
> 
> So in a kindly mood, I'd say that this patchset is ahead of its time.
> But I can certainly adapt to it, if everyone else sees some point to it.

If you think this patchset is ahead of its time, we can certainly put
it on hold.  We're certainly prepared to redo it to be merged after your
current patch series.

I think you can see the advantage of the destination, so I don't think
you're against that.  Are you opposed to the sequencing of the work to
get us there?  I'd be happy to discuss another way to do it.

For example, we could dynamically allocate ptdescs right now.  We'd get
the benefit of having an arbitrary amount of space in the ptdesc,
although not the benefit of a smaller memmap until everything else is
also dynamically allocated.
