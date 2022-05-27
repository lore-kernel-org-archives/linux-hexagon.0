From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Fri, 27 May 2022 14:23:42 +0200
Message-ID: <YpDCzvLER9AYJJc8@osiris>
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
	List-Owner; bh=QsHjDsOEjaVs4/QFYjWMRqYjCuAIx/EJiepWOxCjdvY=; b=1Tl0c7F1uWqDdN
	Wu5zbXUwwba3HVru17goIwFDM4YjA7ZMuaVnpNAAFTeYmKdtx6bYIlPLuWWdUp4AWQI5EZDH/BHJs
	KrIPiJsNhRKZcUWXPyWUDcUJeJwSSBJssF+yC4mMfysW3nKwMywbW5CKnECNsXhtEvhGs5VwnxOFF
	y19/ARql0qMjpKnVYq/Pl8TlB78t7vvJd5X9eVJbo//RdY8SAJJAUU8ON6cK/7sqNNafOJYt7eHT8
	jeGKAJ6z1wegIaqiLGNi3QHxWi5ZlFvF05OK+N4x7yWwrpIfXxWfmuCYisYdZdFroW0CcIbHISzX/
	ieB0XVcfK5+xABjP1+Ng==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RVk/+c6nPK5D2qeDI0zLbVO1lqN1tQYD0TzNeMii76M=;
 b=CdGIqDdzBXd3h2dRHpL1DShFdmTRQ/K3BNoowjsJ7U4uRWdEUL24qUkp9B9CCe4qwI1x
 ueMHE+3+v1uC7fMJZdhALNq0R69QTPr2X7t7hmmcYdqjvUF+dOgF+KjoQRzbmFzsymwU
 4TRs+Fcb59XpwhBMszKHjkfxh5jERETh0DSQF2mQOARMUdDnfiEcL/AxzL9Ab0Nz2WHK
 SDNr7raIw4jjkxtIKRrkZp9dwvFLuLsudS4hJ9Ynj7wBxCmCSFMaztPXonoUGxJ1hjXA
 3uotVOEbohqQcj6NjHHndqMeFT50tNx88feHmMQrikGztx2louDZC2dPTlWt2pNYYxwq Kg== 
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Matt Turner <mattst88@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>, Michal Simek <monstr@monstr.eu>, Russell King <linux@armlinux.org.uk>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-riscv@lists.infradead.org, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <aarcange@redhat.com>, openrisc@lists.librecores.org, linux-s390@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-m68k@lists.linux-m68k.org, Palmer Dabbelt <palmer@da>

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
...
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e173b6187ad5..9503a7cfaf03 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -339,6 +339,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	unsigned long address;
>  	unsigned int flags;
>  	vm_fault_t fault;
> +	bool need_unlock = true;
>  	bool is_write;
>  
>  	tsk = current;
> @@ -433,6 +434,13 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  			goto out_up;
>  		goto out;
>  	}
> +
> +	/* The fault is fully completed (including releasing mmap lock) */
> +	if (fault & VM_FAULT_COMPLETED) {
> +		need_unlock = false;
> +		goto out_gmap;
> +	}
> +
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;
>  
> @@ -452,6 +460,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  		mmap_read_lock(mm);
>  		goto retry;
>  	}
> +out_gmap:
>  	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
>  		address =  __gmap_link(gmap, current->thread.gmap_addr,
>  				       address);
> @@ -466,7 +475,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	}
>  	fault = 0;
>  out_up:
> -	mmap_read_unlock(mm);
> +	if (need_unlock)
> +		mmap_read_unlock(mm);
>  out:

This seems to be incorrect. __gmap_link() requires the mmap_lock to be
held. Christian, Janosch, or David, could you please check?
