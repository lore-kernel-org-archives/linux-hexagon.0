From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 29/67] dma-direct: use node local allocations for coherent memory
Date: Fri, 29 Dec 2017 09:18:33 +0100
Message-ID: <20171229081911.2802-30-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ydPJysI2VQisQouWYtaywNzd54SYhITdEROTArW2H7k=; b=kmdxrEiJIZ9NbJfa1uwos5QLI
        JmERvdRkizLkN1n6v4yKiZXUJcfGjYx+Ba99mwr1Nc8EPXcHXUUv0CknhLjMyM4p70Qfbp2cyS6gL
        1Dmmz4cCUnvedE7KufKxzPrDzCXzQ78RpaScb0hvxDnrEYGwfjF8Czl1mPYS+M4z3OxsJUxffSLfI
        cYTbPOkZPfE5U3cN2nFEJL3+qEhZl9kToJFLHDMHXcSb8pGkRw5yBDJ66ArCEaJY1q0S5kpXxudWh
        2+67xMOnxD4/qbCh0xqyNall7ZhsZk2kq7K8hXMjUk7Nt2Dv7tjAYM6SGcymr6DC3GdbaYVzpXOxt
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index d0266b39788b..ab81de3ac1d3 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -39,7 +39,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
 	if (!page)
-		page = alloc_pages(gfp, page_order);
+		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
 	if (!page)
 		return NULL;
 
-- 
2.14.2

