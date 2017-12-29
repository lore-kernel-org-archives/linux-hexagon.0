From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 26/67] dma-direct: use phys_to_dma
Date: Fri, 29 Dec 2017 09:18:30 +0100
Message-ID: <20171229081911.2802-27-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c1Lve9tF292QoAjKCLNTRmfXQiEp+LA/CtMP463KaPo=; b=AeWDIKUqSF48Ji2b+amnyx3co
        5gP9WfaaBa7ym1ZxVDR2F8MDOZgAHRz4wIwv+nE0jLGayMVBFxtp87F/eD7rc17bwV3ltU+N8yX6d
        kK7lQ26iimpdcZ+1sgXNu2n6ZiAzpNS+sCvtks31EK0CKVPb7U6I5h2q3oJQuZyIc1ZAGt5rVF4Ex
        AcyYVTgtI+HMNDo275K10iGWCMTaI9T3IERq8rYVgrKFqdy41g6Dj48XZnD5VJkGivVbAiW8jQALC
        lno+MrpRlqKddqlO+7N/akMxEnlquZab0H6zaCcYf9dYz6nDN6wzk7QqECbXD9/u0uZTi4trmBXhO
    
In-Reply-To: <20171229081911.2802-1-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-cris-kernel-VrBV9hrLPhE@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-q3qR2WxjNRFS9aJRtSZj7A@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This means it uses whatever linear remapping scheme that the architecture
provides is used in the generic dma_direct ops.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/dma-direct.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 439db40854b7..0e087650e86b 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	lib/dma-noop.c
- *
- * DMA operations that map to physical addresses without flushing memory.
+ * DMA operations that map physical memory directly without using an IOMMU or
+ * flushing caches.
  */
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/pfn.h>
 
@@ -17,7 +16,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 	if (ret)
-		*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
+		*dma_handle = phys_to_dma(dev, virt_to_phys(ret));
 
 	return ret;
 }
@@ -32,7 +31,7 @@ static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	return page_to_phys(page) + offset - PFN_PHYS(dev->dma_pfn_offset);
+	return phys_to_dma(dev, page_to_phys(page)) + offset;
 }
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
@@ -42,12 +41,9 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 
 	for_each_sg(sgl, sg, nents, i) {
-		dma_addr_t offset = PFN_PHYS(dev->dma_pfn_offset);
-		void *va;
-
 		BUG_ON(!sg_page(sg));
-		va = sg_virt(sg);
-		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va) - offset;
+
+		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.14.2
