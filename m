From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] hexagon: add support for TIF_NOTIFY_SIGNAL
Date: Thu, 29 Oct 2020 10:14:25 -0600
Message-ID: <249d67ab-c3ea-0802-c06a-0f35ae3673d2@kernel.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7mALKINqLYfxoHF1hVcRnp1bQETJW6jJOL3z9Zr8PKs=;
        b=hca5CQJiOZP4j5J9BnMNfZ9z2agIBD5RRjb+hkDEmn++g0ECZqM5kBLegGfJpDpepu
         MGEAOPdbRL8N4qyZBU7BUk6pUI33gM2jBkEW+seCS9s8bB8ooS6Rd+Rqm/iuPnv23zSo
         rllWi1d6V9WSOA/imzBcoMXhpdpRNA59wPL6WW99lDQ/IY+LdSCGw0y6820Ewx50i8Zt
         Vlz9yx+aL24clO+OGrxIa/50LBcDd+s4Nz5i35aNuV+lPiPu90/tRHtJ9yNvu9CflKWM
         DsKvm2Iwu9fRbtPPyax4lX3joJ3dmo562xzBN7fwuB0+sjey8OrC13101u5UTAbuVHO0
         QCMA==
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-hexagon@vger.kernel.org

Wire up TIF_NOTIFY_SIGNAL handling for hexagon.

Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
for details:

https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/

As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
as that will enable a set of cleanups once all of them support it. I'm
happy carrying this patch if need be, or it can be funelled through the
arch tree. Let me know.

 arch/hexagon/include/asm/thread_info.h | 2 ++
 arch/hexagon/kernel/process.c          | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index 563da1986464..535976665bf0 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -95,6 +95,7 @@ register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
 #define TIF_NEED_RESCHED        3       /* rescheduling necessary */
 #define TIF_SINGLESTEP          4       /* restore ss @ return to usr mode */
 #define TIF_RESTORE_SIGMASK     6       /* restore sig mask in do_signal() */
+#define TIF_NOTIFY_SIGNAL	7       /* signal notifications exist */
 /* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE              17      /* OOM killer killed process */
 
@@ -103,6 +104,7 @@ register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
 #define _TIF_SIGPENDING         (1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED       (1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP         (1 << TIF_SINGLESTEP)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 
 /* work to do on interrupt/exception return - All but TIF_SYSCALL_TRACE */
 #define _TIF_WORK_MASK          (0x0000FFFF & ~_TIF_SYSCALL_TRACE)
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 5a0a95d93ddb..82cd7a026eb3 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -174,7 +174,7 @@ int do_work_pending(struct pt_regs *regs, u32 thread_info_flags)
 		return 1;
 	}
 
-	if (thread_info_flags & _TIF_SIGPENDING) {
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
 		do_signal(regs);
 		return 1;
 	}
-- 
2.29.0

-- 
Jens Axboe

