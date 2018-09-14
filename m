From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 28/30] memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
Date: Fri, 14 Sep 2018 15:10:43 +0300
Message-ID: <1536927045-23536-29-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UcYLlaoaEitkGBYKfBg559uqdzgM4mJhUeYE53dq0D0=; b=oq6SmljtdwPdxB3zk9tp2xXuzw
	/ozSQbOjPE5ebMCZ6wVH+Agm/HQYJidRanKzdKk5PjlNur+VP4bya2iseNO1VjZ0EFlqwsn3B1On7
	2I3itHAl+rIVPXoBU2oiLaiC7nPPEqfdC2v/+61ELP3brIongB4IkCGZzGfEegzY14h8fjRFFlljB
	SMakH2gAJ79nZETCBq2FwXgzafOAVmveq/ISUXn1ScnOqFbb8w5XL6S4g9au7/IkTYJx2hmQXinNd
	rO4jg9keLk95XLpwiGR6VOdn7ZmUyj0KAV3zHqNncAu5y2CMOT9h3QUGgmGYx1FCxBQv+tx9Licxg
	ESEIm+Wg==;
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Russell King <linux@armlinux.org.uk>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-alpha@vge

Drop BOOTMEM_ALLOC_ACCESSIBLE and BOOTMEM_ALLOC_ANYWHERE in favor of
identical MEMBLOCK definitions.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/ia64/mm/discontig.c       | 2 +-
 arch/powerpc/kernel/setup_64.c | 2 +-
 arch/sparc/kernel/smp_64.c     | 2 +-
 arch/x86/kernel/setup_percpu.c | 2 +-
 arch/x86/mm/kasan_init_64.c    | 4 ++--
 mm/hugetlb.c                   | 3 ++-
 mm/kasan/kasan_init.c          | 2 +-
 mm/memblock.c                  | 8 ++++----
 mm/page_ext.c                  | 2 +-
 mm/sparse-vmemmap.c            | 3 ++-
 mm/sparse.c                    | 5 +++--
 11 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 918dda9..70609f8 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -453,7 +453,7 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
 
 	ptr = memblock_alloc_try_nid(pernodesize, PERCPU_PAGE_SIZE,
 				     __pa(MAX_DMA_ADDRESS),
-				     BOOTMEM_ALLOC_ACCESSIBLE,
+				     MEMBLOCK_ALLOC_ACCESSIBLE,
 				     bestnode);
 
 	return ptr;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e564b27..b3e70cc 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -758,7 +758,7 @@ void __init emergency_stack_init(void)
 static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
 {
 	return memblock_alloc_try_nid(size, align, __pa(MAX_DMA_ADDRESS),
-				      BOOTMEM_ALLOC_ACCESSIBLE,
+				      MEMBLOCK_ALLOC_ACCESSIBLE,
 				      early_cpu_to_node(cpu));
 
 }
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index a087a6a..6cc80d0 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1595,7 +1595,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 			 cpu, size, __pa(ptr));
 	} else {
 		ptr = memblock_alloc_try_nid(size, align, goal,
-					     BOOTMEM_ALLOC_ACCESSIBLE, node);
+					     MEMBLOCK_ALLOC_ACCESSIBLE, node);
 		pr_debug("per cpu data for cpu%d %lu bytes on node%d at "
 			 "%016lx\n", cpu, size, node, __pa(ptr));
 	}
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index a006f1b..483412f 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -114,7 +114,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 			 cpu, size, __pa(ptr));
 	} else {
 		ptr = memblock_alloc_try_nid_nopanic(size, align, goal,
-						     BOOTMEM_ALLOC_ACCESSIBLE,
+						     MEMBLOCK_ALLOC_ACCESSIBLE,
 						     node);
 
 		pr_debug("per cpu data for cpu%d %lu bytes on node%d at %016lx\n",
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 77b857c..8f87499 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -29,10 +29,10 @@ static __init void *early_alloc(size_t size, int nid, bool panic)
 {
 	if (panic)
 		return memblock_alloc_try_nid(size, size,
-			__pa(MAX_DMA_ADDRESS), BOOTMEM_ALLOC_ACCESSIBLE, nid);
+			__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	else
 		return memblock_alloc_try_nid_nopanic(size, size,
-			__pa(MAX_DMA_ADDRESS), BOOTMEM_ALLOC_ACCESSIBLE, nid);
+			__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 }
 
 static void __init kasan_populate_pmd(pmd_t *pmd, unsigned long addr,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3b63370..67629dc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -16,6 +16,7 @@
 #include <linux/cpuset.h>
 #include <linux/mutex.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/mmdebug.h>
@@ -2102,7 +2103,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
 
 		addr = memblock_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
-				0, BOOTMEM_ALLOC_ACCESSIBLE, node);
+				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
 		if (addr) {
 			/*
 			 * Use the beginning of the huge page to store the
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index 24d734b..785a970 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -84,7 +84,7 @@ static inline bool kasan_zero_page_entry(pte_t pte)
 static __init void *early_alloc(size_t size, int node)
 {
 	return memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
-					BOOTMEM_ALLOC_ACCESSIBLE, node);
+					MEMBLOCK_ALLOC_ACCESSIBLE, node);
 }
 
 static void __ref zero_pte_populate(pmd_t *pmd, unsigned long addr,
diff --git a/mm/memblock.c b/mm/memblock.c
index 4591f38..86a4b80 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1393,7 +1393,7 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
  * hold the requested memory.
  *
  * The allocation is performed from memory region limited by
- * memblock.current_limit if @max_addr == %BOOTMEM_ALLOC_ACCESSIBLE.
+ * memblock.current_limit if @max_addr == %MEMBLOCK_ALLOC_ACCESSIBLE.
  *
  * The memory block is aligned on %SMP_CACHE_BYTES if @align == 0.
  *
@@ -1480,7 +1480,7 @@ static void * __init memblock_alloc_internal(
  * @min_addr: the lower bound of the memory region from where the allocation
  *	  is preferred (phys address)
  * @max_addr: the upper bound of the memory region from where the allocation
- *	      is preferred (phys address), or %BOOTMEM_ALLOC_ACCESSIBLE to
+ *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
@@ -1518,7 +1518,7 @@ void * __init memblock_alloc_try_nid_raw(
  * @min_addr: the lower bound of the memory region from where the allocation
  *	  is preferred (phys address)
  * @max_addr: the upper bound of the memory region from where the allocation
- *	      is preferred (phys address), or %BOOTMEM_ALLOC_ACCESSIBLE to
+ *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
@@ -1553,7 +1553,7 @@ void * __init memblock_alloc_try_nid_nopanic(
  * @min_addr: the lower bound of the memory region from where the allocation
  *	  is preferred (phys address)
  * @max_addr: the upper bound of the memory region from where the allocation
- *	      is preferred (phys address), or %BOOTMEM_ALLOC_ACCESSIBLE to
+ *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
diff --git a/mm/page_ext.c b/mm/page_ext.c
index e77c0f0..5323c2a 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -163,7 +163,7 @@ static int __init alloc_node_page_ext(int nid)
 
 	base = memblock_alloc_try_nid_nopanic(
 			table_size, PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
-			BOOTMEM_ALLOC_ACCESSIBLE, nid);
+			MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	if (!base)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 91c2c3d..7408cab 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/memremap.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
@@ -43,7 +44,7 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
 				unsigned long goal)
 {
 	return memblock_alloc_try_nid_raw(size, align, goal,
-					       BOOTMEM_ALLOC_ACCESSIBLE, node);
+					       MEMBLOCK_ALLOC_ACCESSIBLE, node);
 }
 
 void * __meminit vmemmap_alloc_block(unsigned long size, int node)
diff --git a/mm/sparse.c b/mm/sparse.c
index 509828f..0dcc306 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/mmzone.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
@@ -393,7 +394,7 @@ struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
 
 	map = memblock_alloc_try_nid(size,
 					  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
-					  BOOTMEM_ALLOC_ACCESSIBLE, nid);
+					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	return map;
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
@@ -407,7 +408,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	sparsemap_buf =
 		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
-						BOOTMEM_ALLOC_ACCESSIBLE, nid);
+						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	sparsemap_buf_end = sparsemap_buf + size;
 }
 
-- 
2.7.4
