From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 07/23] hexagon: use asm-generic/mmu_context.h for no-op implementations
Date: Wed,  2 Sep 2020 00:15:23 +1000
Message-ID: <20200901141539.1757549-8-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCO6eQrXV/q62wlJ5dCHYkGXNXvcNXkjUmp1GwIXZy0=;
        b=jY0Xaw9JClMjKguKr4toi3p2h52MIKL8klJRnYZgFU374fx+7NSFwezgNkVvksRVOy
         DYkQbHh7OHKuhcayw9z3bY5GcYg3oGuCrZLLRFoB/4MZq3ZzD4tuKb048U8PY8HJPD3G
         WkGilznMqAHXKZWW5arP54iwQAqH+klI5v08g+l3XG4qDb39FE7bdubGz787QJKoEjSu
         Q0hRLmVw+tp2JsWReiv9abKKc6uOy/oAhdh1NYAXW+W8LPsIa5SNCDXVCxlP54ntb8qu
         cXcSVccpvMjq65/ErNO7QIUO9gnI+msCcv1artDIopurRB/jlS5gQB4fO6Dxm7udd3PF
         yOtw==
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
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

