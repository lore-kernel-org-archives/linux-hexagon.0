From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH][resend] hexagon: Remove unneeded include of version.h
Date: Tue, 10 Apr 2012 23:37:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204102333460.31626@swampdragon.chaosbits.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Linas Vepstas <linasvepstas@gmail.com>, trivial@kernel.org

"make versioncheck" points out that arch/hexagon/include/asm/spinlock_types.h
does not need to include version.h .
A quick look at the file seems to confirm its findings, so here's a patch that
removes the include.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Acked-by: Linas Vepstas <linasvepstas@gmail.com>
---
 arch/hexagon/include/asm/spinlock_types.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/hexagon/include/asm/spinlock_types.h b/arch/hexagon/include/asm/spinlock_types.h
index 5e937af..99b5a75 100644
--- a/arch/hexagon/include/asm/spinlock_types.h
+++ b/arch/hexagon/include/asm/spinlock_types.h
@@ -21,8 +21,6 @@
 #ifndef _ASM_SPINLOCK_TYPES_H
 #define _ASM_SPINLOCK_TYPES_H
 
-#include <linux/version.h>
-
 #ifndef __LINUX_SPINLOCK_TYPES_H
 # error "please don't include this file directly"
 #endif
-- 
1.7.10


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
