From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/7] hexagon: switch to NO_BOOTMEM
Date: Fri,  3 Aug 2018 22:58:44 +0300
Message-ID: <1533326330-31677-2-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@pku.edu.cn>, Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-um@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>

This patch adds registration of the system memory with memblock, eliminates
bootmem initialization and converts early memory reservations from bootmem
to memblock.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/Kconfig   |  3 +++
 arch/hexagon/mm/init.c | 20 ++++++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 37adb20..66fb2d5 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,9 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select HAVE_MEMBLOCK
+	select ARCH_DISCARD_MEMBLOCK
+	select NO_BOOTMEM
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 1495d45..d789b9c 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <asm/atomic.h>
 #include <linux/highmem.h>
 #include <asm/tlb.h>
@@ -176,7 +177,6 @@ size_t hexagon_coherent_pool_size = (size_t) (DMA_RESERVE << 22);
 
 void __init setup_arch_memory(void)
 {
-	int bootmap_size;
 	/*  XXX Todo: this probably should be cleaned up  */
 	u32 *segtable = (u32 *) &swapper_pg_dir[0];
 	u32 *segtable_end;
@@ -195,18 +195,22 @@ void __init setup_arch_memory(void)
 	bootmem_lastpg = PFN_DOWN((bootmem_lastpg << PAGE_SHIFT) &
 		~((BIG_KERNEL_PAGE_SIZE) - 1));
 
+	memblock_add(PHYS_OFFSET,
+		     (bootmem_lastpg - ARCH_PFN_OFFSET) << PAGE_SHIFT);
+
+	/* Reserve kernel text/data/bss */
+	memblock_reserve(PHYS_OFFSET,
+			 (bootmem_startpg - ARCH_PFN_OFFSET) << PAGE_SHIFT);
 	/*
 	 * Reserve the top DMA_RESERVE bytes of RAM for DMA (uncached)
 	 * memory allocation
 	 */
-
 	max_low_pfn = bootmem_lastpg - PFN_DOWN(DMA_RESERVED_BYTES);
 	min_low_pfn = ARCH_PFN_OFFSET;
-	bootmap_size =  init_bootmem_node(NODE_DATA(0), bootmem_startpg, min_low_pfn, max_low_pfn);
+	memblock_reserve(PFN_PHYS(max_low_pfn), DMA_RESERVED_BYTES);
 
 	printk(KERN_INFO "bootmem_startpg:  0x%08lx\n", bootmem_startpg);
 	printk(KERN_INFO "bootmem_lastpg:  0x%08lx\n", bootmem_lastpg);
-	printk(KERN_INFO "bootmap_size:  %d\n", bootmap_size);
 	printk(KERN_INFO "min_low_pfn:  0x%08lx\n", min_low_pfn);
 	printk(KERN_INFO "max_low_pfn:  0x%08lx\n", max_low_pfn);
 
@@ -257,14 +261,6 @@ void __init setup_arch_memory(void)
 #endif
 
 	/*
-	 * Free all the memory that wasn't taken up by the bootmap, the DMA
-	 * reserve, or kernel itself.
-	 */
-	free_bootmem(PFN_PHYS(bootmem_startpg) + bootmap_size,
-		     PFN_PHYS(bootmem_lastpg - bootmem_startpg) - bootmap_size -
-		     DMA_RESERVED_BYTES);
-
-	/*
 	 *  The bootmem allocator seemingly just lives to feed memory
 	 *  to the paging system
 	 */
-- 
2.7.4

