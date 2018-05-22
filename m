From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/25] hexagon: implement the sync_sg_for_device DMA operation
Date: Tue, 22 May 2018 14:04:07 +0200
Message-ID: <20180522120430.28709-3-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6QeQfsmxLtvSTWRm2mI425nRKZ7uJXsKokLba0UIzjw=; b=ep/oKIT5Z6y7+Y2RJbbZJXuwp
        yuVVpysgKfAIsZuZawhuWkeAft+znPbA7VCNm3VGoMtYGQfWfeVIBuiXG276RLLg2MrA/WpGjugwu
        5ccs4GK1NUddslDUsBltwZRLAtQoe+B6itcSeV1NtbyEWneDKEv3z9rUbxy9iE+n/i1+9f7h8g16A
        ixBbsxRY5REGwhtfVj6HtQpP3VNSvKYnSzlpaT8Blu7pdTcIz4ubKwswBA7tnEWzS5vgmhcAkfShq
        rOP8fSVRWmXDrLIX09/G90uShL21t70tBj8e52t99Fh19lyaJuZzFDhidf45+ZgD47nVEiUhfeaAQ
    
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

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
2.17.0

