From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] hexagon: include: asm: kgdb: extend DBG_MAX_REG_NUM for "cs0/1"
Date: Fri, 01 Nov 2013 19:55:38 +0800
Message-ID: <527396BA.7050906@asianux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

Need extend maximized number for "cs0/1", the related warning (with
allmodconfig for v4):

  arch/hexagon/kernel/kgdb.c:79: warning: excess elements in array initializer
  arch/hexagon/kernel/kgdb.c:79: warning: (near initialization for 'dbg_reg_def')
  arch/hexagon/kernel/kgdb.c:80: warning: excess elements in array initializer
  arch/hexagon/kernel/kgdb.c:80: warning: (near initialization for 'dbg_reg_def')


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/hexagon/include/asm/kgdb.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/kgdb.h b/arch/hexagon/include/asm/kgdb.h
index 32a6fb6..ccd3ac3 100644
--- a/arch/hexagon/include/asm/kgdb.h
+++ b/arch/hexagon/include/asm/kgdb.h
@@ -34,10 +34,11 @@ static inline void arch_kgdb_breakpoint(void)
  * 32 gpr + sa0/1 + lc0/1 + m0/1 + gp + ugp + pred + pc = 42 total.
  * vm regs = psp+elr+est+badva = 4
  * syscall+restart = 2 more
- * so 48 = 42 +4 + 2
+ * also add cs0/1 = 2
+ * so 48 = 42 + 4 + 2 + 2
  */
 #define DBG_USER_REGS 42
-#define DBG_MAX_REG_NUM (DBG_USER_REGS + 6)
+#define DBG_MAX_REG_NUM (DBG_USER_REGS + 8)
 #define NUMREGBYTES  (DBG_MAX_REG_NUM*4)
 
 #endif /* __HEXAGON_KGDB_H__ */
-- 
1.7.7.6
