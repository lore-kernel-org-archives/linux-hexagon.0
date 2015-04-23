From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] Revert "Hexagon: fix signal.c compile error"
Date: Wed, 22 Apr 2015 21:28:04 -0400
Message-ID: <1429752484-14499-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rkuo@codeaurora.org
Cc: linux-hexagon@vger.kernel.org

This reverts commit f3f601c1d2728f02544cfd143eaa82e5398b3e9b.

UAPI headers cannot use "uapi/" in their paths by design -- when they're
installed, they do not have the uapi/ prefix.  Otherwise doing so breaks
userland badly.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 arch/hexagon/include/uapi/asm/signal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/signal.h b/arch/hexagon/include/uapi/asm/signal.h
index 98106e5..24b9988 100644
--- a/arch/hexagon/include/uapi/asm/signal.h
+++ b/arch/hexagon/include/uapi/asm/signal.h
@@ -19,8 +19,6 @@
 #ifndef _ASM_SIGNAL_H
 #define _ASM_SIGNAL_H
 
-#include <uapi/asm/registers.h>
-
 extern unsigned long __rt_sigtramp_template[2];
 
 void do_signal(struct pt_regs *regs);
-- 
2.3.5
