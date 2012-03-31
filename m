From: Kautuk Consul <consul.kautuk@gmail.com>
Subject: [PATCH 10/19 v2] hexagon/mm/vm_fault.c: Port OOM changes to do_page_fault
Date: Sat, 31 Mar 2012 08:03:59 -0400
Message-ID: <1333195439-5251-1-git-send-email-consul.kautuk@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GzqRDdd4Jmix9NJ1655W+sFvZ5lc4IHkO/QKvGbTeCE=;
        b=G9Yyg/Ijj4w6XIN0QQa7kFqHAPsGij5JonmCESICFYpicHwGembInJQV/cdNjK5wba
         6trwj3s4pUCqeOVaTdhBNdRtLfoNuEIqFviO015yKK/3CYnE6iUyXdGqM7JvfNk7YynZ
         QnuPF0EQU6frpeHzf4RCg9GBTY5xZLBJDD5uXW/b3v5iz9fCoBkHRq42VWXkncehTftj
         IkCrlIrEzb99OzV4nNXIzcIlwm+Hhw54xP8oLtz2p03s+7nMeLEBCrhyGtTnAyHqM2sb
         OoVsOxxxMTAGUfLihJrQV55Mg8WfE65DOUnBQFv8uhdxNTVqfRGD+/T2Q5HoLN1cmxMQ
         0ubQ==
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
Acked-by: Richard Kuo <rkuo@codeaurora.org>
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
+	unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
+			      (cause > 0 ? FAULT_FLAG_WRITE : 0));
 
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
