From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] hexagon: implement the sync_sg_for_device DMA operation
Date: Thu, 19 Jul 2018 05:56:34 -0700
Message-ID: <20180719125635.824-3-hch@lst.de>
References: <20180719125635.824-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gav4/C9vSOOXI2qu0UcM2ChCacoDHQJI2xirMnrvTFg=; b=msoGHII5gxr+bblRF00h2piVo
        PIQkk2uvFrXxPwahC8iO85E7mMy4jELkNRwBlg3xFQA9JiUdp6/IC4kAw5mB7PpOmcGW+Y2DQkXRP
        MLRdpI1hv6CD4oydgAmc75iBhyAdWfh4kK1HQtef+Yyi/oPteFsHCxbpnX7dEeFj5mgZEwMTQatjb
        LeMl2ZCrOX8sSMn0nwKr7wP+/O7tTY228PsenYQc2CYWf0M8TbRqRNaFL6H+K1y9l8uvVz08DalC/
        I6RzxJpnHn8DvUAjBuzLq+qTBTIEppJDBfPdYhyVICRFiMmRxJadrIDirxeOITMEwUMZM8D+8rR+i
    
In-Reply-To: <20180719125635.824-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

This methods needs to provide the equivalent of sync_single_for_device
for each S/G list element, but was missing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index d2b717f352f4..9e46556a227d 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -188,6 +188,18 @@ static void hexagon_sync_single_for_device(struct device *dev,
 	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
 }
 
+static void hexagon_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		hexagon_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
+}
+
+
 static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == HEXAGON_MAPPING_ERROR;
@@ -199,6 +211,7 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
 	.sync_single_for_device = hexagon_sync_single_for_device,
+	.sync_sg_for_device = hexagon_sync_sg_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
 
-- 
2.18.0

