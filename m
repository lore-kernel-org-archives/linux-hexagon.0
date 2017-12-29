From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 47/67] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
Date: Fri, 29 Dec 2017 09:18:51 +0100
Message-ID: <20171229081911.2802-48-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WZKbZA3eIEV5oOUX91JJ5Mb57W7gg00NIrYhXQ3cah0=; b=cNcclhc/cLfSyPGxneEr5nRE8
        bY8Jekv+nBNoehd9P7xSVWWDpnHKIjypIAZrFXmnTHfCYcGNq8fquzJ6cQVWjXW42pd0UxsmpFUSd
        fksaI4AbSyWKnq3n90NqTX5tSnw0p7wISsKon4qI38gnl5iOumx+7X1wTQj5mkGJ03Ju0Pnv59ld9
        1/W/1J2Kzg9hVkEqz68vZl3M2Co6zUuPZqujXfiowtjmNP7+B5NY2CDQTL6uYOc3pWGZlsIuBBRqR
        CV2nvEu0BrPQYX5cCY4gpppOuFPkGdYG0v+Ksv7YMS1R2fgK9ct09xHrabZVDnMCVzCTYAK70rUGC
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

To properly reject too small DMA masks based on the addressability of the
bounce buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 9c100f0173bf..e0b8980334c3 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1125,5 +1125,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
+	.dma_supported		= swiotlb_dma_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.14.2

