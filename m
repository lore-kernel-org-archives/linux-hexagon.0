From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 30/67] dma-direct: retry allocations using GFP_DMA for small masks
Date: Fri, 29 Dec 2017 09:18:34 +0100
Message-ID: <20171229081911.2802-31-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZYQ0pTm9tl6ZI9zEM+q8Be7x6zZ6YPq+/uJWAGk+tFA=; b=U+NGxmGeY0p+dW5yc7FHHLtDL
        VAdqe6Vg1izSM5enhQMX025eSwG3mvtaYDI9ZpqSCP9yHWtUNc+8SvmHV9xnX+WLI4hF4cJT/ENzR
        gWaEp/hv/bjGl1dylrI6vlYnvkSHjqVNR7ybfgMn9GUIyzCjmQjqDvtCuhVT2lLTXoy75Q3TvIZ65
        cDiWKKYm/0r22wHCcMfNjOn6uUNHJTX9vikMCsCfejz0pPQdJziDZBApXUQAseNy+QQO9HBpI9xQL
        2/t7DJUjBKbUdVUWM0pYKwWKyrY0EOvJINnUnWP3rn+Cb+a51+MoxXQa2Z2aUPjp8LtSpRN+FvONW
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

If we got back an allocation that wasn't inside the support coherent mask,
retry the allocation using GFP_DMA.

Based on the x86 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index ab81de3ac1d3..f8467cb3d89a 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -28,6 +28,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 	return true;
 }
 
+static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
+{
+	return phys_to_dma(dev, phys) + size <= dev->coherent_dma_mask;
+}
+
 static void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -35,11 +40,29 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	int page_order = get_order(size);
 	struct page *page = NULL;
 
+again:
 	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp))
+	if (gfpflags_allow_blocking(gfp)) {
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
+		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+			dma_release_from_contiguous(dev, page, count);
+			page = NULL;
+		}
+	}
 	if (!page)
 		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
+
+	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+		__free_pages(page, page_order);
+		page = NULL;
+
+		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		    !(gfp & GFP_DMA)) {
+			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
+			goto again;
+		}
+	}
+
 	if (!page)
 		return NULL;
 
-- 
2.14.2

