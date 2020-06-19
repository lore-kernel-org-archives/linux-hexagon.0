From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 07/26] mm/hexagon: Use general page fault accounting
Date: Fri, 19 Jun 2020 12:05:19 -0400
Message-ID: <20200619160538.8641-8-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SagB2x6xDXMHuNfH0nszNoiVH7/+fXWLgMfhv8WOo7E=;
        b=SXuQscfIp84Jam/3SNag7zZHTrGwnKri/xm+9Yk4bv7VuxQWefJbFQq4NZY2De8nCxOs6R
        1mXbMC6ZG3ckJuBNrVEiNUYsea5P6aOF4kG2MDm8bfcnqAku/gO6u2oh3RECEVxm3CVA9s
        FER3YW8QvV85Uw3gyq4cDyy2Z8+IJp4=
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Brian Cain <bcain@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/hexagon/mm/vm_fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index f04cd0a6d905..1b1802f30862 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -19,6 +19,7 @@
 #include <linux/signal.h>
 #include <linux/extable.h>
 #include <linux/hardirq.h>
+#include <linux/perf_event.h>
 
 /*
  * Decode of hardware exception sends us to one of several
@@ -54,6 +55,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -89,7 +92,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		break;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -97,10 +100,6 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	/* The most common case -- we are done. */
 	if (likely(!(fault & VM_FAULT_ERROR))) {
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 				goto retry;
-- 
2.26.2

