From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 6/7] dma-mapping: make the global coherent pool conditional
Date: Mon, 12 Jul 2021 08:17:03 +0200
Message-ID: <20210712061704.4162464-7-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=6X06lcCwC1Y3gdU9i+2NMCcmA+3YPz9rMuvZMRFQNn0=; b=fXkX/fu6fAVwscLofg3PDLnrE2
 z0I85vN1ay5aPmwOi3PUiLXpxBiRXz3Rh/ofR4wYXZPqoQp2Y+1DOjMn2uhKtnFp0XbqmMHZNodsZ
 P6baR0Eoj+960/wi3oopb8YthQ66IWGb/YAP15ditUDRzsHyYH27R0+pKNFzvJpgKVcCxg0GhFiXi
 OQJKDN15n8YdJlr/oULGtrsOdQKgTKNKyFhk8ixjTflAykSUhEVj+0DguqBv1Wv5OYmpLaRjEqcsz
 /CJ4LA9F26liGUfWvghKbtSFSZy7VNbVKu4SlOCR/tw8m3UXjxQtZDMreD/cWshSxNiqhU6Cjr8S1
 fMcJYH0Q==;
In-Reply-To: <20210712061704.4162464-1-hch-jcswGhMUV9g@public.gmane.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Brian Cain <bcain-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Only build the code to support the global coherent pool if support for
it is enabled.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Tested-by: Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/dma-map-ops.h | 18 +++++++-------
 kernel/dma/coherent.c       | 47 ++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 7e49bb86a0c0..9b79aa4dd300 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -170,13 +170,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
-
-void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
-		dma_addr_t *dma_handle);
-int dma_release_from_global_coherent(int order, void *vaddr);
-int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
-		size_t size, int *ret);
-int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -186,7 +179,16 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+#endif /* CONFIG_DMA_DECLARE_COHERENT */
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
+void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
+		dma_addr_t *dma_handle);
+int dma_release_from_global_coherent(int order, void *vaddr);
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
+		size_t size, int *ret);
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
+#else
 static inline void *dma_alloc_from_global_coherent(struct device *dev,
 		ssize_t size, dma_addr_t *dma_handle)
 {
@@ -201,7 +203,7 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 {
 	return 0;
 }
-#endif /* CONFIG_DMA_DECLARE_COHERENT */
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 /*
  * This is the actual return value from the ->alloc_noncontiguous method.
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 160d4e246ecb..c05408902a68 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -20,8 +20,6 @@ struct dma_coherent_mem {
 	bool		use_dev_dma_pfn_offset;
 };
 
-static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
-
 static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
 {
 	if (dev && dev->dma_mem)
@@ -191,16 +189,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 	return 1;
 }
 
-void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
-				     dma_addr_t *dma_handle)
-{
-	if (!dma_coherent_default_memory)
-		return NULL;
-
-	return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
-					 dma_handle);
-}
-
 static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
 				       int order, void *vaddr)
 {
@@ -236,15 +224,6 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 	return __dma_release_from_coherent(mem, order, vaddr);
 }
 
-int dma_release_from_global_coherent(int order, void *vaddr)
-{
-	if (!dma_coherent_default_memory)
-		return 0;
-
-	return __dma_release_from_coherent(dma_coherent_default_memory, order,
-			vaddr);
-}
-
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
 {
@@ -290,6 +269,28 @@ int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
 }
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
+static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
+
+void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
+				     dma_addr_t *dma_handle)
+{
+	if (!dma_coherent_default_memory)
+		return NULL;
+
+	return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
+					 dma_handle);
+}
+
+int dma_release_from_global_coherent(int order, void *vaddr)
+{
+	if (!dma_coherent_default_memory)
+		return 0;
+
+	return __dma_release_from_coherent(dma_coherent_default_memory, order,
+			vaddr);
+}
+
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 				   size_t size, int *ret)
 {
@@ -311,6 +312,7 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
 	pr_info("DMA: default coherent area is set\n");
 	return 0;
 }
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 /*
  * Support for reserved memory regions defined in device tree
@@ -377,6 +379,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 	return 0;
 }
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
 static int __init dma_init_reserved_memory(void)
 {
 	if (!dma_reserved_default_memory)
@@ -384,8 +387,8 @@ static int __init dma_init_reserved_memory(void)
 	return dma_init_global_coherent(dma_reserved_default_memory->base,
 					dma_reserved_default_memory->size);
 }
-
 core_initcall(dma_init_reserved_memory);
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
 #endif
-- 
2.30.2
