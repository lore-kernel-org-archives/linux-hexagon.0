From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/25] nds32: implement the unmap_sg DMA operation
Date: Tue, 22 May 2018 14:04:14 +0200
Message-ID: <20180522120430.28709-10-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ar/Cluo49COnQp0eRZIk86TP/uY6z/moya5VtQ2t5OM=; b=OK34m0doHy6KNU9GWnB/ECSCl
        UuFosNpmHK4DqUcfOMFj4jRZa/6joumZwv6D+jbQRmOI7qHjVKbvawPCzjJVXxH5tbMm3siNx+4vO
        n8SmgZqqUgpsdC6dGNN8oHm6ZBKBSZpq0B5NzzVpfXhLvQ1JvOgaE5y9BC81/RIpeUYs6k0b0p4Cj
        FUa8dRJXkq4BFeKMLW3wy1Tn2IiPLpnfNbOm+DyfTiV1l1x2rWvaGwMXVhy0xNFVFcjVgPwWZFfMr
        W7RlYeXDeo5xKtWJk0Jl96lGsHftv8ifhR1pfQtzQg0g6GIswpba/b6GpncLj1fqQbqPK33/aGFGL
    
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

This matches the implementation of the more commonly used unmap_single
routines and the sync_sg_for_cpu method which should provide equivalent
cache maintainance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index 4e6fb4ffd3f7..43d7fd432bb6 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -426,6 +426,12 @@ static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nhwentries, enum dma_data_direction dir,
 			       unsigned long attrs)
 {
+	int i;
+
+	for (i = 0; i < nhwentries; i++, sg++) {
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
+	}
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0

