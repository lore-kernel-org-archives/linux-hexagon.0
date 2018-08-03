From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 7/7] unicore32: switch to NO_BOOTMEM
Date: Fri,  3 Aug 2018 22:58:50 +0300
Message-ID: <1533326330-31677-8-git-send-email-rppt@linux.vnet.ibm.com>
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

The unicore32 already supports memblock and uses it for some early memory
reservations, e.g initrd and the page tables.

At some point unicore32 allocates the bootmem bitmap from the memblock and
then hands over the memory reservations from memblock to bootmem.

This patch removes the bootmem initialization and leaves memblock as the
only boot time memory manager for unicore32.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Guan Xuetao <gxt@pku.edu.cn>
---
 arch/unicore32/Kconfig   |  1 +
 arch/unicore32/mm/init.c | 54 +-----------------------------------------------
 2 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 03f991e..cff4b9d 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -5,6 +5,7 @@ config UNICORE32
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select HAVE_MEMBLOCK
+	select NO_BOOTMEM
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index f4950fb..44ccc15 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -84,58 +84,6 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	}
 }
 
-static void __init uc32_bootmem_init(unsigned long start_pfn,
-	unsigned long end_pfn)
-{
-	struct memblock_region *reg;
-	unsigned int boot_pages;
-	phys_addr_t bitmap;
-	pg_data_t *pgdat;
-
-	/*
-	 * Allocate the bootmem bitmap page.  This must be in a region
-	 * of memory which has already been mapped.
-	 */
-	boot_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-	bitmap = memblock_alloc_base(boot_pages << PAGE_SHIFT, L1_CACHE_BYTES,
-				__pfn_to_phys(end_pfn));
-
-	/*
-	 * Initialise the bootmem allocator, handing the
-	 * memory banks over to bootmem.
-	 */
-	node_set_online(0);
-	pgdat = NODE_DATA(0);
-	init_bootmem_node(pgdat, __phys_to_pfn(bitmap), start_pfn, end_pfn);
-
-	/* Free the lowmem regions from memblock into bootmem. */
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		free_bootmem(__pfn_to_phys(start), (end - start) << PAGE_SHIFT);
-	}
-
-	/* Reserve the lowmem memblock reserved regions in bootmem. */
-	for_each_memblock(reserved, reg) {
-		unsigned long start = memblock_region_reserved_base_pfn(reg);
-		unsigned long end = memblock_region_reserved_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		reserve_bootmem(__pfn_to_phys(start),
-			(end - start) << PAGE_SHIFT, BOOTMEM_DEFAULT);
-	}
-}
-
 static void __init uc32_bootmem_free(unsigned long min, unsigned long max_low,
 	unsigned long max_high)
 {
@@ -232,7 +180,7 @@ void __init bootmem_init(void)
 
 	find_limits(&min, &max_low, &max_high);
 
-	uc32_bootmem_init(min, max_low);
+	node_set_online(0);
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
-- 
2.7.4

