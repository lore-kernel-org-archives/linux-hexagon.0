From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 4/7] nios2: switch to NO_BOOTMEM
Date: Fri,  3 Aug 2018 22:58:47 +0300
Message-ID: <1533326330-31677-5-git-send-email-rppt@linux.vnet.ibm.com>
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

Remove bootmem bitmap initialization and replace reserve_bootmem() with
memblock_reserve().

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 arch/nios2/Kconfig        |  2 ++
 arch/nios2/kernel/prom.c  |  7 -------
 arch/nios2/kernel/setup.c | 37 +++++--------------------------------
 3 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 5db8fa1..661f7f9 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -20,6 +20,8 @@ config NIOS2
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
 	select HAVE_MEMBLOCK
+	select ARCH_DISCARD_MEMBLOCK
+	select NO_BOOTMEM
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index ba96a49..a6d4f75 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -32,13 +32,6 @@
 
 #include <asm/sections.h>
 
-int __init early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
-					     bool nomap)
-{
-	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
-	return 0;
-}
-
 void __init early_init_devtree(void *params)
 {
 	__be32 *dtb = (u32 *)__dtb_start;
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 0946840..2d0011d 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -144,10 +144,11 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 
 void __init setup_arch(char **cmdline_p)
 {
-	int bootmap_size;
+	int dram_start;
 
 	console_verbose();
 
+	dram_start = memblock_start_of_DRAM();
 	memory_size = memblock_phys_mem_size();
 	memory_start = PAGE_ALIGN((unsigned long)__pa(_end));
 	memory_end = (unsigned long) CONFIG_NIOS2_MEM_BASE + memory_size;
@@ -165,39 +166,11 @@ void __init setup_arch(char **cmdline_p)
 	max_low_pfn = PFN_DOWN(memory_end);
 	max_mapnr = max_low_pfn;
 
-	/*
-	 * give all the memory to the bootmap allocator,  tell it to put the
-	 * boot mem_map at the start of memory
-	 */
-	pr_debug("init_bootmem_node(?,%#lx, %#x, %#lx)\n",
-		min_low_pfn, PFN_DOWN(PHYS_OFFSET), max_low_pfn);
-	bootmap_size = init_bootmem_node(NODE_DATA(0),
-					min_low_pfn, PFN_DOWN(PHYS_OFFSET),
-					max_low_pfn);
-
-	/*
-	 * free the usable memory,  we have to make sure we do not free
-	 * the bootmem bitmap so we then reserve it after freeing it :-)
-	 */
-	pr_debug("free_bootmem(%#lx, %#lx)\n",
-		memory_start, memory_end - memory_start);
-	free_bootmem(memory_start, memory_end - memory_start);
-
-	/*
-	 * Reserve the bootmem bitmap itself as well. We do this in two
-	 * steps (first step was init_bootmem()) because this catches
-	 * the (very unlikely) case of us accidentally initializing the
-	 * bootmem allocator with an invalid RAM area.
-	 *
-	 * Arguments are start, size
-	 */
-	pr_debug("reserve_bootmem(%#lx, %#x)\n", memory_start, bootmap_size);
-	reserve_bootmem(memory_start, bootmap_size, BOOTMEM_DEFAULT);
-
+	memblock_reserve(dram_start, memory_start - dram_start);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
-		reserve_bootmem(virt_to_phys((void *)initrd_start),
-				initrd_end - initrd_start, BOOTMEM_DEFAULT);
+		memblock_reserve(virt_to_phys((void *)initrd_start),
+				initrd_end - initrd_start);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-- 
2.7.4

