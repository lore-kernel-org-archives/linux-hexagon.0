From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 31/44] hexagon: remove arch-specific dma_supported implementation
Date: Fri, 16 Jun 2017 20:10:46 +0200
Message-ID: <20170616181059.19206-32-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VeOMicTSvxAgv16/nCIiw6ll9uhyDqYFc+zamxoD4nc=; b=nzYiiEqNvajW6fOb+vF0OrROD
        SHXV1QGvNm+nvvnL3Pn38j1BVt6ZUsEcTZOu1Hl/xGZH8ahQp95U7iuVdL4XUJAkMZUgTUpO3IDJr
        8y/T7JUN0snzkZFFH5yCGXk9MB2jAsrb+h+vyRRVRWQTvdQzpyNZkl12yvM/SBpQQvszcedN4PGYO
        +USqnYfOBq0JMo7Q1KK4Kj4CGM9moUl73+hbliNskkFJ/kbxy/k7fO9QfEIWGV2sX33+bj96ZRQWj
        EzLxr8ZffP9aLiBferL4Ant5+OgfWX7qC0CARlspn1Sl3xkpdHC/EwFlGWbtvBS7IQWlid2Vfxj2F
    
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This implementation is simply bogus - hexagon only has a simple
direct mapped DMA implementation and thus doesn't care about the
address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/include/asm/dma-mapping.h | 2 --
 arch/hexagon/kernel/dma.c              | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 00e3f10113b0..9c15cb5271a6 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -37,8 +37,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-extern int dma_supported(struct device *dev, u64 mask);
 extern int dma_is_consistent(struct device *dev, dma_addr_t dma_handle);
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 			   enum dma_data_direction direction);
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 71269dc0f225..9ff1b2041f85 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -35,15 +35,6 @@ static inline void *dma_addr_to_virt(dma_addr_t dma_addr)
 	return phys_to_virt((unsigned long) dma_addr);
 }
 
-int dma_supported(struct device *dev, u64 mask)
-{
-	if (mask == DMA_BIT_MASK(32))
-		return 1;
-	else
-		return 0;
-}
-EXPORT_SYMBOL(dma_supported);
-
 static struct gen_pool *coherent_pool;
 
 
-- 
2.11.0

