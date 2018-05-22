From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/25] microblaze: remove the consistent_sync and
 consistent_sync_page
Date: Tue, 22 May 2018 14:04:11 +0200
Message-ID: <20180522120430.28709-7-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5uBuFu+AGouPt9g2t+NBQ1UMR5CU5XhJIngrBXM/yMk=; b=ivVspvbdOLQQHcb7AECNTFuJNp
	ZIDO3xgHCU85xqTmNgu32OzPZwrJUjNNo5nMtDG21zn7j6MJANAEHest1PKVCJil5JYzzdoprZ2kg
	3e3qfgpR+R0uxwm7TubK5I3OeuzK36gxSyN1Tk+xVuT2HN1MIk0fmhPPFi+Sk8IE0eUp8Rg/SlDZ8
	HolMVUxPWYYQQvgw48e5J0ZSYu+zkcsFFQYpK4nLylaEu/n2VQOz14aG34EPHP3bQJ3PKlUIEdQU0
	P1c6Ll9Ur7NmkdJ4SCylJmkjIcvjzKjYWRQQi1AICQv/XKw780hIfgLk7cl4QzAT4usaBgtxu2Xeh
	Wom2HRaw==;
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Both unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/pgtable.h |  3 --
 arch/microblaze/mm/consistent.c       | 45 ---------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 8a2e654b709f..7b650ab14fa0 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -553,9 +553,6 @@ void __init *early_get_page(void);
 
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
