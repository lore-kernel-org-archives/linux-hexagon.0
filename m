From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Thu,  6 Jul 2023 23:45:03 +0800
Message-ID: <20230706154520.11257-3-bhe@redhat.com>
References: <20230706154520.11257-1-bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688658357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrpD6SwU7RX+eLIqGEOviqMeuTumyLFYQ/9zvaQiSxE=;
        b=fMHvNxt8KBlD+VWv5GIZOxlAg/UMgVYvbVqghrVPNpQN0vfKT9lSOMjrk0KjBPpuADcm0d
        Rghn9goHfsomih2CuhBqJCnkukixvscVbTC2BAEdD4xJ3Pq0u3M0DXpg/8cSAqnktAycp1
        FR2o3+AB2NrSNjBL/a17reBtFn4A6kc=
In-Reply-To: <20230706154520.11257-1-bhe@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, arnd@arndb.de, hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org, agordeev@linux.ibm.com, wangkefeng.wang@huawei.com, schnelle@linux.ibm.com, shorne@gmail.com, David.Laight@ACULAB.COM, deller@gmx.de, nathan@kernel.org, glaubitz@physik.fu-berlin.de, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
iounmap() are visible and available to arch. This change will
simplify implementation by removing duplicated code with generic
ioremap_prot() and iounmap(), and has the equivalent functioality.

For hexagon, the current ioremap() and iounmap() are the same as
generic version. After taking GENERIC_IOREMAP way, the old ioremap()
and iounmap() can be completely removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
---
v7->v8:
Fix the error reported by lkp test robot on patch. Thanks to Nathan
for providing the code fix after reproducing.

 arch/hexagon/Kconfig                |  1 +
 arch/hexagon/include/asm/io.h       | 11 +++++---
 arch/hexagon/kernel/hexagon_ksyms.c |  2 --
 arch/hexagon/mm/Makefile            |  2 +-
 arch/hexagon/mm/ioremap.c           | 44 -----------------------------
 5 files changed, 9 insertions(+), 51 deletions(-)
 delete mode 100644 arch/hexagon/mm/ioremap.c

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 6726f4941015..a880ee067d2e 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -25,6 +25,7 @@ config HEXAGON
 	select NEED_SG_DMA_LENGTH
 	select NO_IOPORT_MAP
 	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 46a099de85b7..e2b308e32a37 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -27,8 +27,6 @@
 extern int remap_area_pages(unsigned long start, unsigned long phys_addr,
 				unsigned long end, unsigned long flags);
 
-extern void iounmap(const volatile void __iomem *addr);
-
 /* Defined in lib/io.c, needed for smc91x driver. */
 extern void __raw_readsw(const void __iomem *addr, void *data, int wordlen);
 extern void __raw_writesw(void __iomem *addr, const void *data, int wordlen);
@@ -170,8 +168,13 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
-#define ioremap_uc(X, Y) ioremap((X), (Y))
+/*
+ * I/O memory mapping functions.
+ */
+#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+		       (__HEXAGON_C_DEV << 6))
+
+#define ioremap_uc(addr, size) ioremap((addr), (size))
 
 
 #define __raw_writel writel
diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
index ec56ce2d92a2..36a80e31d187 100644
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -14,12 +14,10 @@
 EXPORT_SYMBOL(__clear_user_hexagon);
 EXPORT_SYMBOL(raw_copy_from_user);
 EXPORT_SYMBOL(raw_copy_to_user);
-EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(__vmgetie);
 EXPORT_SYMBOL(__vmsetie);
 EXPORT_SYMBOL(__vmyield);
 EXPORT_SYMBOL(empty_zero_page);
-EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 
diff --git a/arch/hexagon/mm/Makefile b/arch/hexagon/mm/Makefile
index 49911a906fd0..ba4b04d962d6 100644
--- a/arch/hexagon/mm/Makefile
+++ b/arch/hexagon/mm/Makefile
@@ -3,5 +3,5 @@
 # Makefile for Hexagon memory management subsystem
 #
 
-obj-y := init.o ioremap.o uaccess.o vm_fault.o cache.o
+obj-y := init.o uaccess.o vm_fault.o cache.o
 obj-y += copy_to_user.o copy_from_user.o vm_tlb.o
diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
deleted file mode 100644
index 255c5b1ee1a7..000000000000
--- a/arch/hexagon/mm/ioremap.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * I/O remap functions for Hexagon
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- */
-
-#include <linux/io.h>
-#include <linux/vmalloc.h>
-#include <linux/mm.h>
-
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
-{
-	unsigned long last_addr, addr;
-	unsigned long offset = phys_addr & ~PAGE_MASK;
-	struct vm_struct *area;
-
-	pgprot_t prot = __pgprot(_PAGE_PRESENT|_PAGE_READ|_PAGE_WRITE
-					|(__HEXAGON_C_DEV << 6));
-
-	last_addr = phys_addr + size - 1;
-
-	/*  Wrapping not allowed  */
-	if (!size || (last_addr < phys_addr))
-		return NULL;
-
-	/*  Rounds up to next page size, including whole-page offset */
-	size = PAGE_ALIGN(offset + size);
-
-	area = get_vm_area(size, VM_IOREMAP);
-	addr = (unsigned long)area->addr;
-
-	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
-		vunmap((void *)addr);
-		return NULL;
-	}
-
-	return (void __iomem *) (offset + addr);
-}
-
-void iounmap(const volatile void __iomem *addr)
-{
-	vunmap((void *) ((unsigned long) addr & PAGE_MASK));
-}
-- 
2.34.1

