From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 38/67] x86/amd_gart: clean up gart_alloc_coherent
Date: Fri, 29 Dec 2017 09:18:42 +0100
Message-ID: <20171229081911.2802-39-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=abpvdwL2tCzDnXOD5F5LsLv9sD9WVcYeU1Qw53xWjCI=; b=VTxX86IDHTqoDf2+a8nuYV8gJ
        4i+WDrVz9P/uLcSCiIOlKi5qqF+sGThlXnnzLgWz6fSuWy6byWAkPK7ax0aAQOUVoqb7EAszvOs95
        L59oX5ZmP2dG9DxxlIvY1H63o1if41MXvk6SROfIAIgxF5/yOEzsCI42mldKRdSKwPD9P+3EcvJpL
        Y8MVaP3eE+4tIZFWNncy7T8eqWCoqOYQdZlZMXTGSyd6fEpp6TIWTcw6Ss+sp7Qnu+tL836w9oGkq
        XisBGCA5XhKz7TSJ47syMIXR23uuDsHqMXgy4WlbszxCxtqObKW+caaRYK8eGlQ8QA1894IzqJ3EW
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Don't rely on the gfp mask from dma_alloc_coherent_gfp_flags to make the
fallback decision, and streamline the code flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/amd_gart_64.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 52e3abcf3e70..92054815023e 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -484,26 +484,26 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 	unsigned long align_mask;
 	struct page *page;
 
-	if (force_iommu && !(flag & GFP_DMA)) {
-		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
-		if (!page)
-			return NULL;
-
-		align_mask = (1UL << get_order(size)) - 1;
-		paddr = dma_map_area(dev, page_to_phys(page), size,
-				     DMA_BIDIRECTIONAL, align_mask);
-
-		flush_gart();
-		if (paddr != bad_dma_addr) {
-			*dma_addr = paddr;
-			return page_address(page);
-		}
-		__free_pages(page, get_order(size));
-	} else
+	if (!force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		return dma_direct_alloc(dev, size, dma_addr, flag, attrs);
 
-	return NULL;
+	flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
+	page = alloc_pages(flag | __GFP_ZERO, get_order(size));
+	if (!page)
+		return NULL;
+
+	align_mask = (1UL << get_order(size)) - 1;
+	paddr = dma_map_area(dev, page_to_phys(page), size, DMA_BIDIRECTIONAL,
+			align_mask);
+
+	flush_gart();
+	if (unlikely(paddr == bad_dma_addr)) {
+		__free_pages(page, get_order(size));
+		return NULL;
+	}
+
+	*dma_addr = paddr;
+	return page_address(page);
 }
 
 /* free a coherent mapping */
-- 
2.14.2

