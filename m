From: Adam Buchbinder <adam.buchbinder@gmail.com>
Subject: [PATCH] hexagon: Fix misspellings in comments.
Date: Wed, 24 Feb 2016 10:49:53 -0800
Message-ID: <1456339793-4118-1-git-send-email-adam.buchbinder@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4DYYTbVp2wVhQ9XRYXyPWqqRRzlUnt4H5cw6VbhVwe0=;
        b=Ljre210izp/MnpXqhpf8zWGMUuOC2T9xgY5BVh4ixWg/9ZNMebDJJI4l0B6xBEakXD
         J0BHVZf2kKqGos7B4vO6ld2Ld0X5tUJPzUW39SJd2B2rPubszEhHNq+7hloP7CUpMxY2
         LVzdGfUtniP8n01z47lYTz82TkKVQzMWcABh0dDKjH0pFAa0LVRx4bPAxoIAFdEQE0Qw
         zQttjC8fvk6NI07w4ohgtreDdZ/MQIUAiiW6LBjceNNTIWQiF4bviuyL2a23XM2eQ5Hi
         sZ2pQ3q7C0CflBYFZz7QhVp3DBymdPIlNo/C+c38sKD1kRJYz7ITRph5gSa802EYmn39
         KsLA==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org
Cc: trivial@kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 arch/hexagon/include/asm/hexagon_vm.h | 2 +-
 arch/hexagon/include/asm/vm_mmu.h     | 2 +-
 arch/hexagon/kernel/kgdb.c            | 4 ++--
 arch/hexagon/kernel/vm_ops.S          | 2 +-
 arch/hexagon/lib/memcpy.S             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index 1f6918b..e8990c9 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -237,7 +237,7 @@ static inline long __vmintop_clear(long i)
 
 /*
  * The initial program gets to find a system environment descriptor
- * on its stack when it begins exection. The first word is a version
+ * on its stack when it begins execution. The first word is a version
  * code to indicate what is there.  Zero means nothing more.
  */
 
diff --git a/arch/hexagon/include/asm/vm_mmu.h b/arch/hexagon/include/asm/vm_mmu.h
index 096537d..6fc29d9 100644
--- a/arch/hexagon/include/asm/vm_mmu.h
+++ b/arch/hexagon/include/asm/vm_mmu.h
@@ -78,7 +78,7 @@
 #define	__HEXAGON_C_WB_L2	0x7	/* Write-back, with L2 */
 
 /*
- * This can be overriden, but we're defaulting to the most aggressive
+ * This can be overridden, but we're defaulting to the most aggressive
  * cache policy, the better to find bugs sooner.
  */
 
diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
index 038580c..62dece3 100644
--- a/arch/hexagon/kernel/kgdb.c
+++ b/arch/hexagon/kernel/kgdb.c
@@ -236,9 +236,9 @@ static struct notifier_block kgdb_notifier = {
 };
 
 /**
- * kgdb_arch_init - Perform any architecture specific initalization.
+ * kgdb_arch_init - Perform any architecture specific initialization.
  *
- * This function will handle the initalization of any architecture
+ * This function will handle the initialization of any architecture
  * specific callbacks.
  */
 int kgdb_arch_init(void)
diff --git a/arch/hexagon/kernel/vm_ops.S b/arch/hexagon/kernel/vm_ops.S
index 9fb77b3..58f2b92 100644
--- a/arch/hexagon/kernel/vm_ops.S
+++ b/arch/hexagon/kernel/vm_ops.S
@@ -26,7 +26,7 @@
  * could be, and perhaps some day will be, handled as in-line
  * macros, but for tracing/debugging it's handy to have
  * a single point of invocation for each of them.
- * Conveniently, they take paramters and return values
+ * Conveniently, they take parameters and return values
  * consistent with the ABI calling convention.
  */
 
diff --git a/arch/hexagon/lib/memcpy.S b/arch/hexagon/lib/memcpy.S
index 81c561c..a46093a 100644
--- a/arch/hexagon/lib/memcpy.S
+++ b/arch/hexagon/lib/memcpy.S
@@ -39,7 +39,7 @@
  *   DJH 10/14/09 Version 1.3 added special loop for aligned case, was
  *                            overreading bloated codesize back up to 892
  *   DJH  4/20/10 Version 1.4 fixed Ldword_loop_epilog loop to prevent loads
- *                            occuring if only 1 left outstanding, fixes bug
+ *                            occurring if only 1 left outstanding, fixes bug
  *                            # 3888, corrected for all alignments. Peeled off
  *                            1 32byte chunk from kernel loop and extended 8byte
  *                            loop at end to solve all combinations and prevent
-- 
2.7.0.rc3.207.g0ac5344
