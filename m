From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 66/67] swiotlb: remove swiotlb_{alloc,free}_coherent
Date: Fri, 29 Dec 2017 09:19:10 +0100
Message-ID: <20171229081911.2802-67-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8xMS7DFldBKVPWVVZ3i0NrEOWqn49uvnyFqEHvONQ2k=; b=RiL31EjeZBQ6uSUW9tt5Ylcbi
        YH4Mfv4tzVl1lTSvZkDK96j1ZiJ3t+W/NqavTQ81ZK5PBBdPok5zJK3X53C6eS1gjWbB0aeuoRmuC
        6i9dH26C3rpiCvwH9f7jTjnb93FfLi/0VibV9tsctQGsGf/Pp6JuGyeLFfV8QABWDNYy7sEKXwzdZ
        WerQ5x0CntOsFnWv8OPAYw3a5kFTQPA6VBC+c+5CPE+xdLOTuTX2JjialO5h88cm8Tu9Ge0fP1sik
        h+36yUmxMtDa1zWv9oBChnYEgI7g/mB35ChbOW4ypnMOOg5Stj0NZ3knr8eLTLMTJ2N7Q3SCMHt1K
    
In-Reply-To: <20171229081911.2802-1-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-cris-kernel-VrBV9hrLPhE@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-q3qR2WxjNRFS9aJRtSZj7A@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Unused now that everyone uses swiotlb_{alloc,free}.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/swiotlb.h |  8 --------
 lib/swiotlb.c           | 41 -----------------------------------------
 2 files changed, 49 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5b1f2a00491c..965be92c33b5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -72,14 +72,6 @@ void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
 void swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs);
 
-extern void
-*swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-			dma_addr_t *dma_handle, gfp_t flags);
-
-extern void
-swiotlb_free_coherent(struct device *hwdev, size_t size,
-		      void *vaddr, dma_addr_t dma_handle);
-
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 4ea0b5710618..77a40b508db8 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -157,13 +157,6 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
-/* Note that this doesn't work with highmem page */
-static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
-				      volatile void *address)
-{
-	return phys_to_dma(hwdev, virt_to_phys(address));
-}
-
 static bool no_iotlb_memory;
 
 void swiotlb_print_info(void)
@@ -743,31 +736,6 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle)
 	return NULL;
 }
 
-void *
-swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-		       dma_addr_t *dma_handle, gfp_t flags)
-{
-	int order = get_order(size);
-	void *ret;
-
-	ret = (void *)__get_free_pages(flags, order);
-	if (ret) {
-		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
-		if (*dma_handle  + size - 1 <= hwdev->coherent_dma_mask) {
-			memset(ret, 0, size);
-			return ret;
-		}
-
-		/*
-		 * The allocated memory isn't reachable by the device.
-		 */
-		free_pages((unsigned long) ret, order);
-	}
-
-	return swiotlb_alloc_buffer(hwdev, size, dma_handle);
-}
-EXPORT_SYMBOL(swiotlb_alloc_coherent);
-
 static bool swiotlb_free_buffer(struct device *dev, size_t size,
 		dma_addr_t dma_addr)
 {
@@ -787,15 +755,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 	return true;
 }
 
-void
-swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-		      dma_addr_t dev_addr)
-{
-	if (!swiotlb_free_buffer(hwdev, size, dev_addr))
-		free_pages((unsigned long)vaddr, get_order(size));
-}
-EXPORT_SYMBOL(swiotlb_free_coherent);
-
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
 	     int do_panic)
-- 
2.14.2
