From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/25] openrisc: remove the no-op unmap_page and unmap_sg DMA operations
Date: Tue, 22 May 2018 14:04:18 +0200
Message-ID: <20180522120430.28709-14-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=By986hH0zoJAF0egojGGYE/aPSnpLAiQwpxv7XTUbxM=; b=S6dUD3dFwuhtitJgWKKMTxp/F
        rma38hzjYvYUaILpB3IZmXtykGS9fYbcZliT0jEKRZwYg5zIyQ7AzKn3K82iGjExl5Yy5dQWUs6sc
        TcD2e3ak2aGBVXElgtHGVUfF6AqsH6Cgkrf6S85Z3FcfzG+HUtBVQnUarHt/iUgKMTA7Ytl5VIDLU
        CQhPKHKr6X7RUzyt7No26QSFKQFwtttr6/6Pj1mKj/ZvICMnCHI8rdMPRFVNST47vYqJ4RyMfnUxU
        SrnuIlS1LD9VkRfmYWA/aFyW9F3KcATmch/yGlEyi3Wb5Cwfpt9pvL5G6SK1Lmoazp931VYJk11Vg
    
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 47601274abf7..7cadff93d179 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -171,14 +171,6 @@ or1k_map_page(struct device *dev, struct page *page,
 	return addr;
 }
 
-static void
-or1k_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	/* Nothing special to do here... */
-}
-
 static int
 or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	    int nents, enum dma_data_direction dir,
@@ -195,19 +187,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_unmap_sg(struct device *dev, struct scatterlist *sg,
-	      int nents, enum dma_data_direction dir,
-	      unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		or1k_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, 0);
-	}
-}
-
 static void
 or1k_sync_single_for_device(struct device *dev,
 			    dma_addr_t dma_handle, size_t size,
@@ -226,9 +205,7 @@ const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
 	.map_page = or1k_map_page,
-	.unmap_page = or1k_unmap_page,
 	.map_sg = or1k_map_sg,
-	.unmap_sg = or1k_unmap_sg,
 	.sync_single_for_device = or1k_sync_single_for_device,
 };
 EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.17.0

