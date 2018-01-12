From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/34] s390: move s390_pci_dma_ops to asm/pci_dma.h
Date: Fri, 12 Jan 2018 09:42:17 +0100
Message-ID: <20180112084232.2857-20-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Afn0YIn1zKrL1IQlc79HRm4W+e1XRPY6Gc2rdlD9BfI=; b=NIJ/KxbKJNtpO9a8zn14YSKG6
        9ubJMubGSZKTHUmfhOFgvBe0x+kvhjE+EDRN4YijhkXFGBB95QnC8L93AA9FM19wNdz7S76g9vVid
        vWdKOJL7fOl1vIkHRjfJlwtkQYZiMXP341FBcmvf/3HGHnz0jxrzCatJF2NzfZO1paAcfKdgw/K+4
        ZULr72a9L9jY9KNN6Icc1M67v+Qrzfix5Ug09712BreNOp+hX4H449Y+mxpr7xT0kbGfYdRH9zd3v
        88DOIoxDiT5ScwkjrFIqOALxlo1GEF8P+FQKOJ6DVp66S4zSSYyAQi9U43x4u87LoebsQo6M8BmKx
    
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This is not needed in drivers, so move it to a private header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/include/asm/dma-mapping.h | 2 --
 arch/s390/include/asm/pci_dma.h     | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 2ec7240c1ada..bdc2455483f6 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -9,8 +9,6 @@
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
-extern const struct dma_map_ops s390_pci_dma_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &dma_noop_ops;
diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index e8d9161fa17a..419fac7a62c0 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -201,4 +201,7 @@ void dma_cleanup_tables(unsigned long *);
 unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr);
 void dma_update_cpu_trans(unsigned long *entry, void *page_addr, int flags);
 
+extern const struct dma_map_ops s390_pci_dma_ops;
+
+
 #endif
-- 
2.14.2

