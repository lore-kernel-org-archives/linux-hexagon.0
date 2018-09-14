From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 27/30] mm: remove nobootmem
Date: Fri, 14 Sep 2018 15:10:42 +0300
Message-ID: <1536927045-23536-28-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4AafY6LGEEcjcfUW86ia+vXmEHgbuFAm3gdsO2Skbyk=; b=Wzw3gLxcZYHcPHu0UUpX+YmH4X
	qNIj4ZXHI0yALcApI+HVpDqRsckvUCgD1b94LKJTW8N3msdaWncZliABbKOPk7fw2F52xPF/uozGb
	yFxQ0QTqa/sySZS9fXrFs5iBXiONiAJZFQFmzgQJKVvhSTv7DsWqU+RE3ZrHN1T39lki5+fi6HB8U
	OKSEpr1VCaJ//ukNutv4+IAK/etAkFyieEbbC7CwV2dQP8D19J1uEsycwQeUjx3INK1V6a14BfczL
	5n4qrJ2MjE6CQCryW5FpqfCfd80Y4xTy4f2ZCd757BVQ9CAkQ8Fj+VUfkRjfit6LcgMIdgnLdzD1H
	+/oLerNA==;
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Russell King <linux@armlinux.org.uk>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-alpha@vge

Move a few remaining functions from nobootmem.c to memblock.c and remove
nobootmem

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/Makefile    |   1 -
 mm/memblock.c  | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/nobootmem.c | 128 ---------------------------------------------------------
 3 files changed, 104 insertions(+), 129 deletions(-)
 delete mode 100644 mm/nobootmem.c

diff --git a/mm/Makefile b/mm/Makefile
index ca3c844..d210cc9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -42,7 +42,6 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   debug.o $(mmu-y)
 
 obj-y += init-mm.o
-obj-y += nobootmem.o
 obj-y += memblock.o
 
 ifdef CONFIG_MMU
diff --git a/mm/memblock.c b/mm/memblock.c
index a2cd61d..4591f38 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -82,6 +82,16 @@
  * initialization compltes.
  */
 
+#ifndef CONFIG_NEED_MULTIPLE_NODES
+struct pglist_data __refdata contig_page_data;
+EXPORT_SYMBOL(contig_page_data);
+#endif
+
+unsigned long max_low_pfn;
+unsigned long min_low_pfn;
+unsigned long max_pfn;
+unsigned long long max_possible_pfn;
+
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -1929,6 +1939,100 @@ static int __init early_memblock(char *p)
 }
 early_param("memblock", early_memblock);
 
+static void __init __free_pages_memory(unsigned long start, unsigned long end)
+{
+	int order;
+
+	while (start < end) {
+		order = min(MAX_ORDER - 1UL, __ffs(start));
+
+		while (start + (1UL << order) > end)
+			order--;
+
+		memblock_free_pages(pfn_to_page(start), start, order);
+
+		start += (1UL << order);
+	}
+}
+
+static unsigned long __init __free_memory_core(phys_addr_t start,
+				 phys_addr_t end)
+{
+	unsigned long start_pfn = PFN_UP(start);
+	unsigned long end_pfn = min_t(unsigned long,
+				      PFN_DOWN(end), max_low_pfn);
+
+	if (start_pfn >= end_pfn)
+		return 0;
+
+	__free_pages_memory(start_pfn, end_pfn);
+
+	return end_pfn - start_pfn;
+}
+
+static unsigned long __init free_low_memory_core_early(void)
+{
+	unsigned long count = 0;
+	phys_addr_t start, end;
+	u64 i;
+
+	memblock_clear_hotplug(0, -1);
+
+	for_each_reserved_mem_region(i, &start, &end)
+		reserve_bootmem_region(start, end);
+
+	/*
+	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
+	 *  because in some case like Node0 doesn't have RAM installed
+	 *  low ram will be on Node1
+	 */
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
+				NULL)
+		count += __free_memory_core(start, end);
+
+	return count;
+}
+
+static int reset_managed_pages_done __initdata;
+
+void reset_node_managed_pages(pg_data_t *pgdat)
+{
+	struct zone *z;
+
+	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
+		z->managed_pages = 0;
+}
+
+void __init reset_all_zones_managed_pages(void)
+{
+	struct pglist_data *pgdat;
+
+	if (reset_managed_pages_done)
+		return;
+
+	for_each_online_pgdat(pgdat)
+		reset_node_managed_pages(pgdat);
+
+	reset_managed_pages_done = 1;
+}
+
+/**
+ * memblock_free_all - release free pages to the buddy allocator
+ *
+ * Return: the number of pages actually released.
+ */
+unsigned long __init memblock_free_all(void)
+{
+	unsigned long pages;
+
+	reset_all_zones_managed_pages();
+
+	pages = free_low_memory_core_early();
+	totalram_pages += pages;
+
+	return pages;
+}
+
 #if defined(CONFIG_DEBUG_FS) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
 
 static int memblock_debug_show(struct seq_file *m, void *private)
