From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 3/3] dma-debug: unexport dma_debug_resize_entries and
	debug_dma_dump_mappings
Date: Tue, 24 Apr 2018 16:02:35 +0200
Message-ID: <20180424140235.9125-4-hch@lst.de>
References: <20180424140235.9125-1-hch@lst.de>
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
	bh=8kQIUw9gDSQdMU1a+kOuWQ9BDQ4IsqyN6cHgGWD6rWA=;
	b=Flqp82OQKjnL87udDGFvKjqwn
	trv4XvKR2UPrQVhAazweKB3odeSUDKwy99ssnylB262JfgE20sVU9IVddHZtteg7RFpz5SzmxtFRc
	43azaV4l3DgGAaQGD0SDTcR87tBJOMfpc5H2cPwzeVGLicMzZ/XOabT+kX5j92T6xJxNc4/Vwo0fs
	J16gCxuVmVuQ0JFoKgSROCcumNHrAi9ee2kyFozbP3dInvDVCUTaI4fbrVxWMqzmXPoQdVUxYzcJU
	A861oi/O8xx7uSzKVmLQEnjSPKlI8/yFzNVFmZUwXyaN+m8/tCTRKxoaHlvZarBF9F+rU/CZ+kjuB
	v4qonGSlQ==;
In-Reply-To: <20180424140235.9125-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Only used by the AMD GART driver, which must be built in.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/dma-debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 075253cb613b..6a1ebaa83623 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
 		spin_unlock_irqrestore(&bucket->lock, flags);
 	}
 }
-EXPORT_SYMBOL(debug_dma_dump_mappings);
 
 /*
  * For each mapping (initial cacheline in the case of
@@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
 
 	return ret;
 }
-EXPORT_SYMBOL(dma_debug_resize_entries);
 
 /*
  * DMA-API debugging init code
-- 
2.17.0
