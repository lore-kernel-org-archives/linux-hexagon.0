From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 42/44] powerpc/cell: use the dma_supported method for ops switching
Date: Fri, 16 Jun 2017 20:10:57 +0200
Message-ID: <20170616181059.19206-43-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XON3TUW36P2rkN5fIDq3P1sFNA/9AOY+WuuJ/+oqbms=; b=qZA7Yuj9VeeGUk9FtvLL0QsTy
        fQ/Yd0bYMgd3qGgG/qAge05mziWOSJhS519orDfn+rtI6esCr3rZiLJDTntLzk+Vl9z4Qe2iEsWy4
        IP3PQdUjFZ/YMuJFKJjtnXRofuVvSkpdhv+2XUmcG2T7/1Ogkb9FtFHXKGzKNlnQl3e0ZH363zQZ6
        Gmzy7/vt4dSgYEkIHg2UUghm29Q1rguReuDDAWoB80Okc2r7aStxI2sjEGHD78jLPPH/pmeH9hq4I
        2je8mRXsIb0XhUthmXgz1iemePDD4lB+bTSMZ7A1xSNMZx/SVuoE8zv7zq4bmJJyWQ5snr91OD04R
    
In-Reply-To: <20170616181059.19206-1-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Besides removing the last instance of the set_dma_mask method this also
reduced the code duplication.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/powerpc/platforms/cell/iommu.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 497bfbdbd967..29d4f96ed33e 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -644,20 +644,14 @@ static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
 				   direction, attrs);
 }
 
-static int dma_fixed_dma_supported(struct device *dev, u64 mask)
-{
-	return mask == DMA_BIT_MASK(64);
-}
-
-static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask);
+static int dma_suported_and_switch(struct device *dev, u64 dma_mask);
 
 static const struct dma_map_ops dma_iommu_fixed_ops = {
 	.alloc          = dma_fixed_alloc_coherent,
 	.free           = dma_fixed_free_coherent,
 	.map_sg         = dma_fixed_map_sg,
 	.unmap_sg       = dma_fixed_unmap_sg,
-	.dma_supported  = dma_fixed_dma_supported,
-	.set_dma_mask   = dma_set_mask_and_switch,
+	.dma_supported  = dma_suported_and_switch,
 	.map_page       = dma_fixed_map_page,
 	.unmap_page     = dma_fixed_unmap_page,
 	.mapping_error	= dma_iommu_mapping_error,
@@ -952,11 +946,8 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 	return dev_addr;
 }
 
-static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
+static int dma_suported_and_switch(struct device *dev, u64 dma_mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
 	if (dma_mask == DMA_BIT_MASK(64) &&
 	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
 		u64 addr = cell_iommu_get_fixed_address(dev) +
@@ -965,14 +956,16 @@ static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
 		dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 		set_dma_ops(dev, &dma_iommu_fixed_ops);
 		set_dma_offset(dev, addr);
-	} else {
+		return 1;
+	}
+
+	if (dma_iommu_dma_supported(dev, dma_mask)) {
 		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
 		set_dma_ops(dev, get_pci_dma_ops());
 		cell_dma_dev_setup(dev);
+		return 1;
 	}
 
-	*dev->dma_mask = dma_mask;
-
 	return 0;
 }
 
@@ -1127,7 +1120,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
 		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
 	}
 
-	dma_iommu_ops.set_dma_mask = dma_set_mask_and_switch;
+	dma_iommu_ops.dma_supported = dma_suported_and_switch;
 	set_pci_dma_ops(&dma_iommu_ops);
 
 	return 0;
-- 
2.11.0
