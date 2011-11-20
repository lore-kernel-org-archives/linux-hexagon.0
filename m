From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] Remove unneeded include of version.h from
 arch/hexagon/include/asm/spinlock_types.h
Date: Sun, 20 Nov 2011 21:59:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111202157170.17195@swampdragon.chaosbits.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org
Cc: Richard Kuo <rkuo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

"make versioncheck" points out that arch/hexagon/include/asm/spinlock_types.h
does not need to include version.h .
A quick look at the file seems to confirm its findings, so here's a patch that
removes the include.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 arch/hexagon/include/asm/spinlock_types.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

 Please note: I've not done any compile tests or other tests to confirm 
              this patch since I have no way to build stuff for this 
              architecture, so please review carefully before applying.

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
1.7.7.3


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
