From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 27/33] dma-direct: use node local allocations for coherent memory
Date: Wed, 10 Jan 2018 09:00:21 +0100
Message-ID: <20180110080027.13879-28-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Kcd6zEJ+cb8K9CZttcDgrWlPGUBFBciZ5nxkoKIodA=; b=d8K/c3sUhW6492LRVanRGX29P
        jD/NjpsxHojH+RC2xkLlcOKi2xUGk1kTbpb9MxYTWF4bO61bt/MV9a+yy5JQ3UQ/siA+tsqwVBGbj
        2CdyHtl4YDYDNik1XS4m7p3brZGK7a9y9S802xK/AuiP5lbvvkehQ6pEXRy3IqUV+1JgqtXwmO6m8
        PwrbiUs8VNSgiO/h0QIDW202xf/8lKct0GlPBG6eAJxK3nQ9OnkzjyRHpHW3cngpgvysLOygySS+F
        vW7UNaXxJMt6pC0ZVFKb8osdyGo71Tcrh+YVfod+DXbnahaoNaCmbPmeZchRrEZdaF1/iOQLSu24d
    
In-Reply-To: <20180110080027.13879-1-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-cris-kernel-VrBV9hrLPhE@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-q3qR2WxjNRFS9aJRtSZj7A@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

To preserve the x86 behavior.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/dma-direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index a9ae98be7af3..f04a424f91fa 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -38,7 +38,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
 	if (!page)
-		page = alloc_pages(gfp, page_order);
+		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
 	if (!page)
 		return NULL;
 
-- 
2.14.2
