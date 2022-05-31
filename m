From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v5] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Tue, 31 May 2022 09:59:37 +0200
Message-ID: <YpXK6VO8y6ZQlimG@osiris>
References: <20220530183450.42886-1-peterx@redhat.com>
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
	List-Owner; bh=vJpad1Ws9FzZ+519RnE2ii45eeDrMTi6fWGgcjdDZGE=; b=uO8L8JRZ6cDgId
	58tNuKmEykZw3P88Jzgpz2zdLDrpebK9GLwIHAuRkpgFz4bRrSjFRxizUTvfU6m4f52E1fGe7eUXX
	nnuPk6xp18HgfW95NkkBePBUGKAnfnKIxF5Lgw7wIXKE8Q7Wfw1K0oE6+aJa0hHhDAwUc0uww70Er
	HPkuNGuIqlYSoLDo0dCuSd2Ic7KEnDGb40n1+EsyH40qQX1esBFrDriWGttFaKATj/LtcHNku0xOe
	5WJ6teKCkvS2d03rW0EcEsmV3MnAIscq9333IW+HbB8FNKXQpfOVocnkv8saTy9fYJg5Zi+rLAQ1A
	re795lYnIMDjRb+O8RXA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fCDCNg9Fl0rDsWI5cVbkr7yPCpu4aY2vi3Um9DXKuyo=;
 b=TwuPNcBR4U1XYDHdlIDZYKqcL5KJT69oeeTAf0vy5m7ooDBj90SBRisXK63xMXHvK8l0
 Ov/cquTEsxXxBim+UukTU2rsQcn6NprZ4HWRN68SlwYgZXcr9qZgM89RGc6MwoI/bqEL
 o6GOS/aiaC9dqiy4ahWeqSt5T6xN5hmciCI34Qmd0QVrEU1vbyvV2QBCOIg+JzaMgATb
 8jaFh0BsNFxNOHSjg3UgeRvf/2N2Wujv9geXH5fdOj7Ye52btvKTOJPDKvku8NHfDMem
 dO2O0Q0YLPZWYG0qyBQJvfeeNv5XIulDxvgh2q56ULI3MONZBMZ+0s0xvmHu5XqW+/Ip CA== 
Content-Disposition: inline
In-Reply-To: <20220530183450.42886-1-peterx@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Stafford Horne <shorne@gmail.com>, "David S . Miller" <davem@davemloft.net>, Johannes Berg <johannes@sipsolutions.net>, Brian Cain <bcain@quicinc.com>, x86@kernel.org, linux-parisc@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-hexagon@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Janosch Frank <frankja@linux.ibm.com>, Albert Ou <aou@eecs.berkeley.edu>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-ia64@vger.kernel.org

On Mon, May 30, 2022 at 02:34:50PM -0400, Peter Xu wrote:
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
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Vineet Gupta <vgupta@kernel.org>
> Acked-by: Guo Ren <guoren@kernel.org>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
...
>  arch/s390/mm/fault.c          | 12 ++++++++++++
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e173b6187ad5..973dcd05c293 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -433,6 +433,17 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  			goto out_up;
>  		goto out;
>  	}
> +
> +	/* The fault is fully completed (including releasing mmap lock) */
> +	if (fault & VM_FAULT_COMPLETED) {
> +		if (gmap) {
> +			mmap_read_lock(mm);
> +			goto out_gmap;
> +		}
> +		fault = 0;
> +		goto out;
> +	}
> +
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;
>  
> @@ -452,6 +463,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  		mmap_read_lock(mm);
>  		goto retry;
>  	}
> +out_gmap:
>  	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
>  		address =  __gmap_link(gmap, current->thread.gmap_addr,
>  				       address);

FWIW:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
