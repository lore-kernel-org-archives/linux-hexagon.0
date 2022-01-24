From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V1 26/31] hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date: Mon, 24 Jan 2022 18:27:03 +0530
Message-ID: <1643029028-12710-27-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, akpm@linux-foundation.org, Anshuman Khandual <anshuman.khandual@arm.com>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/hexagon/Kconfig               |  1 +
 arch/hexagon/include/asm/pgtable.h | 24 -----------------
 arch/hexagon/mm/init.c             | 42 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 15dd8f38b698..cdc5df32a1e3 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -6,6 +6,7 @@ config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_PREEMPT
 	select DMA_GLOBAL_POOL
 	# Other pending projects/to-do items.
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 18cd6ea9ab23..5eceddfe013d 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -127,31 +127,7 @@ extern unsigned long _dflt_cache_att;
 #define CACHEDEF	(CACHE_DEFAULT << 6)
 
 /* Private (copy-on-write) page protections. */
-#define __P000 __pgprot(_PAGE_PRESENT | _PAGE_USER | CACHEDEF)
-#define __P001 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | CACHEDEF)
-#define __P010 __P000	/* Write-only copy-on-write */
-#define __P011 __P001	/* Read/Write copy-on-write */
-#define __P100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __P101 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_EXECUTE | \
-			_PAGE_READ | CACHEDEF)
-#define __P110 __P100	/* Write/execute copy-on-write */
-#define __P111 __P101	/* Read/Write/Execute, copy-on-write */
-
 /* Shared page protections. */
-#define __S000 __P000
-#define __S001 __P001
-#define __S010 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S011 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __S101 __P101
-#define __S110 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
-#define __S111 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];  /* located in head.S */
 
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f01e91e10d95..9f411e3eba68 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -236,3 +236,45 @@ void __init setup_arch_memory(void)
 	 *  which is called by start_kernel() later on in the process
 	 */
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|CACHEDEF);
+	case VM_READ:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_READ|CACHEDEF);
+	case VM_WRITE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|CACHEDEF);
+	case VM_READ | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_READ|CACHEDEF);
+	case VM_EXEC:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_EXECUTE|CACHEDEF);
+	case VM_EXEC | VM_READ:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_EXECUTE|_PAGE_READ|CACHEDEF);
+	case VM_EXEC | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_EXECUTE|CACHEDEF);
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_EXECUTE|_PAGE_READ|CACHEDEF);
+	case VM_SHARED:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|CACHEDEF);
+	case VM_SHARED | VM_READ:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_READ|CACHEDEF);
+	case VM_SHARED | VM_WRITE:
+		return  __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_WRITE|CACHEDEF);
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_READ|_PAGE_WRITE|CACHEDEF);
+	case VM_SHARED | VM_EXEC:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_EXECUTE|CACHEDEF);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_EXECUTE|_PAGE_READ|CACHEDEF);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_EXECUTE|_PAGE_WRITE|CACHEDEF);
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT|_PAGE_USER|_PAGE_READ|_PAGE_EXECUTE|_PAGE_WRITE|
+				CACHEDEF);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

