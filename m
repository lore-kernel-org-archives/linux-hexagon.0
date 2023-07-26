From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH mm-unstable v7 00/31] Split ptdesc from struct page
Date: Wed, 26 Jul 2023 15:34:17 +0100
Message-ID: <ZMEu6VcTqPj69bQ7@casper.infradead.org>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
 <5296514f-cdd1-9526-2e83-a21e76e86e5@google.com>
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
	List-Owner; bh=u/7hRxS5E3gTDjOxOFIcsCMM89/bw0kK6Q83Xq5AaYo=; b=AfEofUr8bQRjYN
	tTK+bkgsfiRzgMrMtDukFH69h0ZyPZX2I9myMlqiJB43FA09X9dy87dwg7HrEyOJcGghTp+Pmomns
	Pv4muiRWm6sPrP+3WGzyRehX2M2iVbonN0N5MwnCHTIeyERELyTmawToF4nsYYtwRXq7lZPiTSXSc
	CgHhp2cxAnwf3d0bU0PbiY3BKZX2yflWGuehyg69lSNsG2IyWfrOmjiLurlr49DZ7H63jAv3IKWb0
	MrD3CsSDG5BygkKbWYozyIf2TUGYyE8CsAOJ1HiFITRG/b83KeYGC/BAmZoh2F3feGDw/6xphNLmQ
	JqLTIp2Ra4PGB8xGRIIw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LsxQl+7lQmIvtLS3uUz+2Tc5wtoeEEVBoFirY9Yb6fg=; b=NgbwQpzKHdyAWsUCxnsImKimDt
	jHF2WmVqPjDVwWh4+qnqFx9EB6EzhJPFMjClBGjD6Hvhy3cDKu8QpNdQ/vu4YdRehqVe79OoriWgn
	rYVzFWxwc/SS+7+suUkf1PvWW2cp4TLFdh0VHNZVCP6elPEQsoL4zq+DlNr+Vsyy6zVTCVD4+BPLu
	7MT7tbbN4QAXyKU4tauvNJ5ES+/Xow+YcL4kRLee8APN/cRVWSBVwKBSDtrmdoa20ei7j/6b/nKQ6
	9EjL4wZbYuEHOXjGbdk1LQrEamw4aC90nEjbS99sxd1PPE9PWCMbzElXWmFd7Um+DcVnLHPQet+QT
	TJw896fg==;
Content-Disposition: inline
In-Reply-To: <5296514f-cdd1-9526-2e83-a21e76e86e5@google.com>
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

On Mon, Jul 24, 2023 at 09:41:36PM -0700, Hugh Dickins wrote:
> On Mon, 24 Jul 2023, Vishal Moola (Oracle) wrote:
> 
> > The MM subsystem is trying to shrink struct page. This patchset
> > introduces a memory descriptor for page table tracking - struct ptdesc.
> > 
> > This patchset introduces ptdesc, splits ptdesc from struct page, and
> > converts many callers of page table constructor/destructors to use ptdescs.
> > 
> > Ptdesc is a foundation to further standardize page tables, and eventually
> > allow for dynamic allocation of page tables independent of struct page.
> > However, the use of pages for page table tracking is quite deeply
> > ingrained and varied across archictectures, so there is still a lot of
> > work to be done before that can happen.
> 
> Others may differ, but it remains the case that I see no point to this
> patchset, until the minimal descriptor that replaces struct page is
> working, and struct page then becomes just overhead.  Until that time,
> let architectures continue to use struct page as they do - whyever not?

Because it's easier for architecture maintainers to understand what they
should and shouldn't be using.  Look at the definition:

+struct ptdesc {
+	unsigned long __page_flags;
+
+	union {
+		struct rcu_head pt_rcu_head;
+		struct list_head pt_list;
+		struct {
+			unsigned long _pt_pad_1;
+			pgtable_t pmd_huge_pte;
+		};
+	};
+	unsigned long __page_mapping;
+
+	union {
+		struct mm_struct *pt_mm;
+		atomic_t pt_frag_refcount;
+	};
+
+	union {
+		unsigned long _pt_pad_2;
+#if ALLOC_SPLIT_PTLOCKS
+		spinlock_t *ptl;
+#else
+		spinlock_t ptl;
+#endif
+	};
+	unsigned int __page_type;
+	atomic_t _refcount;
+#ifdef CONFIG_MEMCG
+	unsigned long pt_memcg_data;
+#endif
+};

It's still a 31-line struct definition, I'll grant you.  But it's far
easier to comprehend than the definition of struct page (~140 lines).
An architecture maintainer can look at it and see what might be available,
and what is already used.  And hopefully we'll have less "Oh, I'll just
use page->private".  It's really not fair to expect arch maintainers to
learn so much about the mm.

It's still messier than I would like, but I don't think we can do better
for now.  I don't understand why you're so interested in delaying doing
this work.
