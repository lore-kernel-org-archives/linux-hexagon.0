From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 6/7] um: switch to NO_BOOTMEM
Date: Fri,  3 Aug 2018 22:58:49 +0300
Message-ID: <1533326330-31677-7-git-send-email-rppt@linux.vnet.ibm.com>
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

Replace bootmem initialization with memblock_add and memblock_reserve calls
and explicit initialization of {min,max}_low_pfn.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common   |  2 ++
 arch/um/kernel/physmem.c | 20 +++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 07f84c8..1487957 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -8,6 +8,8 @@ config UML
 	select HAVE_UID16
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_MEMBLOCK
+	select NO_BOOTMEM
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 0eaec0e..296a91a 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <asm/page.h>
@@ -80,23 +81,18 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
-	unsigned long pfn = PFN_UP(__pa(reserve_end));
-	unsigned long delta = (len - reserve) >> PAGE_SHIFT;
-	unsigned long offset, bootmap_size;
-	long map_size;
+	long map_size = len - reserve;
 	int err;
 
-	offset = reserve_end - start;
-	map_size = len - offset;
 	if(map_size <= 0) {
 		os_warn("Too few physical memory! Needed=%lu, given=%lu\n",
-			offset, len);
+			reserve, len);
 		exit(1);
 	}
 
 	physmem_fd = create_mem_file(len + highmem);
 
-	err = os_map_memory((void *) reserve_end, physmem_fd, offset,
+	err = os_map_memory((void *) reserve_end, physmem_fd, reserve,
 			    map_size, 1, 1, 1);
 	if (err < 0) {
 		os_warn("setup_physmem - mapping %ld bytes of memory at 0x%p "
@@ -113,9 +109,11 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
 	os_fsync_file(physmem_fd);
 
-	bootmap_size = init_bootmem(pfn, pfn + delta);
-	free_bootmem(__pa(reserve_end) + bootmap_size,
-		     len - bootmap_size - reserve);
+	memblock_add(__pa(start), len + highmem);
+	memblock_reserve(__pa(start), reserve);
+
+	min_low_pfn = PFN_UP(__pa(reserve_end));
+	max_low_pfn = min_low_pfn + (map_size >> PAGE_SHIFT);
 }
 
 int phys_mapping(unsigned long phys, unsigned long long *offset_out)
-- 
2.7.4

