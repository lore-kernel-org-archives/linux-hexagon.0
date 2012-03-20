From: Kautuk Consul <consul.kautuk@gmail.com>
Subject: [PATCH 11/20] hexagon/mm/vm_fault.c: Port OOM changes to do_page_fault
Date: Tue, 20 Mar 2012 09:23:33 -0400
Message-ID: <1332249813-2970-1-git-send-email-consul.kautuk@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Stk454fJV0HqVErIAwgf0+tDhfekSQ/T7hgoxqXQK60=;
        b=K1Cbij493ZWvxZR4ts2QaYZayQa9pPsPouN/vweMhWV5WpvH/pPY3ziIRMfHfbFqy5
         3lw0ww56ZNcDtd5zZWAQ8n87fu0fiRW2xFJ5EOdEuzAg6czcIfFp1yXEAbl/SkMGNgex
         zGJ5RN+Ot2HpEOD+dwzWxAKPm9O8jE8U+Qe39xAIYSTzCZyVzxdwP4aL//OjBNIpr7qp
         MFMI+AuXnVBN0mNmIjroZ450llMxGKjS2VaeKNSVdmE0YhLWW0fVSwy74+oWP76sae4+
         I/aEt7L1bdLClWsY8kll0ryobp24z+D9ZvWD+Gs753n63WvzmFr8PQMi3aH7EiQN590r
         0hYg==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>, Linas Vepstas <linas@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Kautuk Consul <consul.kautuk@gmail.com>

Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
(mm: retry page fault when blocking on disk transfer) and
commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
(x86,mm: make pagefault killable)

The above commits introduced changes into the x86 pagefault handler
for making the page fault handler retryable as well as killable.

These changes reduce the mmap_sem hold time, which is crucial
during OOM killer invocation.

Port these changes to hexagon.

Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
---
 arch/hexagon/mm/vm_fault.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index c10b76f..06695cc 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -53,6 +53,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	int si_code = SEGV_MAPERR;
 	int fault;
 	const struct exception_table_entry *fixup;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
+				 (cause > 0 ? FAULT_FLAG_WRITE : 0);
 
 	/*
 	 * If we're in an interrupt or have no user context,
@@ -63,6 +65,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	local_irq_enable();
 
+retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -96,14 +99,23 @@ good_area:
 		break;
 	}
 
-	fault = handle_mm_fault(mm, vma, address, (cause > 0));
+	fault = handle_mm_fault(mm, vma, address, flags);
+
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+		return;
 
 	/* The most common case -- we are done. */
 	if (likely(!(fault & VM_FAULT_ERROR))) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
+		if (flags & FAULT_FLAG_ALLOW_RETRY) {
+			if (fault & VM_FAULT_MAJOR)
+				current->maj_flt++;
+			else
+				current->min_flt++;
+			if (fault & VM_FAULT_RETRY) {
+				flags &= ~FAULT_FLAG_ALLOW_RETRY;
+				goto retry;
+			}
+		}
 
 		up_read(&mm->mmap_sem);
 		return;
-- 
1.7.5.4
