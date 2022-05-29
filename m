From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Sun, 29 May 2022 22:33:23 +0200
Message-ID: <YpPYkzbrQmy4FjrI@osiris>
References: <20220527193936.30678-1-peterx@redhat.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=x4N7bX0DRRebDZ+llHBEoOO1y8RqkpeB+Jlf+Vx+ui4=;
 b=hakF/8aPF5DH3ICHAn7P7Q7xBA4KtdA0je0+nJRBs+xaI2hHDxgItX2ciwK19sCxk0JA
 lJnlqKta8jHKJkMqJ1rgWh3qDwM1i/TtlTQ6ooSKLwvTWHLC31BcYNAGC/G9N1aAutXV
 V/4AJkKs1JGbbdy51HbI6h6b7Z42larzwd7F8tbvXbgPaisrk9ryWS8vf9H7FU54t9UR
 0Eo3hWRTOOaJavYhxG1gVT9JHKnOc8gKYbkkKxn8voKk4y3jdzUzhrmCMfV05FMX0fA5
 j1Oa7gTPBzc3qIRMostgXnmcMPZVXypM3JAAZSk7OQxWvEnIL9TkJkNVyyqJFOQLb2Mf xw== 
Content-Disposition: inline
In-Reply-To: <20220527193936.30678-1-peterx@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>, Jonas Bonn <jonas@southpole.se>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, Russell King <>

On Fri, May 27, 2022 at 03:39:36PM -0400, Peter Xu wrote:
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e173b6187ad5..4608cc962ecf 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -433,6 +433,17 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  			goto out_up;
>  		goto out;
>  	}
> +
> +	/* The fault is fully completed (including releasing mmap lock) */
> +	if (fault & VM_FAULT_COMPLETED) {
> +		/*
> +		 * Gmap will need the mmap lock again, so retake it.  TODO:
> +		 * only conditionally take the lock when CONFIG_PGSTE set.
> +		 */
> +		mmap_read_lock(mm);
> +		goto out_gmap;
> +	}
> +
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;
>  

Guess the patch below on top of your patch is what we want.
Just for clarification: if gmap is not NULL then the process is a kvm
process. So, depending on the workload, this optimization makes sense.

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4608cc962ecf..e1d40ca341b7 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED) {
-		/*
-		 * Gmap will need the mmap lock again, so retake it.  TODO:
-		 * only conditionally take the lock when CONFIG_PGSTE set.
-		 */
-		mmap_read_lock(mm);
-		goto out_gmap;
+		if (gmap) {
+			mmap_read_lock(mm);
+			goto out_gmap;
+		}
+		goto out;
 	}
 
 	if (unlikely(fault & VM_FAULT_ERROR))
