From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 7/7] hexagon: use the generic global coherent pool
Date: Mon, 12 Jul 2021 08:17:04 +0200
Message-ID: <20210712061704.4162464-8-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=O5uvaUdSp6FqM7+gNK9rRhzVPwV15QaVwrDrGAsNxTE=; b=MPGmLxDmFoDvPr/4xVjyljFCs6
 PDpD7Wh/Kz3P1srVFgaLrTGJFNPSNDy5RwoYZmGin1LSUarfbaXpHeoi0PlOQasi/bNJEi/FGBxdY
 J0s+qJzBJgLR2eWdUTlq5NcTRoUgqMDtMB2vGqg28SBuMQc/Pbf/df7DTTN5UE0QVVXB3ms1rsyQG
 alV6Bd37KPiIk9iWHzeF7V8vWN5OimVFPnperLg0u9w9XiIpy0DC6zrZi1qsfOYbhXjBWLD5MBOHn
 S4db/57uJgbhhrh1a28hv2/7X9dLOgYWBZvg4rFITMtbIAPpW//hur9uDqM+hvIhj96jqsJt3Qeio
 eK3oWRwg==;
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

Switch hexagon to use the generic code for dma_alloc_coherent from
a global pre-filled pool.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/hexagon/Kconfig      |  1 +
 arch/hexagon/kernel/dma.c | 57 ++++++++-------------------------------
 2 files changed, 12 insertions(+), 46 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index e5a852080730..aab1a40eb653 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -7,6 +7,7 @@ config HEXAGON
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
+	select DMA_GLOBAL_POOL
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
 	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 00b9a81075dd..882680e81a30 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -7,54 +7,8 @@
 
 #include <linux/dma-map-ops.h>
 #include <linux/memblock.h>
-#include <linux/genalloc.h>
-#include <linux/module.h>
 #include <asm/page.h>
 
-static struct gen_pool *coherent_pool;
-
-
-/* Allocates from a pool of uncached memory that was reserved at boot time */
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_addr,
-		gfp_t flag, unsigned long attrs)
-{
-	void *ret;
-
-	/*
-	 * Our max_low_pfn should have been backed off by 16MB in
-	 * mm/init.c to create DMA coherent space.  Use that as the VA
-	 * for the pool.
-	 */
-
-	if (coherent_pool == NULL) {
-		coherent_pool = gen_pool_create(PAGE_SHIFT, -1);
-
-		if (coherent_pool == NULL)
-			panic("Can't create %s() memory pool!", __func__);
-		else
-			gen_pool_add(coherent_pool,
-				(unsigned long)pfn_to_virt(max_low_pfn),
-				hexagon_coherent_pool_size, -1);
-	}
-
-	ret = (void *) gen_pool_alloc(coherent_pool, size);
-
-	if (ret) {
-		memset(ret, 0, size);
-		*dma_addr = (dma_addr_t) virt_to_phys(ret);
-	} else
-		*dma_addr = ~0;
-
-	return ret;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_addr, unsigned long attrs)
-{
-	gen_pool_free(coherent_pool, (unsigned long) vaddr, size);
-}
-
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
@@ -77,3 +31,14 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		BUG();
 	}
 }
+
+/*
+ * Our max_low_pfn should have been backed off by 16MB in mm/init.c to create
+ * DMA coherent space.  Use that for the pool.
+ */
+static int __init hexagon_dma_init(void)
+{
+	return dma_init_global_coherent(PFN_PHYS(max_low_pfn),
+					hexagon_coherent_pool_size);
+}
+core_initcall(hexagon_dma_init);
-- 
2.30.2