diff --git a/mm/nobootmem.c b/mm/nobootmem.c
deleted file mode 100644
index 9608bc5..0000000
--- a/mm/nobootmem.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  bootmem - A boot-time physical memory allocator and configurator
- *
- *  Copyright (C) 1999 Ingo Molnar
- *                1999 Kanoj Sarcar, SGI
- *                2008 Johannes Weiner
- *
- * Access to this subsystem has to be serialized externally (which is true
- * for the boot process anyway).
- */
-#include <linux/init.h>
-#include <linux/pfn.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-#include <linux/kmemleak.h>
-#include <linux/range.h>
-#include <linux/memblock.h>
-#include <linux/bootmem.h>
-
-#include <asm/bug.h>
-#include <asm/io.h>
-
-#include "internal.h"
-
-#ifndef CONFIG_NEED_MULTIPLE_NODES
-struct pglist_data __refdata contig_page_data;
-EXPORT_SYMBOL(contig_page_data);
-#endif
-
-unsigned long max_low_pfn;
-unsigned long min_low_pfn;
-unsigned long max_pfn;
-unsigned long long max_possible_pfn;
-
-static void __init __free_pages_memory(unsigned long start, unsigned long end)
-{
-	int order;
-
-	while (start < end) {
-		order = min(MAX_ORDER - 1UL, __ffs(start));
-
-		while (start + (1UL << order) > end)
-			order--;
-
-		memblock_free_pages(pfn_to_page(start), start, order);
-
-		start += (1UL << order);
-	}
-}
-
-static unsigned long __init __free_memory_core(phys_addr_t start,
-				 phys_addr_t end)
-{
-	unsigned long start_pfn = PFN_UP(start);
-	unsigned long end_pfn = min_t(unsigned long,
-				      PFN_DOWN(end), max_low_pfn);
-
-	if (start_pfn >= end_pfn)
-		return 0;
-
-	__free_pages_memory(start_pfn, end_pfn);
-
-	return end_pfn - start_pfn;
-}
-
-static unsigned long __init free_low_memory_core_early(void)
-{
-	unsigned long count = 0;
-	phys_addr_t start, end;
-	u64 i;
-
-	memblock_clear_hotplug(0, -1);
-
-	for_each_reserved_mem_region(i, &start, &end)
-		reserve_bootmem_region(start, end);
-
-	/*
-	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
-	 *  because in some case like Node0 doesn't have RAM installed
-	 *  low ram will be on Node1
-	 */
-	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
-				NULL)
-		count += __free_memory_core(start, end);
-
-	return count;
-}
-
-static int reset_managed_pages_done __initdata;
-
-void reset_node_managed_pages(pg_data_t *pgdat)
-{
-	struct zone *z;
-
-	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
-		z->managed_pages = 0;
-}
-
-void __init reset_all_zones_managed_pages(void)
-{
-	struct pglist_data *pgdat;
-
-	if (reset_managed_pages_done)
-		return;
-
-	for_each_online_pgdat(pgdat)
-		reset_node_managed_pages(pgdat);
-
-	reset_managed_pages_done = 1;
-}
-
-/**
- * memblock_free_all - release free pages to the buddy allocator
- *
- * Return: the number of pages actually released.
- */
-unsigned long __init memblock_free_all(void)
-{
-	unsigned long pages;
-
-	reset_all_zones_managed_pages();
-
-	pages = free_low_memory_core_early();
-	totalram_pages += pages;
-
-	return pages;
-}
-- 
2.7.4
