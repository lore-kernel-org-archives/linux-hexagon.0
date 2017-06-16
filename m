From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 24/44] x86: remove DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:39 +0200
Message-ID: <20170616181059.19206-25-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/hV/3mVXpVDCJ/R2hYg6OruqzMha5mJkHSK85bOIfwg=; b=bZLvMsBZejX69gxMqQFxCipS7
        Yi1R4vp7e/3drnxZqOHRT3nYpP9cYPLvHx97vLvmiWi5i0Olz8xFCsqNRSQ4gs4dTZhFTD9aWxwoL
        /73dFJiO3PCvrbEtrr8G0NCXXkalCYDoqIysWHIpNz9N6CL2UwrjYJMRB4sZd3tEMI9Im7rSNCXjP
        d2SaDh2SgIHY1+gqPTJ4Yhij/aDsoNQvibFyKEQeXRAJV2WuluoEFduLGwACmMHcP1xuGLubSce0j
        7vBtaQ7gCRMZXK+xpN++Th8qtBcalVni0TA/gjQd6ByFuv6xrRy+dEArtx9o8CxY12C4l1k+wPFp+
    
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

All dma_map_ops instances now handle their errors through
->mapping_error.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 08a0838b83fb..c35d228aa381 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -19,8 +19,6 @@
 # define ISA_DMA_BIT_MASK DMA_BIT_MASK(32)
 #endif
 
-#define DMA_ERROR_CODE	0
-
 extern int iommu_merge;
 extern struct device x86_dma_fallback_dev;
 extern int panic_on_overflow;
-- 
2.11.0

