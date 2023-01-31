From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 02/10] hexagon: fix livelock in uaccess
Date: Tue, 31 Jan 2023 20:03:59 +0000
Message-ID: <Y9l0LyAA3zAGeT51@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NiUEF1IXJzgFv+aygXF4aq+5ipqUNm7thH541I6WfmM=; b=qrX5aIC933LH7FY3NYNDGqcac3
        J4RLy9ITM/ESnjrkRtt+ZQZJOfvq0nIQwfvgMBcOTyfnzTmsJv84XzPORhXETQTOoOLXXWaMPU11g
        wWvVQAG9vO2sKKmMVQG8WX8stYodaZrmsCPGFrGtLUFejEjbL5wY0E4oFziMjX/2m0AbZQSq8/0uo
        hwlfhKenawZVF2SiZJ4iM3vie9sd4lhkhYK7rAPK7z2zUPYejBHQbpjvBB2tcRo3dqkR/nIhuM5/c
        9ssUOIlT1HzcYif+UgzMVS3T5gmkNtW3FdxCDLxJ0wrOJVILV80fadrELvoH7vDx8WyS7SD6axv1Z
        hQer2gQA==;
Content-Disposition: inline
In-Reply-To: <Y9lz6yk113LmC9SI@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

hexagon equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/hexagon/mm/vm_fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index f73c7cbfe326..4b578d02fd01 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -93,8 +93,11 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
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

