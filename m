From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 56/67] ia64: use generic swiotlb_ops
Date: Fri, 29 Dec 2017 09:19:00 +0100
Message-ID: <20171229081911.2802-57-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ufI92MH35kThGqLZI/KmEQ1BFEKHUPP5/DsPsJKlPB0=; b=gaFPAIqavofE+01pEMdfQwGEP
        poBKW5aSM9qYy5j+kW7uFmi0TjNqfJhk2XJWoX69wyx60fuNk3Hsvi7uUdZK23AggDET9USrVX7Wb
        NzTIx4Ng2CsGhm1a6QcHOGKE2fHwCC0r3d5Lt1dwMbEPLmUtsAHtT1A7QUEnWucpc1RuLd3P76hfr
        JjDOM8eZo5A0C64AH9n/2HhKty5SEU6rQBXGDyGRY8ARyL4in8rEl2pPL8gM4VPl83HUFsbuggchb
        WvP/xKiC9Wvjc8LvV8p+yMR2F2UVRXMM66SldC2wCSqmNoKZNRvGvf5Qx77BQ5cLQYlkIhwNe8fBQ
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

These are identical to the ia64 ops, and would also support CMA
if enabled on ia64.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/Kconfig                |  5 +++++
 arch/ia64/hp/common/hwsw_iommu.c |  4 ++--
 arch/ia64/hp/common/sba_iommu.c  |  6 +++---
 arch/ia64/kernel/pci-swiotlb.c   | 38 +++-----------------------------------
 4 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 888acdb163cb..29148fe4bf5a 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -146,6 +146,7 @@ config IA64_GENERIC
 	bool "generic"
 	select NUMA
 	select ACPI_NUMA
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	select PCI_MSI
 	help
@@ -166,6 +167,7 @@ config IA64_GENERIC
 
 config IA64_DIG
 	bool "DIG-compliant"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 
 config IA64_DIG_VTD
@@ -181,6 +183,7 @@ config IA64_HP_ZX1
 
 config IA64_HP_ZX1_SWIOTLB
 	bool "HP-zx1/sx1000 with software I/O TLB"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Build a kernel that runs on HP zx1 and sx1000 systems even when they
@@ -204,6 +207,7 @@ config IA64_SGI_UV
 	bool "SGI-UV"
 	select NUMA
 	select ACPI_NUMA
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Selecting this option will optimize the kernel for use on UV based
@@ -214,6 +218,7 @@ config IA64_SGI_UV
 
 config IA64_HP_SIM
 	bool "Ski-simulator"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	depends on !PM
 
diff --git a/arch/ia64/hp/common/hwsw_iommu.c b/arch/ia64/hp/common/hwsw_iommu.c
index 41279f0442bd..58969039bed2 100644
--- a/arch/ia64/hp/common/hwsw_iommu.c
+++ b/arch/ia64/hp/common/hwsw_iommu.c
@@ -19,7 +19,7 @@
 #include <linux/export.h>
 #include <asm/machvec.h>
 
-extern const struct dma_map_ops sba_dma_ops, ia64_swiotlb_dma_ops;
+extern const struct dma_map_ops sba_dma_ops;
 
 /* swiotlb declarations & definitions: */
 extern int swiotlb_late_init_with_default_size (size_t size);
@@ -38,7 +38,7 @@ static inline int use_swiotlb(struct device *dev)
 const struct dma_map_ops *hwsw_dma_get_ops(struct device *dev)
 {
 	if (use_swiotlb(dev))
-		return &ia64_swiotlb_dma_ops;
+		return &swiotlb_dma_ops;
 	return &sba_dma_ops;
 }
 EXPORT_SYMBOL(hwsw_dma_get_ops);
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index d68849ad2ee1..6f05aba9012f 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2093,7 +2093,7 @@ static int __init acpi_sba_ioc_init_acpi(void)
 /* This has to run before acpi_scan_init(). */
 arch_initcall(acpi_sba_ioc_init_acpi);
 
-extern const struct dma_map_ops ia64_swiotlb_dma_ops;
+extern const struct dma_map_ops swiotlb_dma_ops;
 
 static int __init
 sba_init(void)
@@ -2108,7 +2108,7 @@ sba_init(void)
 	 * a successful kdump kernel boot is to use the swiotlb.
 	 */
 	if (is_kdump_kernel()) {
-		dma_ops = &ia64_swiotlb_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to initialize software I/O TLB:"
 				  " Try machvec=dig boot option");
@@ -2130,7 +2130,7 @@ sba_init(void)
 		 * If we didn't find something sba_iommu can claim, we
 		 * need to setup the swiotlb and switch to the dig machvec.
 		 */
-		dma_ops = &ia64_swiotlb_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to find SBA IOMMU or initialize "
 			      "software I/O TLB: Try machvec=dig boot option");
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index 4a9a6e58ad6a..0f8d5fbd86bd 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -6,8 +6,7 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
-
-#include <asm/swiotlb.h>
+#include <linux/swiotlb.h>
 #include <asm/dma.h>
 #include <asm/iommu.h>
 #include <asm/machvec.h>
@@ -15,40 +14,9 @@
 int swiotlb __read_mostly;
 EXPORT_SYMBOL(swiotlb);
 
-static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
-					 dma_addr_t *dma_handle, gfp_t gfp,
-					 unsigned long attrs)
-{
-	if (dev->coherent_dma_mask != DMA_BIT_MASK(64))
-		gfp |= GFP_DMA32;
-	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
-}
-
-static void ia64_swiotlb_free_coherent(struct device *dev, size_t size,
-				       void *vaddr, dma_addr_t dma_addr,
-				       unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-}
-
-const struct dma_map_ops ia64_swiotlb_dma_ops = {
-	.alloc = ia64_swiotlb_alloc_coherent,
-	.free = ia64_swiotlb_free_coherent,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.dma_supported = swiotlb_dma_supported,
-	.mapping_error = swiotlb_dma_mapping_error,
-};
-
 void __init swiotlb_dma_init(void)
 {
-	dma_ops = &ia64_swiotlb_dma_ops;
+	dma_ops = &swiotlb_dma_ops;
 	swiotlb_init(1);
 }
 
@@ -60,7 +28,7 @@ void __init pci_swiotlb_init(void)
 		printk(KERN_INFO "PCI-DMA: Re-initialize machine vector.\n");
 		machvec_init("dig");
 		swiotlb_init(1);
-		dma_ops = &ia64_swiotlb_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 #else
 		panic("Unable to find Intel IOMMU");
 #endif
-- 
2.14.2

