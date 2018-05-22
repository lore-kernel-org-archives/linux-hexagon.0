From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/25] hexagon: remove the sync_single_for_cpu DMA operation
Date: Tue, 22 May 2018 14:04:06 +0200
Message-ID: <20180522120430.28709-2-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hI3OXgIID5yBx5WeNw19cRYoKq7b3+UClm8FsQoHHIk=; b=I4TTKp0v6J5/WxtJgduy7aeXT
        TwC4s+iV0nHxXgMJWrwI2sGATDsetf/9YVK7jyVgn7QVs5QKSFQpEzUzMDGMXeaGKaldVkgfhfARX
        TnbV/gqJECyNUcDlrew/56yQiWwIez7bk0sdm3l/IbypNS8YJ8EclDpLv67zGQPwWaEtz2P6WTVPF
        1T4LgniTTgHnW85bCHSJHkv3Nk5TcWuqocrWF7YvhgMtb2GNyoOpp5yt8hWWlarVduX8RIQ3Lyu5t
        HLE5UdLD559liVstaSkQzmz24C91WUXzCLZYlJ2PM66h4BaXtKVvti53VzgIWo5aaktX3vdMHcOkV
    
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

hexagon does all the required cache maintainance at dma map time, and none
at unmap time.  It thus has to implement sync_single_for_device to match
the map cace for buffer reuse, but there is no point in doing another
invalidation in the sync_single_cpu_case, which in terms of cache
maintainance is equivalent to the unmap case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 77459df34e2e..d2b717f352f4 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -181,13 +181,6 @@ static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
-static void hexagon_sync_single_for_cpu(struct device *dev,
-					dma_addr_t dma_handle, size_t size,
-					enum dma_data_direction dir)
-{
-	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
-}
-
 static void hexagon_sync_single_for_device(struct device *dev,
 					dma_addr_t dma_handle, size_t size,
 					enum dma_data_direction dir)
@@ -205,7 +198,6 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.free		= hexagon_free_coherent,
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
-	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
-- 
2.17.0

