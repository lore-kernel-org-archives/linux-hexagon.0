From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Thu, 26 May 2022 22:39:15 -0700
Message-ID: <CAMo8BfJWzUnwPyWKsBsW2-x7t=Go5Mwb643kXm5BfpVDAeaeWA@mail.gmail.com>
References: <20220524234531.1949-1-peterx@redhat.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2j31mgyTy2/RMpvPafIuRR/7M5aCsOn5pH1JxQKELh0=;
        b=WLF0ZKcKkqyL/2e9Vrm4jJIU7Iq70SjWVWeR4mG+diJpadGhfuylwbDWHZVjDdFbuq
         Hxc+zHrNjRLjtRhI1yhC+nolDKLNrwOV2/oaWTaoh4VCK67BB0z5yPlcOmnthCOgtmez
         8jkwQgYPNLUuG0ZEbUiSy7uVEpWFtrO5L4UM+4mbtXpWMiQIVZp0eLdp45xYgN9Jmvmc
         aulsD6JeO/TIOhvHj+bALfaW9BR7tPWEUeyaMI8bJbO4wOxVeH/I0lrHRJ+FP9F521BK
         /lEKp/SRZycKZGHLE0LZwkZV2trusLGaniTNIWTP9EnU7l+Xe/n5XI3K1uCmL30r4C8o
         Jgxw==
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Xu <peterx@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Matt Turner <mattst88@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>, Michal Simek <monstr@monstr.eu>, Russell King <linux@armlinux.org.uk>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-riscv <linux-riscv@lists.infradead.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <aarcange@redhat.com>, openrisc@lists.librecores.org, linux-s390 <linux-s390@vger.kernel.org>

On Tue, May 24, 2022 at 4:45 PM Peter Xu <peterx@redhat.com> wrote:
>
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
> ---
>
> v3:
> - Rebase to akpm/mm-unstable
> - Copy arch maintainers
> ---

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
