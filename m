From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 3/7] dma-mapping: allow using the global coherent pool for !ARM
Date: Mon, 12 Jul 2021 08:17:00 +0200
Message-ID: <20210712061704.4162464-4-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=6b848kiCiiuvZu1/50n3PwF2cs6P7Itlc1PU3T/9SiI=; b=VtGJbnG7GuIocAGFB7DZ0Z7WWt
 sMH9cVgC2i/qbMpVt8fnjcvG7egfIXTivsjCjTJcKl8thIu/Rawaz/lgFMYvhwB65YaFwtHTZVjmR
 CSJA2PwocavlvrHigXNtZvhEyc7Id16d7QZ4BRu0uArl6NhxWHzseD9EnphiGSshWrbcSSxjgQ5Vw
 9ziP8A5+byO4L9s5lf+X22JNsCvJ3vUL10DjmlG20urTX2+LB4H/fQO01QO3Qp68tKnm8tDNTHHhv
 eQ9ztaSEwkhSxYffDtjvS/ro6LIO9ABmCnPvC9RFcdLcgCJKe+Y0Et6H+uRoRtX9BQMv1DEYAm9XJ
 t/Wi7iFg==;
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

Switch an ifdef so that the global coherent pool is initialized for
any architecture that selects the DMA_GLOBAL_POOL symbol insted of
hardcoding ARM.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Tested-by: Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 kernel/dma/coherent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 794e76b03b34..67b126afac5a 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -361,7 +361,9 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
 	}
+#endif
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
 	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
 		WARN(dma_reserved_default_memory,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
-- 
2.30.2
