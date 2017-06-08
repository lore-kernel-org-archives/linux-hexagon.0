From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 36/44] dma-mapping: remove HAVE_ARCH_DMA_SUPPORTED
Date: Thu,  8 Jun 2017 15:26:01 +0200
Message-ID: <20170608132609.32662-37-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zYODmAsncYnPSpqWa3X1eFFaz2qCC2DqCWNhjLVXGug=; b=PagLSMP2wZledOwi+nnRVcc2h
        hmDa44Rn5AYaRvZRckIbWneb6xIBRYk1pPxWlmm9cO3G/BeSFG41QB2kIAFJBRhRaee2+Jwtf/8aO
        Q4Td3owbG79EN6CarJht0wH0UTAuFjbwy/aEMSo3Hi8VKyAPBmgrg7w5vefMk4P6sd3pIE0ORxh2p
        smzFSoaQzTIzkR9ILR2Ae++R6JOm/A577/eTEz5GmuT2Ovvz31FrINBMvNXha2u49mzJM3T4/o3tN
        NkTtHzE9jmweJ4r/e6tU7naV2XhBV1PfwdaZAcuJpZmlwDopEJ8OStDqx52H9yzksulBYHgn4LYNe
    
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a57875309bfd..3e5908656226 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -549,7 +549,6 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
-#ifndef HAVE_ARCH_DMA_SUPPORTED
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -560,7 +559,6 @@ static inline int dma_supported(struct device *dev, u64 mask)
 		return 1;
 	return ops->dma_supported(dev, mask);
 }
-#endif
 
 #ifndef HAVE_ARCH_DMA_SET_MASK
 static inline int dma_set_mask(struct device *dev, u64 mask)
-- 
2.11.0

