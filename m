From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] hexagon: kernel: kgdb: include related header for pass compiling.
Date: Fri, 01 Nov 2013 19:54:17 +0800
Message-ID: <52739669.9000509@asianux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

Need include related headers for pass compiling, the related error
(with allmodconfig for v4):

    CC      arch/hexagon/kernel/kgdb.o
  arch/hexagon/kernel/kgdb.c:30: error: invalid use of undefined type 'struct pt_regs'
  arch/hexagon/kernel/kgdb.c:31: error: invalid use of undefined type 'struct pt_regs'
  ...
  arch/hexagon/kernel/kgdb.c:220: error: implicit declaration of function 'local_irq_save'
  arch/hexagon/kernel/kgdb.c:222: error: implicit declaration of function 'local_irq_restore'
  ...


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/hexagon/kernel/kgdb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
index 82d5c25..038580c 100644
--- a/arch/hexagon/kernel/kgdb.c
+++ b/arch/hexagon/kernel/kgdb.c
@@ -18,6 +18,8 @@
  * 02110-1301, USA.
  */
 
+#include <linux/irq.h>
+#include <linux/sched.h>
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
 
-- 
1.7.7.6
