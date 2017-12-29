From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 48/67] swiotlb: rely on dev->coherent_dma_mask
Date: Fri, 29 Dec 2017 09:18:52 +0100
Message-ID: <20171229081911.2802-49-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LRelLG5rQQy1twcwEG5RJGm/fc943jbDguWWiVhJJyM=; b=HsWMhsg8dADDbOL2oim72voZy
        9X/VBfjDPCTfyzeiOLq/wsI9ln/vO0KnjQ+v6WnuSJgiRtWPaEFH2Oxrpk1BDW7FIdlkRgVVsUieD
        XUObWQ109YiuT3UbILs7RuMC9iTTECms15TI2Ls+WyFClG1/uJTL24zJsuX4Lonu73qtbmLWIHu9e
        vZK5K9tLfgf2k3GfD5z1/8bFkcalNw63cMIwkhUyFUz9iCKraRi5/DUOKRSXuxJ1ctz/JL8jppyz6
        HPcHatAf5gBlumLMs6oe0wV24nQitZF522P/ZVwCYOlSuBGBLZznYQzxrdir0sZWB1zybTclBk49q
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

These days the coherent DMA mask is always set, so don't work around the
lack of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index e0b8980334c3..a14fff30ee9d 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -716,15 +716,11 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	dma_addr_t dev_addr;
 	void *ret;
 	int order = get_order(size);
-	u64 dma_mask = DMA_BIT_MASK(32);
-
-	if (hwdev && hwdev->coherent_dma_mask)
-		dma_mask = hwdev->coherent_dma_mask;
 
 	ret = (void *)__get_free_pages(flags, order);
 	if (ret) {
 		dev_addr = swiotlb_virt_to_bus(hwdev, ret);
-		if (dev_addr + size - 1 > dma_mask) {
+		if (dev_addr + size - 1 > hwdev->coherent_dma_mask) {
 			/*
 			 * The allocated memory isn't reachable by the device.
 			 */
@@ -747,9 +743,9 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		dev_addr = swiotlb_phys_to_dma(hwdev, paddr);
 
 		/* Confirm address can be DMA'd by device */
-		if (dev_addr + size - 1 > dma_mask) {
+		if (dev_addr + size - 1 > hwdev->coherent_dma_mask) {
 			printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
-			       (unsigned long long)dma_mask,
+			       (unsigned long long)hwdev->coherent_dma_mask,
 			       (unsigned long long)dev_addr);
 
 			/*
-- 
2.14.2

