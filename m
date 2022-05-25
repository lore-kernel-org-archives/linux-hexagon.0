From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Wed, 25 May 2022 13:10:17 +0200
Message-ID: <Yo4OmaNW5YUrGE0S@hirez.programming.kicks-ass.net>
References: <20220524234531.1949-1-peterx@redhat.com>
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
	List-Owner; bh=CY7qtAv1oTJczHETHbhC9CMEk0chrOG8tzOjmljXr8k=; b=CF3ZPBvrJgOtga
	OJ1tzv6x8iMNYo/XmcpO2r1Ff1TTv4jQGlrQxoILcrgzXfEMefepvVuFAmxfq1SW9ANl1jm0y2+dY
	ojPngvJW2k02MWe6Vs4ibgLdc0eta1E+Lno503vtUTlu1ZEn7JuQJOfeG1wc6pKzRhwjXxLG4+h4B
	VJePtqBSg/DraNdmvhMTb0JZUhoMI8o7zQdmKaujNp50MrTvP9ZSr207b2q/QYG09c79Z+UbaJ/ac
	WnbP87amnrsJcHP52XlPs/X1RfNMAx1rH56jf+GrQmHCkFBNQeuyLsV7cc7Wa+lU0Sl22uBQeUcyH
	+mLdkik26RhofNzY2QWg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TTSfncRF4bwVxkeR+S4pHa2NuE5vU7NkHqU52imXoeo=; b=AZ7NLjulpP1WzqY4jAw9CJ6mzn
	eNxn6mITLdAkzreesFIusYyJANkaOvbZVslHzJxDDqo/jW9prJ6mSOYajnNAsWgSTZTPCGe4Y+H+t
	Q7b5K2i3OxODvn+feDcYZuuvagMcqlznlm2xJ6e8wPUzB4c/WkijGr50Z8D32ZlBmwWuMwGQbue1E
	mrsCyjPGVmj7xf/0/rnV0zIseeyVAHCeyTCYTi0ZFmZwkk1CWC0IMPFglArv51u64lwHpRP8/QuNm
	TypGtB34O3uGaPoduTA8k7e4jOZswva+y2onGqiOIb4Z5GAtPEnJDGpyLSzDy3ZlKvUO8MvNVaZm2
	4u9mbK6A==;
Content-Disposition: inline
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Matt Turner <mattst88@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>, Michal Simek <monstr@monstr.eu>, Russell King <linux@armlinux.org.uk>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-riscv@lists.infradead.org, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <aarcange@redhat.com>, openrisc@lists.librecores.org, linux-s390@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-m68k@lists.linux-m68k.org, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Alistair

On Tue, May 24, 2022 at 07:45:31PM -0400, Peter Xu wrote:
> I observed that for each of the shared file-backed page faults, we're very
> likely to retry one more time for the 1st write fault upon no page.  It's
> because we'll need to release the mmap lock for dirty rate limit purpose
> with balance_dirty_pages_ratelimited() (in fault_dirty_shared_page()).
> 
> Then after that throttling we return VM_FAULT_RETRY.
> 
> We did that probably because VM_FAULT_RETRY is the only way we can return
> to the fault handler at that time telling it we've released the mmap lock.
> 
> However that's not ideal because it's very likely the fault does not need
> to be retried at all since the pgtable was well installed before the
> throttling, so the next continuous fault (including taking mmap read lock,
> walk the pgtable, etc.) could be in most cases unnecessary.
> 
> It's not only slowing down page faults for shared file-backed, but also add
> more mmap lock contention which is in most cases not needed at all.
> 
> To observe this, one could try to write to some shmem page and look at
> "pgfault" value in /proc/vmstat, then we should expect 2 counts for each
> shmem write simply because we retried, and vm event "pgfault" will capture
> that.
> 
> To make it more efficient, add a new VM_FAULT_COMPLETED return code just to
> show that we've completed the whole fault and released the lock.  It's also
> a hint that we should very possibly not need another fault immediately on
> this page because we've just completed it.
> 
> This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> program sequentially dirtying 400MB shmem file being mmap()ed and these are
> the time it needs:
> 
>   Before: 650.980 ms (+-1.94%)
>   After:  569.396 ms (+-1.38%)
> 
> I believe it could help more than that.
> 
> We need some special care on GUP and the s390 pgfault handler (for gmap
> code before returning from pgfault), the rest changes in the page fault
> handlers should be relatively straightforward.
> 
> Another thing to mention is that mm_account_fault() does take this new
> fault as a generic fault to be accounted, unlike VM_FAULT_RETRY.
> 
> I explicitly didn't touch hmm_vma_fault() and break_ksm() because they do
> not handle VM_FAULT_RETRY even with existing code, so I'm literally keeping
> them as-is.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
