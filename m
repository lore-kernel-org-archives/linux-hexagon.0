From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 01/10] alpha: fix livelock in uaccess
Date: Tue, 31 Jan 2023 20:03:28 +0000
Message-ID: <Y9l0EDRr9DpNb5Pb@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ED6R08GbccKYIIX9kXT549IPtW4L7cqF2AXMvdmRFj4=; b=iNM2NyBX9qKzLnSjicxOotEmdb
        mPwBfHxw1JcxbXjAmuQzkUPkY076SeFW9sb+OEtR3wdxggD/OHl7HF+zCRhEDKyPAy7wtUQ04tVp3
        8nBqtkHhKsi9Xm58VZesKGNtjv7L3mh0zN0MWsZfar40SOh3yGMBypMpwAVllpvQK7XvGiD07RbVx
        KLUSciQqkdXkPxJs6MuDmfTwzuqJz2o2Ds1f0vjiLr7dRyMt1d7fXghuodLsn7lPVjZV7vudP5qG0
        Z6gCcHCEbZ5W/gjbvjr/2oKDctHKl/D8ra0DVYtaeptbIhqPn6qSCGk3NWvfxTtqe3xyyb6FoIWpa
        Zk9x+jrw==;
Content-Disposition: inline
In-Reply-To: <Y9lz6yk113LmC9SI@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

alpha equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index ef427a6bdd1a..7b01ae4f3bc6 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -152,8 +152,11 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	   the fault.  */
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

