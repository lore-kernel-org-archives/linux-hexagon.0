From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/20] dma-mapping: simplify Kconfig dependencies
Date: Fri, 11 May 2018 09:59:26 +0200
Message-ID: <20180511075945.16548-2-hch@lst.de>
References: <20180511075945.16548-1-hch@lst.de>
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
	bh=zZhOMUi6Cec72ypBz4eype0xqUtuCBuiCxzdwF7u51s=; b=qoue5rdF/QQhTVrSP2gA2M8y3v
	ZR/14s5KWL0NBCN6yHYj+wZzBHuSD76jjk9KpUGW5u9MR7Lj2acVJVMW8oGQ4KnHvb0W6IreLG96U
	rEd7eZdt8seN1SqqNsN8cJ+T/W8y8XIJnjM5WL46rPReiXvQ6e26DThwlib1hVBrtoQz8OdKKex+S
	eaa93fZHXd4kN509ZnOTgm/boTBWjxnwgLAIZCrM1eqmQdOQdwiuCR5d5a7prZqlRH3dwapKHaqkP
	bPCL8aT5p1tbEv0QM6G6PbOeLvOOm39heUQq1KtsQxxUKRcn38NzZaCC5aUwKmavlBe5cySD4dr8L
	29B3u4QQ==;
In-Reply-To: <20180511075945.16548-1-hch@lst.de>
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

ARCH_DMA_ADDR_T_64BIT is always true for 64-bit architectures now, so we
can skip the clause requiring it.  'n' is the default default, so no need
to explicitly state it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 1d84e61cccfe..6c4e9d0ce5d1 100644
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
 
 config SWIOTLB
 	bool
-- 
2.17.0
