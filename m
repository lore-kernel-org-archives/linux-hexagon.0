From: Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Wed, 25 May 2022 20:40:51 -0700
Message-ID: <8f6add25-2e8f-4533-fa42-e43db0e32f2d@kernel.org>
References: <20220524234531.1949-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653536455;
        bh=/FC3fRDbTNCC3O7WmAhxUVAkmggWpUFeLv7OpR1lxLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hLLrqk/dSj3ABZgHj+oG01SXfcPdfcPLbCPW5c/vtlKKjGhr826rFN6lLQogyE6R+
         V4+rLm9jBH6we4JcRrEMO+7ArvhQ4vUukeFX5qG0umNfJEjOVl7t+dToTe7orX2kZK
         bSWoDGynO3/vHi04K7UfgRIeRSjHN5GtmmMIX2USGvftGI9pdfeJrjgnAmxrltc5n0
         8y833O4MCr4JKKzVPSDGbAvYYjpDQY/dQCqYoM1yOIlCVTJtDFNiHcFx0Vs05+lAF0
         ALTHrfJeOAfPcImvCexeRL9L6Mpy6p/bjPRzg8B1971s8Zq8YHz1AyoKFvxIGL0AWO
         PHAjKqVSOf5bw==
Content-Language: en-US
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Matt Turner <mattst88@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>, Michal Simek <monstr@monstr.eu>, Russell King <linux@armlinux.org.uk>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-riscv@lists.infradead.org, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <aarcange@redhat.com>, openrisc@lists.librecores.org, linux-s390@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-m68k@lists.linux-m68k.org, Palmer Dabbelt <palmer@dabbelt.com>, Heiko



On 5/24/22 16:45, Peter Xu wrote:
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
>    Before: 650.980 ms (+-1.94%)
>    After:  569.396 ms (+-1.38%)
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
> Signed-off-by: Peter Xu<peterx@redhat.com>
> ---
>
> v3:
> - Rebase to akpm/mm-unstable
> - Copy arch maintainers
> ---
>    arch/arc/mm/fault.c           |  4 ++++

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx,
-Vineet
