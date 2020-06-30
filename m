From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH v4 07/26] mm/hexagon: Use general page fault accounting
Date: Tue, 30 Jun 2020 17:57:29 -0500
Message-ID: <283701d64f31$d63a11d0$82ae3570$@codeaurora.org>
References: <20200630204519.38809-1-peterx@redhat.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593557853; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=VpubEwscYy9Um/86J1tXHFPq+iEVca+qWyYHhgHXdzY=; b=K0xR/NvipBz9bWASkykf7+vBfdvgjUXqMa6IQ5lJjc3i1+0BZWlYC1hh21khN1iVaE2NVA3h
 8SdoXjfQXcWTnWYm0V0yOKsLZSLsaaYmetuefVQdskpoo9sIF/W9JY78H/QFC5Fmco1GUEks
 MZrrabcKyCsGxSxWo/NrBF+bK84=
In-Reply-To: <20200630204519.38809-1-peterx@redhat.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Peter Xu' <peterx@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'John Hubbard' <jhubbard@nvidia.com>, 'Michael Ellerman' <mpe@ellerman.id.au>, 'Gerald Schaefer' <gerald.schaefer@de.ibm.com>, 'Andrea Arcangeli' <aarcange@redhat.com>, 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Will Deacon' <will@kernel.org>, linux-hexagon@vger.kernel.org


> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
...

Acked-by: Brian Cain <bcain@codeaurora.org>

> CC: Brian Cain <bcain@codeaurora.org>
> CC: linux-hexagon@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/hexagon/mm/vm_fault.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
> index f12f330e7946..ef32c5a84ff3 100644
> --- a/arch/hexagon/mm/vm_fault.c
> +++ b/arch/hexagon/mm/vm_fault.c
> @@ -18,6 +18,7 @@
>  #include <linux/signal.h>
>  #include <linux/extable.h>
>  #include <linux/hardirq.h>
> +#include <linux/perf_event.h>
> 
>  /*
>   * Decode of hardware exception sends us to one of several @@ -53,6 +54,8
> @@ void do_page_fault(unsigned long address, long cause, struct pt_regs
> *regs)
> 
>  	if (user_mode(regs))
>  		flags |= FAULT_FLAG_USER;
> +
> +	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  retry:
>  	mmap_read_lock(mm);
>  	vma = find_vma(mm, address);
> @@ -88,7 +91,7 @@ void do_page_fault(unsigned long address, long cause,
> struct pt_regs *regs)
>  		break;
>  	}
> 
> -	fault = handle_mm_fault(vma, address, flags, NULL);
> +	fault = handle_mm_fault(vma, address, flags, regs);
> 
>  	if (fault_signal_pending(fault, regs))
>  		return;
> @@ -96,10 +99,6 @@ void do_page_fault(unsigned long address, long cause,
> struct pt_regs *regs)
>  	/* The most common case -- we are done. */
>  	if (likely(!(fault & VM_FAULT_ERROR))) {
>  		if (flags & FAULT_FLAG_ALLOW_RETRY) {
> -			if (fault & VM_FAULT_MAJOR)
> -				current->maj_flt++;
> -			else
> -				current->min_flt++;
>  			if (fault & VM_FAULT_RETRY) {
>  				flags |= FAULT_FLAG_TRIED;
>  				goto retry;
> --
> 2.26.2


