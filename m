From: Peter Xu <peterx@redhat.com>
Subject: [PATCH v4 07/26] mm/hexagon: Use general page fault accounting
Date: Tue, 30 Jun 2020 16:45:19 -0400
Message-ID: <20200630204519.38809-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0oSiaS0i/TrG3B4WZW/K39VImBtqNKePW8X1XXaS114=;
        b=PTcb8VCOlgCDHBpzS41F6ZA2tnwsdq7D+KRtffXAmpbjcY4Z07+uuQysYUvbkPON0vLL2B
        hhtaRRjv67EiguIwO/sPQbl9uKk79XHn+i15HETFRcXpKVYpy0JdNjiTHW+OkBflgwRrcF
        H5nSa3HQC3tqBqqiknsWmTcrVO6x594=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

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
index f12f330e7946..ef32c5a84ff3 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -18,6 +18,7 @@
 #include <linux/signal.h>
 #include <linux/extable.h>
 #include <linux/hardirq.h>
+#include <linux/perf_event.h>
 
 /*
  * Decode of hardware exception sends us to one of several
@@ -53,6 +54,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -88,7 +91,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		break;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -96,10 +99,6 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
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

