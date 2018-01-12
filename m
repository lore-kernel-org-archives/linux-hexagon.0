From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 27/34] dma-direct: add support for CMA allocation
Date: Fri, 12 Jan 2018 09:42:25 +0100
Message-ID: <20180112084232.2857-28-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QXdRAAnfvbZgT4kYEatJrEYKc4m/h5Z2aiNwAgsYFrc=; b=naPRiF5RICCfQceehqusTRLnt
        X4fx5rNfCt/Dslym6HNRtnPA7VNszbitdOvsU63zkTGM7iPmB0vAT1e4OmkbEyPJq0S30DUf+/mi3
        xZgzEfqrEsgiAGmFxFtTtLdAqYfv9ist4YM09Q0Sf/CxmLDqi5zdXYVU4AEIwyQodnWVzwW24O7Hk
        zBjhmnM18HHsQ1Lu0zzc3e7KYTfaZJlNFheO/JNCMoQI5tCJO0ADPGcqQ4/fIvNMxKWIPtn/faxoN
        akA8hDfvzLG/CRodum+gB7cRqCvIERFWRwabfEKq7Ng8nueSl1ORpLC3dG11prHL2E5Ukkzrh/E/3
    
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Try the CMA allocator for coherent allocations if supported.

Roughly modelled after the x86 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 32fd4d9e4c47..a9ae98be7af3 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
+#include <linux/dma-contiguous.h>
 #include <linux/pfn.h>
 
 #define DIRECT_MAPPING_ERROR		0
@@ -29,19 +30,30 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 static void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	void *ret;
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	int page_order = get_order(size);
+	struct page *page = NULL;
 
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-	if (ret)
-		*dma_handle = phys_to_dma(dev, virt_to_phys(ret));
+	/* CMA can be used only in the context which permits sleeping */
+	if (gfpflags_allow_blocking(gfp))
+		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
+	if (!page)
+		page = alloc_pages(gfp, page_order);
+	if (!page)
+		return NULL;
 
-	return ret;
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
+	memset(page_address(page), 0, size);
+	return page_address(page);
 }
 
 static void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	free_pages((unsigned long)cpu_addr, get_order(size));
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
+		free_pages((unsigned long)cpu_addr, get_order(size));
 }
 
 static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-- 
2.14.2

