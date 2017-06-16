From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/44] openrisc: remove DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:28 +0200
Message-ID: <20170616181059.19206-14-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MsFyaXpUvV6AzYhfwwwPEWHu+YFmOLIbzw6/cpGbN90=; b=JvA9vCOeIjex5+Fk/N3PG3Dmu
        /7aY7iXBXhaiGSgpPjSb8WgqzGgV5wtcckSlQYPMFM5yB0Jv+eymuS3yhtF4ahw9Rp1j6vQU6F41Y
        W+iyNxAJyUCJuAOVKMmz/2lxDBNge+oGZnEoeEHST65eQPFlfx6QqG1PaCXRRHJWMk6xdTEOXuALb
        AbGK5Hr5/WsLXe3fP+JErh5pGvK5d5wItCQ9sejzrI5N3Us49wW0fL207vxs9TkRDbTamyUZnkZYu
        EOEV2DWu0UMEKMLU0VJDUqww7GNZlc5ue9vsdpayl3sUkEc8y5bnTtA8vwjsHkfUZt1zUHtVD+yoo
    
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

openrisc does not return errors for dma_map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
index 0c0075f17145..a4ea139c2ef9 100644
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ b/arch/openrisc/include/asm/dma-mapping.h
@@ -26,8 +26,6 @@
 #include <linux/kmemcheck.h>
 #include <linux/dma-mapping.h>
 
-#define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
-
 extern const struct dma_map_ops or1k_dma_map_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-- 
2.11.0

