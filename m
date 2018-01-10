From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 21/33] dma-mapping: add an arch_dma_supported hook
Date: Wed, 10 Jan 2018 09:00:15 +0100
Message-ID: <20180110080027.13879-22-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3h3P2/8IxO6IQpO8f9DTPtlVbwpGcxUpPPaVFzN/FFg=; b=V3YlOz8PixqX7t86xsanVkQof
        4hRzpvh0qV5YmNctRAV7walx3pC9gUNP0ZStCrOfGGHpJQCa22NtAU92kXPMWtTjdn5z3jLhMjFX2
        4mmQ8W0gZsv1Ky5L7rU4VQuDdrUqTyKSLwaMq/J7MesyApSMJTX1gdcUgYWM/7i/FYReW8vaigJza
        0dIAxpst9zt2Nxgx4TnCC/X2/yi2Kn+xSO5s3dVRyAK1Y8nM4EZgrz1uK8CMsGZV8rqK9vUw5P8fb
        rZPkl28/MvYSfvvtrd4xDhl4UZSATf23JhilIHsdXK0LOkT8GCDY/sOb/zi2+yTZEB45XEnueAKah
    
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

To implement the x86 forbid_dac and iommu_sac_force we want an arch hook
so that it can apply the global options across all dma_map_ops
implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h |  3 +++
 arch/x86/kernel/pci-dma.c          | 19 ++++++++++++-------
 include/linux/dma-mapping.h        | 11 +++++++++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index dfdc9357a349..6277c83c0eb1 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -30,6 +30,9 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
+int arch_dma_supported(struct device *dev, u64 mask);
+#define arch_dma_supported arch_dma_supported
+
 bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
 #define arch_dma_alloc_attrs arch_dma_alloc_attrs
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 61a8f1cb3829..df7ab02f959f 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -215,7 +215,7 @@ static __init int iommu_setup(char *p)
 }
 early_param("iommu", iommu_setup);
 
-int x86_dma_supported(struct device *dev, u64 mask)
+int arch_dma_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_PCI
 	if (mask > 0xffffffff && forbid_dac > 0) {
@@ -224,12 +224,6 @@ int x86_dma_supported(struct device *dev, u64 mask)
 	}
 #endif
 
-	/* Copied from i386. Doesn't make much sense, because it will
-	   only work for pci_alloc_coherent.
-	   The caller just has to use GFP_DMA in this case. */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
 	/* Tell the device to use SAC when IOMMU force is on.  This
 	   allows the driver to use cheaper accesses in some cases.
 
@@ -249,6 +243,17 @@ int x86_dma_supported(struct device *dev, u64 mask)
 
 	return 1;
 }
+EXPORT_SYMBOL(arch_dma_supported);
+
+int x86_dma_supported(struct device *dev, u64 mask)
+{
+	/* Copied from i386. Doesn't make much sense, because it will
+	   only work for pci_alloc_coherent.
+	   The caller just has to use GFP_DMA in this case. */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+	return 1;
+}
 
 static int __init pci_iommu_init(void)
 {
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 88bcb1a8211d..d67742dad904 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -576,6 +576,14 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
+/*
+ * This is a hack for the legacy x86 forbid_dac and iommu_sac_force. Please
+ * don't use this is new code.
+ */
+#ifndef arch_dma_supported
+#define arch_dma_supported(dev, mask)	(1)
+#endif
+
 static inline void dma_check_mask(struct device *dev, u64 mask)
 {
 	if (sme_active() && (mask < (((u64)sme_get_me_mask() << 1) - 1)))
@@ -588,6 +596,9 @@ static inline int dma_supported(struct device *dev, u64 mask)
 
 	if (!ops)
 		return 0;
+	if (!arch_dma_supported(dev, mask))
+		return 0;
+
 	if (!ops->dma_supported)
 		return 1;
 	return ops->dma_supported(dev, mask);
-- 
2.14.2
