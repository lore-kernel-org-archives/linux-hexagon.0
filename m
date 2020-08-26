From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 07/23] hexagon: use asm-generic/mmu_context.h for no-op implementations
Date: Thu, 27 Aug 2020 00:52:33 +1000
Message-ID: <20200826145249.745432-8-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCO6eQrXV/q62wlJ5dCHYkGXNXvcNXkjUmp1GwIXZy0=;
        b=RRiXPLTMXyNxkd/Q7cSppCEX4ypohtTUouPii1Ko6lFloN8J5gkEMLinRU6wt4LQS6
         DESO9NUZRxUwuB//GtGcpHfxW+jUTGTO+b9WiHCTCM8XE7h69ydPbdwyRu0lgf/+ThZM
         MhP2CJ1kDWYtrGOrgaTF7J899dRXB31I05zBRy6Xd2VkwBUGM2m1zNGgWueXOBWSDlOv
         /Dn9Vhk1Wddl8VNkvumE7XqIoCaS9zLYW5TvXZLkV7PiqQ4zedbHYaIJdfKdSfz/Dj6n
         903g+aLWs0KDriJmB34o2kFI8OwDEwuliPN/BaEMCUVrlfjBI0hj+YIWs+XeT4GhJ3uk
         sIaA==
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, Brian Cain <bcain@codeaurora.org>

Cc: linux-hexagon@vger.kernel.org
Acked-by: Brian Cain <bcain@codeaurora.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/hexagon/include/asm/mmu_context.h | 33 ++++----------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/hexagon/include/asm/mmu_context.h b/arch/hexagon/include/asm/mmu_context.h
index cdc4adc0300a..81947764c47d 100644
--- a/arch/hexagon/include/asm/mmu_context.h
+++ b/arch/hexagon/include/asm/mmu_context.h
@@ -15,39 +15,13 @@
 #include <asm/pgalloc.h>
 #include <asm/mem-layout.h>
 
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 /*
  * VM port hides all TLB management, so "lazy TLB" isn't very
  * meaningful.  Even for ports to architectures with visble TLBs,
  * this is almost invariably a null function.
+ *
+ * mm->context is set up by pgd_alloc, so no init_new_context required.
  */
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *tsk)
-{
-}
-
-/*
- * Architecture-specific actions, if any, for memory map deactivation.
- */
-static inline void deactivate_mm(struct task_struct *tsk,
-	struct mm_struct *mm)
-{
-}
-
-/**
- * init_new_context - initialize context related info for new mm_struct instance
- * @tsk: pointer to a task struct
- * @mm: pointer to a new mm struct
- */
-static inline int init_new_context(struct task_struct *tsk,
-					struct mm_struct *mm)
-{
-	/* mm->context is set up by pgd_alloc */
-	return 0;
-}
 
 /*
  *  Switch active mm context
@@ -74,6 +48,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 /*
  *  Activate new memory map for task
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	unsigned long flags;
@@ -86,4 +61,6 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 /*  Generic hooks for arch_dup_mmap and arch_exit_mmap  */
 #include <asm-generic/mm_hooks.h>
 
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

