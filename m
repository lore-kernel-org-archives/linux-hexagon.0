From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 39/67] iommu/amd_iommu: use dma_direct_* helpers for the direct mapping case
Date: Fri, 29 Dec 2017 09:18:43 +0100
Message-ID: <20171229081911.2802-40-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gY1REQEo200sHWj7nehvGeEo/eN8+IrnLe2EtwZurBY=; b=AXZiuNYHPqB0MPi0RnXVXd8T7
        U1s+TmDV3irWigvqZscKZZOFdVrJhaLAWQnaxXIisVkoxYkkgwxVckD7/aFWv6cQyOWszcnKZPGTn
        D/cTMECee6AHfm3xC5okVeBPiKEotbTMxf3PGZ7EVm338ry8EadujrRBY0lqTxmE8exx4CUaN7X1M
        7J+DYQNvCtzf6aT+t2i3KmeVvV+Cf5ugqWx2EimOI/awXjWtJUdHe8kGCYytsrvivlbqDG6B4WHme
        q4lJZKkQSTeFhShvoU6j+KaRNGfs1xmiXXXgxwlPYsWH17+X3DEvozNprqOrlHbc3tRTb8pGBQOtL
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This adds support for CMA allocations, but is otherwise identical.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/amd_iommu.c | 27 +++++++++------------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..dc7c1914645d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -107,6 +107,7 @@ config IOMMU_PGTABLES_L2
 # AMD IOMMU support
 config AMD_IOMMU
 	bool "AMD IOMMU support"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	select PCI_MSI
 	select PCI_ATS
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index ea4734de5357..a2ad149ab0bf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2592,11 +2592,9 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	struct page *page;
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL) {
-		page = alloc_pages(flag, get_order(size));
-		*dma_addr = page_to_phys(page);
-		return page_address(page);
-	} else if (IS_ERR(domain))
+	if (PTR_ERR(domain) == -EINVAL)
+		return dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	else if (IS_ERR(domain))
 		return NULL;
 
 	dma_dom   = to_dma_ops_domain(domain);
@@ -2642,24 +2640,17 @@ static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
 			  unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	struct page *page;
+	struct protection_domain *domain = get_domain(dev);
 
-	page = virt_to_page(virt_addr);
 	size = PAGE_ALIGN(size);
 
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		goto free_mem;
-
-	dma_dom = to_dma_ops_domain(domain);
+	if (!IS_ERR(domain)) {
+		struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
-	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+		__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+	}
 
-free_mem:
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+	dma_direct_free(dev, size, virt_addr, dma_addr, attrs);
 }
 
 /*
-- 
2.14.2

