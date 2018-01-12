From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 28/34] dma-direct: use node local allocations for coherent memory
Date: Fri, 12 Jan 2018 09:42:26 +0100
Message-ID: <20180112084232.2857-29-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AXNa+fCjRIqv+P/acmRY2Gkn/X6qWpP1nSpiGkw5IlU=; b=NNqifAxnabUUuBQHWjYPXLOd7
        gMdW1BjnhHuBHwDXSyE5eDlMbdEg0CjMKs2FZwBQ+UOnQDy4hKMLQ7sAONu2BCmOd+/gcDN5yePv4
        yxfupIGGhzWX8jzqDeVeeDkEqYJSwMBf3unynTZWbEcqlAb2gxJYJBzNgaCvPEbAKdxXqIL4l7k14
        ylG1NSrtQgUy1k2U4O/iXAzbMzYgFu8stQy/qR+SDeZuhqy0PGLtoUb6d2lesNd8WSupghDsQPaTW
        0g00tVPXhhFCKygM4ShyUu1LhFaRHJoVMIvr4lietDwq8r5JUc5tdir+k0F5S4VE+n3eX2Fi1ZrXc
    
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

To preserve the x86 behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 lib/dma-direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index a9ae98be7af3..f04a424f91fa 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -38,7 +38,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
 	if (!page)
-		page = alloc_pages(gfp, page_order);
+		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
 	if (!page)
 		return NULL;
 
-- 
2.14.2

