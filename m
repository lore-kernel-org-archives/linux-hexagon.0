From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 5/7] dma-mapping: add a dma_init_global_coherent helper
Date: Mon, 12 Jul 2021 08:17:02 +0200
Message-ID: <20210712061704.4162464-6-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=scCOCDZAM0ESIiijfdMPCg1lGN//v3TmQdJkkjnF864=; b=DzyK7yGpb0OScE1g15LS/6iqJf
 BbNQMY9JTOUQ2+s0vSB2i34gqBttkK6b4ZGpW8V2mFyQwvOTtSE79ugUSqIegyl7MVqTwgkKJ0sAj
 uQqeLXAo4L+FEaaw6ru+kmZGnYvqfqcSE+C1QrhhCk7tgRM8WMISvWTr084tlZ97eq9b8HeRtgM8A
 TcGD5YrZz65+ColIsTUda2/TmspmnBb5gYVy2rVyMwC8A7vOjSWmZt/58Cn/PJ89UPn9ZdlrW6liB
 dVRNDcBf29PrJ0zI4/ZhumJb50YxuXNSqbBHaJZB3pco0Pjabn+vvErFu+19G+4Ny89sQ7w3afRCp
 SS+K34Xw==;
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

Add a new helper to initialize the global coherent pool.  This both
cleans up the existing initialization which indirects through the
reserved_mem_ops that are normally only used for struct device, and
also allows using the global pool for non-devicetree architectures.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Tested-by: Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/dma-map-ops.h |  2 +-
 kernel/dma/coherent.c       | 32 ++++++++++++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d53a96a3d64..7e49bb86a0c0 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -176,7 +176,7 @@ void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
 int dma_release_from_global_coherent(int order, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 		size_t size, int *ret);
-
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ab397ebfd5ad..160d4e246ecb 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -300,6 +300,18 @@ int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 					vaddr, size, ret);
 }
 
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
+{
+	struct dma_coherent_mem *mem;
+
+	mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
+	dma_coherent_default_memory = mem;
+	pr_info("DMA: default coherent area is set\n");
+	return 0;
+}
+
 /*
  * Support for reserved memory regions defined in device tree
  */
@@ -367,26 +379,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 
 static int __init dma_init_reserved_memory(void)
 {
-	const struct reserved_mem_ops *ops;
-	int ret;
-
 	if (!dma_reserved_default_memory)
 		return -ENOMEM;
-
-	ops = dma_reserved_default_memory->ops;
-
-	/*
-	 * We rely on rmem_dma_device_init() does not propagate error of
-	 * dma_assign_coherent_memory() for "NULL" device.
-	 */
-	ret = ops->device_init(dma_reserved_default_memory, NULL);
-
-	if (!ret) {
-		dma_coherent_default_memory = dma_reserved_default_memory->priv;
-		pr_info("DMA: default coherent area is set\n");
-	}
-
-	return ret;
+	return dma_init_global_coherent(dma_reserved_default_memory->base,
+					dma_reserved_default_memory->size);
 }
 
 core_initcall(dma_init_reserved_memory);
-- 
2.30.2
