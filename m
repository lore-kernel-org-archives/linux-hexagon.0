From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Date: Fri, 16 Jun 2023 21:38:21 +0100
Message-ID: <ZIzIPQBXvnMtQekj@casper.infradead.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com>
 <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G136bXhsdH51zk1Y79GT0RmDlsZbwEJ9e+y9r1zjvVA=; b=Tl8xaeYXW/v14d
	uN4blkgU79Q62w9XiwsnnOvjAcUKkOMVgpMwORemkfwsfPqAeht9zPt0iMjAFUp3F+5s27iYICR77
	5Q72IMpN77ZDBoufPbIPq6JsJ29t2EmAWYoOYZ4s5OcQgxJoFh6eAJ/xdM1Hjr6EpZ+WmLxvMT0QZ
	1lrHbDiytbLQhF8NajkGaGOCt5OR1qN6Vpt2Kve36zsoI97tJZqBq60z4IMk+A41ZULb2hzA5BENL
	y5hIeKMLBz+d0THoIhJqYTIVMa+gim3w28/5fZX2/oxG2SjXVC3bMFxE6hL4wp2mmVpIhv4n2EYdi
	Iqho14+hBLbHaawmQB9g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fw74FAZhkocnJnJyLR/WQNNOz26kiObyhL++hGG0nWw=; b=QBNdm8qv6j/A/iWrMKfpB6M7G8
	dX02GHdjAg9rPGckqaKAq0nuLHgnEOZOUcT5iS1KFKrWFBJlTrkF2I4g5N2YgCfsexrQECwyFoHPp
	z6yd+/vIl/PequagU7pGV8UNE2yhdOrdkDT+t3SJSVONZj6Q1cQWhoxiK+7FUVh/Fb17OdOH8kjtt
	OWIuj2P4ze5K/i70TfCVLOSJSXO+Ry9WEoIoy6BlMNh0EJ1wlu/c8zXDIuEPPIicVlz2AV+6m8LDv
	lA4vOEDBJYuPKGoF8lu2OSuuFhx10iSF/LiB0UcYpqrALuMFJM02PbH03w+/bd9OLb/nrxdqasmpe
	J/m6D//w==;
Content-Disposition: inline
In-Reply-To: <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Hugh Dickins <hughd@google.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Thu, Jun 15, 2023 at 12:57:19AM -0700, Hugh Dickins wrote:
> Probably just trivial collisions in most architectures, which either
> of us can easily adjust to the other; powerpc likely to be more awkward,
> but fairly easily resolved; s390 quite a problem.
> 
> I've so far been unable to post a v2 of my series (and powerpc and s390
> were stupidly wrong in the v1), because a good s390 patch is not yet
> decided - Gerald Schaefer and I are currently working on that, on the
> s390 list (I took off most Ccs until we are settled and I can post v2).
> 
> As you have no doubt found yourself, s390 has sophisticated handling of
> free half-pages already, and I need to add rcu_head usage in there too:
> it's tricky to squeeze it all in, and ptdesc does not appear to help us
> in any way (though mostly it's just changing some field names, okay).
> 
> If ptdesc were actually allowing a flexible structure which architectures
> could add into, that would (in some future) be nice; but of course at
> present it's still fitting it all into one struct page, and mandating
> new restrictions which just make an architecture's job harder.

The intent is to get ptdescs to be dynamically allocated at some point
in the ~2-3 years out future when we have finished the folio project ...
which is not a terribly helpful thing for me to say.

I have three suggestions, probably all dreadful:

1. s390 could change its behaviour to always allocate page tables in
pairs.  That is, it fills in two pmd_t entries any time it takes a fault
in either of them.

2. We could allocate two or four pages at a time for s390 to allocate
2kB pages from.  That gives us a lot more space to store RCU heads.

3. We could use s390 as a guinea-pig for dynamic ptdesc allocation.
Every time we allocate a struct page, we have a slab cache for an
s390-special definition of struct ptdesc, we allocate a ptdesc and store
a pointer to that in compound_head.

We could sweeten #3 by doing that not just for s390 but also for every
configuration which has ALLOC_SPLIT_PTLOCKS today.  That would get rid
of the ambiguity between "is ptl a pointer or a lock".

> But I've no desire to undo powerpc's use of pt_frag_refcount:
> just warning that we may want to undo any use of it in s390.

I would dearly love ppc & s390 to use the _same_ scheme to solve the
same problem.
