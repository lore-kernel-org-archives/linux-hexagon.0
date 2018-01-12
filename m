From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/34] arm64: don't override dma_max_pfn
Date: Fri, 12 Jan 2018 09:42:08 +0100
Message-ID: <20180112084232.2857-11-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eYgZKjuBGo4iF5w9wsb/Dx9CzH0M9u2BNwH1yjSCXIQ=; b=Vw5gq+baWWRjhQ5To6Fbo1LDd
        lx0PDxYr2XXcRZCLIA4685v2zbTZpaJDKMUhU3KLKmc6SYxvBpdnKXPURJbgObC6VpPL7sXjf8PrV
        Njs+bhCpBCDsShvSD2ULqDLFuwdvY3n261pm51Cl8VT0mJimvFRGy8tXS8qNycb47wriqEojoCkfA
        MGpUB+iZdd+dN2M+FBadamhDXmpro9DVdYfbPWFeQGgx6LsZQhu1UGnxBFecQcv2kURReljwjFbZR
        E1oW+ixJm0AhN541N+Kctfwb60VsQLsGLlC8GUht0cFAgvnGgSbDAlGihXcbxEemjkV1Gby9e6t4D
    
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

The generic version now takes dma_pfn_offset into account, so there is no
more need for an architecture override.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/dma-mapping.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 0df756b24863..eada887a93bf 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -76,14 +76,5 @@ static inline void dma_mark_clean(void *addr, size_t size)
 {
 }
 
-/* Override for dma_max_pfn() */
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	dma_addr_t dma_max = (dma_addr_t)*dev->dma_mask;
-
-	return (ulong)dma_to_phys(dev, dma_max) >> PAGE_SHIFT;
-}
-#define dma_max_pfn(dev) dma_max_pfn(dev)
-
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
-- 
2.14.2

