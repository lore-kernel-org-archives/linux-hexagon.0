From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/44] xtensa: remove DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:30 +0200
Message-ID: <20170616181059.19206-16-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m3ERni24UyejO6NccGsSdbcISmLnYEvfLcY7padaEj4=; b=OMQF3kAWNISYQp7Fm+CI5HY/Q
        2AVVACTCQc4MoXaMHz8UjAdWBvtzYkAZKmTmeAzJJD4b+fXo9OeFnKSU1Hikke2QbKjVpSi0+XP25
        LM2/WFucfnFClUHQLuTmq/LMSdJ3zWqwhiSk33YPT3mttF/GuWTati8jztQTmaMup9+VUMysD/mix
        B2XwXHIhogZnHlOcB4Q+ZO49iNiaXmmYtv5DJFaXtBmOH24CV1VGlz6kSIMOdHaKX75r0ywGkZ7Ds
        biTCFijztiPbq2qbqLO/hBXP91QpdYiZ2h/rSqFNEghZshe1P4xi/rjEmpr0j/7hrrZJ572pMxlC2
    
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

xtensa already implements the mapping_error method for its only
dma_map_ops instance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index c6140fa8c0be..269738dc9d1d 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -16,8 +16,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 
-#define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
-
 extern const struct dma_map_ops xtensa_dma_map_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-- 
2.11.0

