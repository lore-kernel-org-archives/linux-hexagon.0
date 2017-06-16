From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 33/44] openrisc: remove arch-specific dma_supported implementation
Date: Fri, 16 Jun 2017 20:10:48 +0200
Message-ID: <20170616181059.19206-34-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BFYucj0uhSvBXnl0FMA4pFkMoYOOqPqumvJauQHEeVk=; b=ivoRv5J5td1CfyWX5rSU4y4xz
        3NlpwoCCfAQaJLEjYNUIXAn0f1CutARqwY1nRbya9opS+g9Fd1PNY7M2Mz4OeN9MBCt5feRbTwZMm
        A+PFj+lS27YekXQ04BSBCiWrYPksGtC9PVft5sfioQeoim55Bt7Jng2lgwT4/npbWd8/ulvz0vV3T
        WCFRp7SW/1B98RNWYmItGb9YZKDSxWos5YQFWJSeiiOvsiTNNp25kQxwWIbQpOQRNcWJ9fQdbT6D3
        VMDXjw/Y1RsErTrV/2zNIs9WBR70D6/YplgY4wykaWJTyoSjPoPzGz+2IFgrc1axAVWv0y2A93cdg
    
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This implementation is simply bogus - openrisc only has a simple
direct mapped DMA implementation and thus doesn't care about the
address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/dma-mapping.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
index a4ea139c2ef9..f41bd3cb76d9 100644
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ b/arch/openrisc/include/asm/dma-mapping.h
@@ -33,11 +33,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &or1k_dma_map_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-static inline int dma_supported(struct device *dev, u64 dma_mask)
-{
-	/* Support 32 bit DMA mask exclusively */
-	return dma_mask == DMA_BIT_MASK(32);
-}
-
 #endif	/* __ASM_OPENRISC_DMA_MAPPING_H */
-- 
2.11.0

