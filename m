From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 06/10] nios2: fix livelock in uaccess
Date: Tue, 31 Jan 2023 20:05:43 +0000
Message-ID: <Y9l0l94CC8weoyjV@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wVcE+3BmnOfE/NwR5UjnA+ry4zfP0RI8olAVTcvgEUs=; b=Ct+tFykDR6lyUvgdiXaL+wDIv/
        VFKiuRPBE9+1rOFXjTFIBjHI/P55UQYeegg4ROhJbh7VJrHAYz6EFq6N+X9LGTZvO8s+OvI5T7m9d
        qmQqtM6XOtNklHUYyAfzY0h/wRwNGPbnRNpVSNAxSoBo9MMFwyj6zvWApQgTlg7wfaK0w40U8kAwL
        tZaSXHiZmLA8SHXOzUDL9f2Pp+sChQqZRPkIOLXDx2QoHern1VKKeXIUcTcuvVj0N/fhBl775dcOT
        GOTmusZ8rUu+c3bWVqkzxdmhQULmaNnZH4EqUIU+DRw/mxAc8nmXIKaaBdqT5RIwNXWNYPVPOMzgN
        LnAE7PlQ==;
Content-Disposition: inline
In-Reply-To: <Y9lz6yk113LmC9SI@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

nios2 equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/nios2/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index edaca0a6c1c1..ca64eccea551 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -136,8 +136,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
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

