From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 44/44] powerpc: merge __dma_set_mask into dma_set_mask
Date: Thu,  8 Jun 2017 15:26:09 +0200
Message-ID: <20170608132609.32662-45-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eZHE6yUSAfMLSefbu18rbdpTGXQMlt8s3PB24r4P6cc=; b=aJQadZcfi9maJfgN3Qgswnfgh
        f3csN/DQJrNd/PMgOamZY7jhCH7zyI/K27fC02ckR7H/ArI4cyn6YVtP3lN45NlS57RNZaup8Ixka
        PInxfM5hgOaUuMEuFE9o+iDu8SKaPFa6QOyqA2OYhHjUbvHYpB06GI9QncFVmdx8V/cgNu6cltxuV
        9eGX2LWskbAFUSuhJyTOHNeaVpvYG4ULQHExCQjnoU0zLAsmcE0oobIcqU2cfArvF4SU8hKYb2CW2
        0I9E+pNgzSQ4DSP0A4GgDrKzpWNjG1VcaI6yKgKw74d1BxhZ6GZIoNkTId3/rav/CPjLwEV8YJuSF
    
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/dma-mapping.h |  1 -
 arch/powerpc/kernel/dma.c              | 13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 73aedbe6c977..eaece3d3e225 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -112,7 +112,6 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 #define HAVE_ARCH_DMA_SET_MASK 1
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
-extern int __dma_set_mask(struct device *dev, u64 dma_mask);
 extern u64 __dma_get_required_mask(struct device *dev);
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 466c9f07b288..4194bbbbdb10 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -314,14 +314,6 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
 
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 
-int __dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-	*dev->dma_mask = dma_mask;
-	return 0;
-}
-
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (ppc_md.dma_set_mask)
@@ -334,7 +326,10 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 			return phb->controller_ops.dma_set_mask(pdev, dma_mask);
 	}
 
-	return __dma_set_mask(dev, dma_mask);
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+	*dev->dma_mask = dma_mask;
+	return 0;
 }
 EXPORT_SYMBOL(dma_set_mask);
 
-- 
2.11.0

