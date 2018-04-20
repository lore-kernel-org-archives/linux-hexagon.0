From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/22] dma-mapping: simplify Kconfig dependencies
Date: Fri, 20 Apr 2018 10:02:53 +0200
Message-ID: <20180420080313.18796-3-hch@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=98RYNH+rsBDAeUwoXSvDYGPRfptiV++DxuBuNJ5/zck=; b=gvIOAIoMXbzPz6WxsyRFZUhny
        9/IEuAEpmHjHSxJ5sFJw3AvOTpHHNsZVHoxuGB+Qzml6KGBExZa1YO/LYRBphrNadSltqCd4bM3em
        b+1zeY8B4JkV4NCA3OiElhoYxkI43IZWYr1KjlCqJqmBmv4h9AcX7564SVEewWRL8rnsMj7etchhu
        8L55q7bPu32iqn7SiDKGa+WXJPTmFQJry9mKNkW3P/7clB/RM1j23mdBHf9eKig5vwSuD9hvuXuV3
        /Hj0BYCksXFE/2D2T94vLdcHRuEMhu/2cqr4Udyjxs+SmHod3Qu7+K0LDUgszVKgOYU+6gTSXXfXP
    
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

ARCH_DMA_ADDR_T_64BIT is always true for 64-bit architectures now, so we
can skip the clause requiring it.  'n' is the default default, so no need
to explicitly state it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 01a37920949c..726b0562caa7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -443,13 +443,11 @@ config IOMMU_HELPER
 
 config DMA_DIRECT_OPS
 	bool
-	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
-	default n
+	depends on HAS_DMA
 
 config DMA_VIRT_OPS
 	bool
-	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
-	default n
+	depends on HAS_DMA
 
 config ARCH_HAS_SWIOTLB
 	bool
-- 
2.17.0

