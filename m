From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 37/44] mips/loongson64: implement ->dma_supported instead of ->set_dma_mask
Date: Thu,  8 Jun 2017 15:26:02 +0200
Message-ID: <20170608132609.32662-38-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b32hSH5IEVBjlCN7NVj+ixF9++g48vrma/m3FufguJ8=; b=c5w4yqLtY5yc9JIwGMYLoeMjs
        hrLdQ2Ha3TaRXQ3Go+H4Xjq5fnDTJRW2JgRnW3OGfPktXCo4eQ3hBAQ4qnZUGhJVD4KP+hWMZgV2X
        lL6hKs6BJxPQRPPn0NHYDnf9N7EwkFsbEe2o9pFOqPi70uM2dTeifV41rmU0NkYrObS9nWmwvL0C3
        QyLdoUbsPCwElFyVUYf2mnHxgyV+b9BXre5PWif14VOySLXcw9Q4TwKaab6p0Ih3YBnwbPJHy55OZ
        /AM7PWA9Ok0qsjvos3i9AaKwvPsgvqKd6L2Ufy4JhGzPlgqC2AJj5iKo34kV24Q9ow8QRODEe+uWo
    
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Same behavior, less code duplication.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/loongson64/common/dma-swiotlb.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 178ca17a5667..34486c138206 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -75,19 +75,11 @@ static void loongson_dma_sync_sg_for_device(struct device *dev,
 	mb();
 }
 
-static int loongson_dma_set_mask(struct device *dev, u64 mask)
+static int loongson_dma_supported(struct device *dev, u64 mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits)) {
-		*dev->dma_mask = DMA_BIT_MASK(loongson_sysconf.dma_mask_bits);
-		return -EIO;
-	}
-
-	*dev->dma_mask = mask;
-
-	return 0;
+	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits))
+		return 0;
+	return swiotlb_dma_supported(dev, mask);
 }
 
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
@@ -126,8 +118,7 @@ static const struct dma_map_ops loongson_dma_map_ops = {
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = swiotlb_dma_supported,
-	.set_dma_mask = loongson_dma_set_mask
+	.dma_supported = loongson_dma_supported,
 };
 
 void __init plat_swiotlb_setup(void)
-- 
2.11.0
