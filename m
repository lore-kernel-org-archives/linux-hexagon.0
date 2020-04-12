From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 07/21] arm: simplify detection of memory zone boundaries
Date: Sun, 12 Apr 2020 22:48:45 +0300
Message-ID: <20200412194859.12663-8-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v+v6AS54N1xehnpvuhcev9DDTpOlS9bOmeU9pBjehwk=; b=orSZ3BGnOp0nwz
	hiD2aOpSUSQ/6DETe3aZ1vO7DCgsg3gqyL0s1ugjXKY9RarpSGmtORbC6QyDyabMu+gYVlhTqMhqV
	f6hUjH0NiMtCQ2sJwNzfsSjd1pHp0Gkvpyrk2i68L/B/mfK592xbPUx59ew/ciVt37QrbD229P1vT
	xCid0Gm4YvR4/AK62AIrVDC655uJFdlY+NdsM9DZzv34drN5SkfW2xVEuOewcGmsiNqUqLx8vKn8i
	6GH23+QkOeJxfi7Rd7SFPRClzXSgT0K+3+HxfIuKTIq4NGO24b5FsUsc5IoZiF4tMYrSg0gJx9/mJ
	I4qXz4Q/2kaxNy/cXr8w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586721064;
 bh=cH4vss3qNJhXJIvzb7q7Wn734fkKg4X+RTrGl6ZaiYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0BIupA64kGu1HlizFpI+N3TJZ6L2DTl8AS8X7g5LMT+FinwBM0R2+MIXVl+iucOw0
 DmEuHX6++bSA1sSCKakWnnnIhYbIXa+zgWCkmCjU5hRMIxfstrJlNHA1+lPxJ/ZYRj
 826ySKimGemZ4wU66yRDOC9pA0DPDqgsPxKeZ/Mo=
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@in>

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() function only requires the definition of maximal PFN
for each of the supported zone rater than calculation of actual zone sizes
and the sizes of the holes between the zones.

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
available to all architectures.

Using this function instead of free_area_init_node() simplifies the zone
detection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c | 66 +++++-----------------------------------------
 1 file changed, 7 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 054be44d1cdb..4e43455fab84 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -92,18 +92,6 @@ EXPORT_SYMBOL(arm_dma_zone_size);
  */
 phys_addr_t arm_dma_limit;
 unsigned long arm_dma_pfn_limit;
-
-static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
-	unsigned long dma_size)
-{
-	if (size[0] <= dma_size)
-		return;
-
-	size[ZONE_NORMAL] = size[0] - dma_size;
-	size[ZONE_DMA] = dma_size;
-	hole[ZONE_NORMAL] = hole[0];
-	hole[ZONE_DMA] = 0;
-}
 #endif
 
 void __init setup_dma_zone(const struct machine_desc *mdesc)
@@ -121,56 +109,16 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 	unsigned long max_high)
 {
-	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	struct memblock_region *reg;
-
-	/*
-	 * initialise the zones.
-	 */
-	memset(zone_size, 0, sizeof(zone_size));
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
-	/*
-	 * The memory size has already been determined.  If we need
-	 * to do anything fancy with the allocation of this memory
-	 * to the zones, now is the time to do it.
-	 */
-	zone_size[0] = max_low - min;
-#ifdef CONFIG_HIGHMEM
-	zone_size[ZONE_HIGHMEM] = max_high - max_low;
+#ifdef CONFIG_ZONE_DMA
+	max_zone_pfn[ZONE_DMA] = min(arm_dma_pfn_limit, max_low);
 #endif
-
-	/*
-	 * Calculate the size of the holes.
-	 *  holes = node_size - sum(bank_sizes)
-	 */
-	memcpy(zhole_size, zone_size, sizeof(zhole_size));
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-		if (start < max_low) {
-			unsigned long low_end = min(end, max_low);
-			zhole_size[0] -= low_end - start;
-		}
+	max_zone_pfn[ZONE_NORMAL] = max_low;
 #ifdef CONFIG_HIGHMEM
-		if (end > max_low) {
-			unsigned long high_start = max(start, max_low);
-			zhole_size[ZONE_HIGHMEM] -= end - high_start;
-		}
+	max_zone_pfn[ZONE_HIGHMEM] = max_high;
 #endif
-	}
-
-#ifdef CONFIG_ZONE_DMA
-	/*
-	 * Adjust the sizes according to any special requirements for
-	 * this machine type.
-	 */
-	if (arm_dma_zone_size)
-		arm_adjust_dma_zone(zone_size, zhole_size,
-			arm_dma_zone_size >> PAGE_SHIFT);
-#endif
-
-	free_area_init_node(0, zone_size, min, zhole_size);
+	free_area_init(max_zone_pfn);
 }
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
@@ -306,7 +254,7 @@ void __init bootmem_init(void)
 	sparse_init();
 
 	/*
-	 * Now free the memory - free_area_init_node needs
+	 * Now free the memory - free_area_init needs
 	 * the sparse mem_map arrays initialized by sparse_init()
 	 * for memmap_init_zone(), otherwise all PFNs are invalid.
 	 */
-- 
2.25.1


