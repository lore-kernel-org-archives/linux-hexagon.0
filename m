From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 22/34] dma-mapping: add an arch_dma_supported hook
Date: Fri, 12 Jan 2018 09:42:20 +0100
Message-ID: <20180112084232.2857-23-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=References:In-Reply-To:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3h3P2/8IxO6IQpO8f9DTPtlVbwpGcxUpPPaVFzN/FFg=;
	b=G/SQBCLYo8VIeGo4gR4vuwifk
	wanXbZcQz8PbkkmI1jcFJC2CVtL4+D6nW79V5qcn1GOElQc/SRj2Ytp3lCtbmpeVCdiNDQim/B3RN
	DMZ/j8Ocj+MKOKRh1+djKxPXuPEGazEfS46drajlIzLjkbrNEE0aIPnykAJA6G6Ryxz5YkyNQtf8s
	YYBzovzfXq0OSqaISNJ8FCi0+Kidn8BJWMXFQ7WHoa1amJsZoKKoi9pyZoRSUicob6V3ARHQqNXP3
	VadiyqwNy+PHrWd91jPEnPHVSAmA3JzObIL2R0HMatvGhZv5q8cobTSPRzWknf0TxwBQtwuHAMTmd
	RnTLwKrww==;
In-Reply-To: <20180112084232.2857-1-hch-jcswGhMUV9g@public.gmane.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, patches-q3qR2WxjNRFS9aJRtSZj7A@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cris-kernel-VrBV9hrLPhE@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

To implement the x86 forbid_dac and iommu_sac_force we want an arch hook
so that it can apply the global options across all dma_map_ops
implementations.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
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
