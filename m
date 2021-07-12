From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/7] ARM/nommu: use the generic dma-direct code for
 non-coherent devices
Date: Mon, 12 Jul 2021 08:16:59 +0200
Message-ID: <20210712061704.4162464-3-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=UhkCU2sEw53RmWN21Z8+k4mhj1p/WEbokRIpJqAAyt8=; b=NOEQDVGSkWa7JbJUMAr+wu4/4n
 e3jaU2L/1xwFoQ7qooaCwO771e6hqu51gNr3cwwK8NtR7YcIHN0Da5YaArCnU12VHE6QTLdKnE9gm
 gP/6gEWJhDMIaLErEuVp3taOA+rjgxl6m/5v5IampmluoqCvhyQZUVjBJLjDKVzJkeBc2txJMSjfN
 1Z1VWWpVCswe816CwyvmmoQHQbyZIYzPWMZq1hcHlur1kQUjEpFVZ5hwXYi3PdXjzR4rvawCpmJ6+
 9dIioC+R/EW0ETB/kvSKwbtw5upr+1ITF/3B1c60YGMsLwFhk2OuFt1AW0vT+6y24zjB0QxPbhWH5
 kxvIUvBQ==;
In-Reply-To: <20210712061704.4162464-1-hch-jcswGhMUV9g@public.gmane.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Brian Cain <bcain-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Select the right options to just use the generic dma-direct code
instead of reimplementing it.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Tested-by: Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/Kconfig                |   5 +-
 arch/arm/mm/dma-mapping-nommu.c | 173 ++------------------------------
 2 files changed, 9 insertions(+), 169 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3ea1c417339f..fcb192bfd35a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,8 +18,8 @@ config ARM
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if SWIOTLB
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if SWIOTLB || !MMU
+	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB || !MMU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
@@ -44,6 +44,7 @@ config ARM
 	select CPU_PM if SUSPEND || CPU_IDLE
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select DMA_DECLARE_COHERENT
+	select DMA_GLOBAL_POOL if !MMU
 	select DMA_OPS
 	select DMA_REMAP if MMU
 	select EDAC_SUPPORT
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 6bfd2b884505..cfd9c933d2f0 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -5,12 +5,7 @@
  *  Copyright (C) 2000-2004 Russell King
  */
 
-#include <linux/export.h>
-#include <linux/mm.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
-#include <linux/scatterlist.h>
-
 #include <asm/cachetype.h>
 #include <asm/cacheflush.h>
 #include <asm/outercache.h>
@@ -18,65 +13,8 @@
 
 #include "dma.h"
 
-/*
- *  The generic direct mapping code is used if
- *   - MMU/MPU is off
- *   - cpu is v7m w/o cache support
- *   - device is coherent
- *  otherwise arm_nommu_dma_ops is used.
- *
- *  arm_nommu_dma_ops rely on consistent DMA memory (please, refer to
- *  [1] on how to declare such memory).
- *
- *  [1] Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
- */
-
-static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp,
-				 unsigned long attrs)
-
-{
-	void *ret = dma_alloc_from_global_coherent(dev, size, dma_handle);
-
-	/*
-	 * dma_alloc_from_global_coherent() may fail because:
-	 *
-	 * - no consistent DMA region has been defined, so we can't
-	 *   continue.
-	 * - there is no space left in consistent DMA region, so we
-	 *   only can fallback to generic allocator if we are
-	 *   advertised that consistency is not required.
-	 */
-
-	WARN_ON_ONCE(ret == NULL);
-	return ret;
-}
-
-static void arm_nommu_dma_free(struct device *dev, size_t size,
-			       void *cpu_addr, dma_addr_t dma_addr,
-			       unsigned long attrs)
-{
-	int ret = dma_release_from_global_coherent(get_order(size), cpu_addr);
-
-	WARN_ON_ONCE(ret == 0);
-}
-
-static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      unsigned long attrs)
-{
-	int ret;
-
-	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
-		return ret;
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-	return -ENXIO;
-}
-
-
-static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
-				  enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	dmac_map_area(__va(paddr), size, dir);
 
@@ -86,8 +24,8 @@ static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
 		outer_clean_range(paddr, paddr + size);
 }
 
-static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
-				  enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	if (dir != DMA_TO_DEVICE) {
 		outer_inv_range(paddr, paddr + size);
@@ -95,102 +33,6 @@ static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
 	}
 }
 
-static dma_addr_t arm_nommu_dma_map_page(struct device *dev, struct page *page,
-					 unsigned long offset, size_t size,
-					 enum dma_data_direction dir,
-					 unsigned long attrs)
-{
-	dma_addr_t handle = page_to_phys(page) + offset;
-
-	__dma_page_cpu_to_dev(handle, size, dir);
-
-	return handle;
-}
-
-static void arm_nommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
-				     size_t size, enum dma_data_direction dir,
-				     unsigned long attrs)
-{
-	__dma_page_dev_to_cpu(handle, size, dir);
-}
-
-
-static int arm_nommu_dma_map_sg(struct device *dev, struct scatterlist *sgl,
-				int nents, enum dma_data_direction dir,
-				unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sgl, sg, nents, i) {
-		sg_dma_address(sg) = sg_phys(sg);
-		sg_dma_len(sg) = sg->length;
-		__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
-	}
-
-	return nents;
-}
-
-static void arm_nommu_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
-				   int nents, enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
-}
-
-static void arm_nommu_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	__dma_page_cpu_to_dev(handle, size, dir);
-}
-
-static void arm_nommu_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	__dma_page_cpu_to_dev(handle, size, dir);
-}
-
-static void arm_nommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
-					     int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
-}
-
-static void arm_nommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
-					  int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
-}
-
-const struct dma_map_ops arm_nommu_dma_ops = {
-	.alloc			= arm_nommu_dma_alloc,
-	.free			= arm_nommu_dma_free,
-	.alloc_pages		= dma_direct_alloc_pages,
-	.free_pages		= dma_direct_free_pages,
-	.mmap			= arm_nommu_dma_mmap,
-	.map_page		= arm_nommu_dma_map_page,
-	.unmap_page		= arm_nommu_dma_unmap_page,
-	.map_sg			= arm_nommu_dma_map_sg,
-	.unmap_sg		= arm_nommu_dma_unmap_sg,
-	.sync_single_for_device	= arm_nommu_dma_sync_single_for_device,
-	.sync_single_for_cpu	= arm_nommu_dma_sync_single_for_cpu,
-	.sync_sg_for_device	= arm_nommu_dma_sync_sg_for_device,
-	.sync_sg_for_cpu	= arm_nommu_dma_sync_sg_for_cpu,
-};
-EXPORT_SYMBOL(arm_nommu_dma_ops);
-
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
@@ -201,14 +43,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		 * enough to check if MPU is in use or not since in absense of
 		 * MPU system memory map is used.
 		 */
-		dev->archdata.dma_coherent = (cacheid) ? coherent : true;
+		dev->dma_coherent = cacheid ? coherent : true;
 	} else {
 		/*
 		 * Assume coherent DMA in case MMU/MPU has not been set up.
 		 */
-		dev->archdata.dma_coherent = (get_cr() & CR_M) ? coherent : true;
+		dev->dma_coherent = (get_cr() & CR_M) ? coherent : true;
 	}
-
-	if (!dev->archdata.dma_coherent)
-		set_dma_ops(dev, &arm_nommu_dma_ops);
 }
-- 
2.30.2
