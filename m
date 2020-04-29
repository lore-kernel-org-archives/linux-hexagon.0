From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 07/20] arm: simplify detection of memory zone boundaries
Date: Wed, 29 Apr 2020 15:11:13 +0300
Message-ID: <20200429121126.17989-8-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mGks68zvqpEX+D9/PYb8gTP/9L5iM+4dy3dLLXM7jVM=; b=hVTRPvtPW6AUP4
	2QHZcsaXBZ2Dl5JraP4F1xPP+5hMvKiawvPBhCyWr25BSmsCE2mmZLxTWypcJsqeD5W9hyhPvh8at
	SEf2Iu3tuKgxIjVxQRHAxHx/3RK00MH8udEATy9q7+JnNPehjviscv8aUmbQFEa2CoDKIwsN8LLHE
	J2SKj0E6lA9fE2OTBRuhYuItsNdNI+mgH8WTikKpTIVallD62Hlzfx6R3mIn8kp6GUM++SDW2acUG
	gGlZgbDZ1Tp+3gY06ZovECLU2bpTF+uDHnjKR2OiAijyOQ0lXJ0EDewpWqiYm90LhFFoR8EHoGewo
	qFQkSA1qgVRJD0MqE5zg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588162423;
 bh=+eh0ZniRrmTj98z2ldVRyODRepbhef9bdySLHYLC36Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ALp5PpxP+Le/5/FwwKgmfwsK9ZC7iZx2hdotHL5WhqX6Tvm6+pzUNvWtSL8Jcbt0I
 dwBb1DtkLEYsYALzsT1zNk6SYrG1+g+pcpeOFGZYDaBQQ3YhKG35DKpS8xFIVCGbaa
 2GgYvL1DtePa04AomsfseLElRE26lX4Qg/XV4QKg=
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
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
2.26.1
