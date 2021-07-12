From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 4/7] dma-mapping: simplify dma_init_coherent_memory
Date: Mon, 12 Jul 2021 08:17:01 +0200
Message-ID: <20210712061704.4162464-5-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=eVxB7IvANlcif6hq/pqZXhaiA82oKpkzsJI2QfP+SPc=; b=rZgrnlJ0qlx2ZIn795mfHCSoCB
 StQY/6FsSQNEsU/FWRg9jy5p8sMfV7aEz1F0+WPJuJ/RYdOO5VMXORF8eSj0VT1Nt3lHQ0X9jp+of
 v99xmipPH5RZXef8CyYFeoMHesYxli/R/dRrivW6qi2YeCLNO4SC18NWllwnYRQo4F5/SSSiRJF4s
 S8Fpwl4CCjGgHwV5jzPS5SXg1jjUeT3kgs+gkkXk4uHvw8TCa8WjBcq0J1/WOoz35P+3rjngtjaKD
 hs1k+odKLzmtJ8wCGWdPo4U+r5XoFair8jVchXSO6s1xfNtDaLlhcCv+Mhn7oCplvqRsqaExsWvYP
 zRGcPGDg==;
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

Return the allocated dma_coherent_mem structure, set the
use_dma_pfn_offset and print the failure warning inside of
dma_init_coherent_memory instead of leaving that to the callers.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Tested-by: Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 kernel/dma/coherent.c | 78 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 67b126afac5a..ab397ebfd5ad 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -37,51 +37,44 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 	return mem->device_base;
 }
 
-static int dma_init_coherent_memory(phys_addr_t phys_addr,
-		dma_addr_t device_addr, size_t size,
-		struct dma_coherent_mem **mem)
+static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
+		dma_addr_t device_addr, size_t size, bool use_dma_pfn_offset)
 {
-	struct dma_coherent_mem *dma_mem = NULL;
-	void *mem_base = NULL;
+	struct dma_coherent_mem *dma_mem;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
-	int ret;
+	void *mem_base;
 
-	if (!size) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!size)
+		return ERR_PTR(-EINVAL);
 
 	mem_base = memremap(phys_addr, size, MEMREMAP_WC);
-	if (!mem_base) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!mem_base)
+		return ERR_PTR(-EINVAL);
+
 	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
-	if (!dma_mem) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem)
+		goto out_unmap_membase;
 	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!dma_mem->bitmap) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem->bitmap)
+		goto out_free_dma_mem;
 
 	dma_mem->virt_base = mem_base;
 	dma_mem->device_base = device_addr;
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
+	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
 	spin_lock_init(&dma_mem->spinlock);
 
-	*mem = dma_mem;
-	return 0;
+	return dma_mem;
 
-out:
+out_free_dma_mem:
 	kfree(dma_mem);
-	if (mem_base)
-		memunmap(mem_base);
-	return ret;
+out_unmap_membase:
+	memunmap(mem_base);
+	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
+		&phys_addr, size / SZ_1M);
+	return ERR_PTR(-ENOMEM);
 }
 
 static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
@@ -130,9 +123,9 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 	struct dma_coherent_mem *mem;
 	int ret;
 
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
+	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
 
 	ret = dma_assign_coherent_memory(dev, mem);
 	if (ret)
@@ -319,21 +312,16 @@ static struct reserved_mem *dma_reserved_default_memory __initdata;
 
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
-	struct dma_coherent_mem *mem = rmem->priv;
-	int ret;
-
-	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+	if (!rmem->priv) {
+		struct dma_coherent_mem *mem;
+
+		mem = dma_init_coherent_memory(rmem->base, rmem->base,
+					       rmem->size, true);
+		if (IS_ERR(mem))
+			return PTR_ERR(mem);
+		rmem->priv = mem;
 	}
-	mem->use_dev_dma_pfn_offset = true;
-	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
+	dma_assign_coherent_memory(dev, rmem->priv);
 	return 0;
 }
 
-- 
2.30.2
