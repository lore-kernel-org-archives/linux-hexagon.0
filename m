From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/67] dma-mapping: take dma_pfn_offset into account in dma_max_pfn
Date: Fri, 29 Dec 2017 09:18:07 +0100
Message-ID: <20171229081911.2802-4-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vdePqvUj61iE5s31eV5JeBeZN5vOIc09n73lsDtN5eM=; b=sYXC/8xbrowSOX76dPUBVx+RZ
        /woozOCIl6fmD/3HdHpZ6UcGQ8uNNXQWam7NITnKt6M73c8M4vo+fEzodY3KVhtTw6+NCp4QvTGG+
        vY9tfwd7CkQXqA245dxbEDH5BvTTZsd4CcPPtk1Fq0KU7JYzq55N7GOUz/vVkOYbz2cgFQ1ul4rxq
        JUJbwFw/jTSmlLIMm7qQK25RpM/Nt+TZiUOZ7IAtvBl3dqfKzLjjU3pwBLH+dhdc2hsBxGNW7bfYw
        lbrpMuodPclylsVdJcTENbzjr9yg7t1dZNArrGrGWkBMK7LaxJrMtcrM0T8lKSVMI3cdLjZ8LrnQZ
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This makes sure the generic version can be used with architectures /
devices that have a DMA offset in the direct mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 81ed9b2d84dc..d84951865be7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
-	return *dev->dma_mask >> PAGE_SHIFT;
+	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
 }
 #endif
 
-- 
2.14.2

