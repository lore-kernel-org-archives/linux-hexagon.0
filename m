From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10 30/63] hexagon: add support for TIF_NOTIFY_SIGNAL
Date: Tue,  3 Jan 2023 09:14:00 +0100
Message-ID: <20230103081310.386730622@linuxfoundation.org>
References: <20230103081308.548338576@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672733747;
        bh=lVkhJSuC3IowY6x05isk2+fmIZYOlISTPGIA+JFIPO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUMF+1uI4I/GMUYDhyB+Hngtoe3vxWxcab3114NIWjO1ReXzkoFNOziz6A29kmpbt
         e3hX0n4IJ5qJX0uPKL5jRcX8tDDXMGF6cwMzX75k2oQZ/PmQZ9+wJWYro17iJ7lW3c
         RxLSVxDwJRlLKRnRELdrZfCYjTVxl0Dv0GpZ2Bzw=
In-Reply-To: <20230103081308.548338576@linuxfoundation.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, linux-hexagon@vger.kernel.org, Brian Cain <bcain@codeaurora.org>, Jens Axboe <axboe@kernel.dk>

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit aeec8193578a71d0aee21218351849d38121ce90 ]

Wire up TIF_NOTIFY_SIGNAL handling for hexagon.

Cc: linux-hexagon@vger.kernel.org
Acked-by: Brian Cain <bcain@codeaurora.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/hexagon/include/asm/thread_info.h |    2 ++
 arch/hexagon/kernel/process.c          |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -95,6 +95,7 @@ register struct thread_info *__current_t
 #define TIF_NEED_RESCHED        3       /* rescheduling necessary */
 #define TIF_SINGLESTEP          4       /* restore ss @ return to usr mode */
 #define TIF_RESTORE_SIGMASK     6       /* restore sig mask in do_signal() */
+#define TIF_NOTIFY_SIGNAL	7       /* signal notifications exist */
 /* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE              17      /* OOM killer killed process */
 
@@ -103,6 +104,7 @@ register struct thread_info *__current_t
 #define _TIF_SIGPENDING         (1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED       (1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP         (1 << TIF_SINGLESTEP)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 
 /* work to do on interrupt/exception return - All but TIF_SYSCALL_TRACE */
 #define _TIF_WORK_MASK          (0x0000FFFF & ~_TIF_SYSCALL_TRACE)
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -174,7 +174,7 @@ int do_work_pending(struct pt_regs *regs
 		return 1;
 	}
 
-	if (thread_info_flags & _TIF_SIGPENDING) {
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
 		do_signal(regs);
 		return 1;
 	}


