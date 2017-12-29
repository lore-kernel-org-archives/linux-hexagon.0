From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/67] riscv: remove the unused dma_capable helper
Date: Fri, 29 Dec 2017 09:18:15 +0100
Message-ID: <20171229081911.2802-12-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=07RuFC1Zfs8Ezi8EsP/bxOpwvBBEoSJ4OYSPIkkVu+U=; b=ZRvN+J6FJ8CxNIwvclAMyVnUd
        +1WPSEpDaNJWi5O3npPYnEekIIZ+cKXtI9uRYvT2nkut5EMYBO19iyRger7oL4azNjOBmAbLHXd2y
        zAWRJh0ezQNah+vdpsz/jF2uFXt4PTNYJpx4pdP86vbf5qExIqGu967Cx4PAduTF8Yf8LWH8DV/P/
        GPK+XwscVk0U7rIcuXOSE+hYYFK3hjG/BmgTTZ2dkbeTLyk2Y89X3eBWZSQBJgc4YT0BHfQidhaXR
        K/ArTIUWS2ob7vRqZ4PPDwFXe3bB87hy+TQW1DPEw7sAdqBItIDSCJHSqMBEjClTk61Tf4PoYRUB4
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/dma-mapping.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/riscv/include/asm/dma-mapping.h b/arch/riscv/include/asm/dma-mapping.h
index 3eec1000196d..73849e2cc761 100644
--- a/arch/riscv/include/asm/dma-mapping.h
+++ b/arch/riscv/include/asm/dma-mapping.h
@@ -27,12 +27,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 #endif	/* __ASM_RISCV_DMA_MAPPING_H */
-- 
2.14.2

