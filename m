From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 08/10] parisc: fix livelock in uaccess
Date: Tue, 31 Jan 2023 20:06:27 +0000
Message-ID: <Y9l0w4M91DwYLO3N@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Va46d86eM1Bc2zftK4w6YVIH/9TSKHJFKV1SMXapYTA=; b=wP1rmspskn7rYIm3LIubWz3zZY
        CX7Pm1fllvuDHdAV0IOAnSDgrsaowkvoRmi/XUYRBrjGq3ixNXrTgSKteSegRq92d4ZSuD2x4KFqN
        n64Lx21+SSTyHwh9ZQTkuJ5tSwYqU543ckEgA0Afvo3XT8tp2WFfrZADEX/iSevSCRtO4lo4UZKUd
        uMAnRpLwr7SxtDn29dSzBAsDhDi1jL2v7u6WaHriQRKtfQTLK52Pew4tfOJqXzALx0qtScNMOJCrQ
        VIm60E7FRBQGzyrh8RI0tkmGD+i2Z8lIe1R/29aG3eeR/81AwwdA+P75WnbVplBNdABD9j2/J2gJM
        7+tiSftg==;
Content-Disposition: inline
In-Reply-To: <Y9lz6yk113LmC9SI@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 869204e97ec9..bb30ff6a3e19 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
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

