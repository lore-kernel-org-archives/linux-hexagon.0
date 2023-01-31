From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 03/10] ia64: fix livelock in uaccess
Date: Tue, 31 Jan 2023 20:04:28 +0000
Message-ID: <Y9l0TM6HPoS/V/LX@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bl5iUXqmXEOZR8ifG6HKyF4x1jQ0mIa3D3l9XR4PaTE=; b=T1pWKmZWPHuHO8Jyn7S5P/zto+
        UZfPKBZyRLG27ebQFQOn/fWzfDlIAMxY5HnpFAsDM33oCZ+/Oqy97hkFrd/ty/TtBVplGI9UlZkpc
        fbW++/mewnSYFO9jvmdzRomSgggz4wlhTLgqvJVMyFQJo7JNjGdbYjrvvOCf8fp0gxg7cOp7xtr3r
        ESdWCs27/xj5QzXKLgnJBxqhbIe9xDzRoYllJ//kxI1dcU2VM9HH60bLK1f0Ri53IBKDWu4a9kqmF
        F2PtXGW3wiF+E43i3v0Rvv/Ti4b5qXLpcgoQxKTylUS/49rUu8IB+gb4J12gNq/O4ec6MWulnmUSJ
        YSws+EYw==;
Content-Disposition: inline
In-Reply-To: <Y9lz6yk113LmC9SI@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

ia64 equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index ef78c2d66cdd..85c4d9ac8686 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -136,8 +136,11 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 */
 	fault = handle_mm_fault(vma, address, flags, regs);
 
-	if (fault_signal_pending(fault, regs))
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
 		return;
+	}
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
-- 
2.30.2

