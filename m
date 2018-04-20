From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 16/22] sh: simplify get_arch_dma_ops
Date: Fri, 20 Apr 2018 10:03:07 +0200
Message-ID: <20180420080313.18796-17-hch@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aRSaiFbfkDN2P8FpPK1+g0zgH09rNBpip3xqDpzOkYg=; b=EqJzqsQds7onihtHbGOczl8G/
        ntWDbBem4C84QDGlfoo57aGF9tKPOJNc7npCXCtvy1K0M7whD3vagZf9R4XZnfTPfyWpFeCY4DU46
        1+53Rc7f4lq/SPLqeIZb9mK/oQW+lS2I2NWxZdmmRnteJS0358JL1/4dodd+ZI+90e6ITRmssA98K
        aZiU6qVSfcb0p9lnTBa/A6QD2wMB8irQmgRXDN+Pz0VvIY554K3iqtl6FMpsavBEVPJOEaKK5CpNC
        69NkCB0/v8U2CHtKey8BsLQITlVaw60LDM1lahhBFGVFB0tNZbN06Q99biPG+m24mon/MEKFjs9Uf
    
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Remove the indirection through the dma_ops variable, and just return
nommu_dma_ops directly from get_arch_dma_ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/dma-mapping.h |  5 ++---
 arch/sh/kernel/dma-nommu.c        |  8 +-------
 arch/sh/mm/consistent.c           |  3 ---
 arch/sh/mm/init.c                 | 10 ----------
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 41167931e5d9..149e71f95be7 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -2,12 +2,11 @@
 #ifndef __ASM_SH_DMA_MAPPING_H
 #define __ASM_SH_DMA_MAPPING_H
 
-extern const struct dma_map_ops *dma_ops;
-extern void no_iommu_init(void);
+extern const struct dma_map_ops nommu_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return dma_ops;
+	return &nommu_dma_ops;
 }
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 2077cfe73cc6..c0fff676e2e4 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -76,10 +76,4 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 #endif
 };
-
-void __init no_iommu_init(void)
-{
-	if (dma_ops)
-		return;
-	dma_ops = &nommu_dma_ops;
-}
+EXPORT_SYMBOL(nommu_dma_ops);
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index a7bff3f29c2b..af2f28572119 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -20,9 +20,6 @@
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-const struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
 				 unsigned long attrs)
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index ce0bbaa7e404..32e09f03e6bf 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -395,22 +395,12 @@ void __init paging_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
-/*
- * Early initialization for any I/O MMUs we might have.
- */
-static void __init iommu_init(void)
-{
-	no_iommu_init();
-}
-
 unsigned int mem_init_done = 0;
 
 void __init mem_init(void)
 {
 	pg_data_t *pgdat;
 
-	iommu_init();
-
 	high_memory = NULL;
 	for_each_online_pgdat(pgdat)
 		high_memory = max_t(void *, high_memory,
-- 
2.17.0

