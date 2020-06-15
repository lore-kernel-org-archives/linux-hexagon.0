From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 08/25] mm/hexagon: Use mm_fault_accounting()
Date: Mon, 15 Jun 2020 18:15:50 -0400
Message-ID: <20200615221607.7764-9-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRPudttfpR19+A+wbv6ggjFdv06B9VcI4/AzH9oClaw=;
        b=SXXwbGr7pA16+zx+tpZWg50fe/cmCam1jrappswwYhNVmM4EqK/lsYRCsDX8MHvBACXgR6
        mwZY+GesVNnq96Xk1u9cipX8w00tY0CpSDisDNwMfhLgFIn7kZgyaKO3CI17x63wn51P8P
        Ke7N3HFAD3UdyqSXlegAAC0cezMa2+M=
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

The perf event accounting will be included too if possible.  Also, do the
accounting after releasing the mmap_sem.

CC: Brian Cain <bcain@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/hexagon/mm/vm_fault.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 72334b26317a..5fbccfce6083 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -39,7 +39,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	int si_signo;
 	int si_code = SEGV_MAPERR;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	const struct exception_table_entry *fixup;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
@@ -90,6 +90,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	}
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -97,17 +98,13 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
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
 			}
 		}
-
 		up_read(&mm->mmap_sem);
+		mm_fault_accounting(current, regs, address, major);
 		return;
 	}
 
-- 
2.26.2

