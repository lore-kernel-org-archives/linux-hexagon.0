From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 58/67] ia64: remove an ifdef around the content of pci-dma.c
Date: Fri, 29 Dec 2017 09:19:02 +0100
Message-ID: <20171229081911.2802-59-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qEJPxY82r722va3wccbE9gkR0QaVccvPVmnX2w6WlZA=; b=Xe3UpygPIT5bZiSJXvkyl3VAL
        2Y5d7eEJb6WymusDvWnjApj1dC9ZYNNuHIdUZVcg+Vq26jAlsbuk0oPTOawXP0a83tlEDzDS8zPBP
        tT164QEdL46EFmXr2W2sG17+4fhlsDZ6Es/VrYMXqtHN9zAhTm8Tzvg4pMIL01lPCk0G68HeiXok/
        WhUolVw9xRw029WO+m9wXVkpbiAVMxzkEiK2j3AYmjQ5IIsPiGwxDRVOZF6KfCAMKylAf9fvELww9
        s66v3cp2fww50xLhvgjWQdH2eAsiKqm2W40t05voC5eRM5Zhy1+6FlGB9mYdXc4BtIOXSR/McNBAS
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

The file is only compiled if CONFIG_INTEL_IOMMU is set to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 35e0cad33b7d..b5df084c0af4 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -12,12 +12,7 @@
 #include <asm/iommu.h>
 #include <asm/machvec.h>
 #include <linux/dma-mapping.h>
-
-
-#ifdef CONFIG_INTEL_IOMMU
-
 #include <linux/kernel.h>
-
 #include <asm/page.h>
 
 dma_addr_t bad_dma_address __read_mostly;
@@ -115,5 +110,3 @@ void __init pci_iommu_alloc(void)
 	}
 #endif /* CONFIG_SWIOTLB */
 }
-
-#endif
-- 
2.14.2

