From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 32/44] hexagon: remove the unused dma_is_consistent prototype
Date: Fri, 16 Jun 2017 20:10:47 +0200
Message-ID: <20170616181059.19206-33-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/YMzv2usr3T651rHR5jW5DWvfbn0sPoYwrpjuefSYlQ=; b=qhz94I4dC6cv5YDWIKykqDosA
        j8gxdvQDDkCcHDZP6Oa6txpzjoOoV/HYx7yROy6SBa/lOMZTaBc0DAfUs2lks+Izdd/fc9p9Mu0L8
        0eXbi20t2Bav96B3ndMnQQLj+B7RBbaHbT+j2keBKljI4mv+oF4PzeS85p6fsgnZOcDPZxhOZrqIi
        g7igcylDUe9JGD5Z4dj1T4cueJ1rUipBxMiAmJ7Tyjp41QeGw1BqZoTU2k5svhmV2eHr9biOsd8if
        qCLQTxSGS2RGYMG8ksW4s7ssWn7UsGXrgGNnYXt2DMJ9BPeS5qmPNu/PgkEo42LdfBEP35HhXTbNY
    
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/dma-mapping.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 9c15cb5271a6..463dbc18f853 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -37,7 +37,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-extern int dma_is_consistent(struct device *dev, dma_addr_t dma_handle);
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 			   enum dma_data_direction direction);
 
-- 
2.11.0

