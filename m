From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/22] microblaze: remove the consistent_sync and consistent_sync_page
Date: Fri, 20 Apr 2018 10:03:03 +0200
Message-ID: <20180420080313.18796-13-hch@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m6GA/Trk9SjAxyxKUe1neBo/6J1ldRwLSxslf9LBIeg=; b=QEfx43DX7xyHveiiG5cU+wxcJ
        Mg7F5mjvqHyubIqwKJCqSBpGKdNCyNXGpc+jXH4nO9yt7thCIuF4Rhy3f1RvMPqwvllTrOIL59jEw
        No7Oh4ku85KscBww2yKNwN3c/PBWWARhlnAJea1UzJiQ0qwuOvHwSt2GXdo4FTc5q1+q2mWocK1Xy
        bizvRNAQMZ/sBgo1BTbPk16/mEMC0B/AUSuaKgz8d5i+BPKeEhZ70GF1cwY2k51/ACDQPxswoRJC/
        kPBdwoTILYJTB7l7EL+S4Ws9MLtbBuwit00qWiGjGZ1EkSXaA66CPdBLYoEoaXnB3wmQGzarVP61F
    
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Both unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/pgtable.h |  3 --
 arch/microblaze/mm/consistent.c       | 45 ---------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 5174733fb489..ac6a37bd41ec 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -551,9 +551,6 @@ void __init *early_get_page(void);
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-void consistent_sync(void *vaddr, size_t size, int direction);
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction);
 unsigned long consistent_virt_to_pfn(void *vaddr);
 
 void setup_memory(void);
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index b9a9c8c3397b..c9a278ac795a 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -220,48 +220,3 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	flush_tlb_all();
 #endif
 }
-
-/*
- * make an area consistent.
- */
-void consistent_sync(void *vaddr, size_t size, int direction)
-{
-	unsigned long start;
-	unsigned long end;
-
-	start = (unsigned long)vaddr;
-
-	/* Convert start address back down to unshadowed memory region */
-#ifdef CONFIG_XILINX_UNCACHED_SHADOW
-	start &= ~UNCACHED_SHADOW_MASK;
-#endif
-	end = start + size;
-
-	switch (direction) {
-	case PCI_DMA_NONE:
-		BUG();
-	case PCI_DMA_FROMDEVICE:	/* invalidate only */
-		invalidate_dcache_range(start, end);
-		break;
-	case PCI_DMA_TODEVICE:		/* writeback only */
-		flush_dcache_range(start, end);
-		break;
-	case PCI_DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		flush_dcache_range(start, end);
-		break;
-	}
-}
-EXPORT_SYMBOL(consistent_sync);
-
-/*
- * consistent_sync_page makes memory consistent. identical
- * to consistent_sync, but takes a struct page instead of a
- * virtual address
- */
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
-{
-	unsigned long start = (unsigned long)page_address(page) + offset;
-	consistent_sync((void *)start, size, direction);
-}
-EXPORT_SYMBOL(consistent_sync_page);
-- 
2.17.0

