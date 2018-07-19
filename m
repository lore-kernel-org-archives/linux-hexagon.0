From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA operation
Date: Thu, 19 Jul 2018 05:56:33 -0700
Message-ID: <20180719125635.824-2-hch@lst.de>
References: <20180719125635.824-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aqD8eDnO2LcHaLjon8E2opomA3Ye3ujWt8xxAKkGCT0=; b=eln+POS1V/c2QXRI8XjOmLnXZ
        XIaGRGTrFhLLdnXyWsAHJ4oE3BC/FFHjgheSni7qkYDkjfFxw+VwXQzNKVsTr8/l3RKwdE0m87xOA
        uk28zpqxNIpaS3PnoCCcXU85RomOLl5YlBPetvmF3VerULuP439zKP2aHJbSbgNf/Gt+5WX42kifM
        QHoMkH96a2LPA+em4c0faVrHJMtITgzrh20GIwos4F5OK3nn/f3/MuotXajs6mZrVSrZMwIZTw7JR
        Ig+xRuF0tpQZY+gHirDIAIeYZKV6olM59qfyBxwl1k6xZqcNVlJw0Z/pHPEDPyK1LfAYwmzbxMthV
    
In-Reply-To: <20180719125635.824-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

hexagon does all the required cache maintainance at dma map time, and none
at unmap time.  It thus has to implement sync_single_for_device to match
the map cace for buffer reuse, but there is no point in doing another
invalidation in the sync_single_cpu_case, which in terms of cache
maintainance is equivalent to the unmap case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 77459df34e2e..d2b717f352f4 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -181,13 +181,6 @@ static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
-static void hexagon_sync_single_for_cpu(struct device *dev,
-					dma_addr_t dma_handle, size_t size,
-					enum dma_data_direction dir)
-{
-	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
-}
-
 static void hexagon_sync_single_for_device(struct device *dev,
 					dma_addr_t dma_handle, size_t size,
 					enum dma_data_direction dir)
@@ -205,7 +198,6 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.free		= hexagon_free_coherent,
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
-	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
-- 
2.18.0

