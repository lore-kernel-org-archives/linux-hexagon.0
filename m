From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/22] alpha: simplify get_arch_dma_ops
Date: Fri, 20 Apr 2018 10:02:56 +0200
Message-ID: <20180420080313.18796-6-hch@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
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
	bh=9g1t8pOerj6EYIMIra1FrOHmmdJ/YY9wwCWcZ1p8ywU=; b=DS1/e10jORFNUIGLJAwAW+2cbj
	b/6x0tFJWK3kTidCHrWIaVwjY3dKJZSwRr9CCdAiGqawyg+UwVa1C8uZOJEsvHXqx3qOa8rBuLhSL
	yEp/bEDPxzVPGRgS5B5a1ey2HA07jrXJzTnlpzQ1RK7eA/FY6XtUGez+s5SKeV6HOK5mIwvC70Sax
	Ryip3K/4OkdNP8cloKkklE5MkoX/3g5U6bYhHbd0GSpUA/6O/6hOCXpFMyCdDUZduIlWoxhNQufTT
	gZewxeffqSH0W6B1EB/zTj7n2A5H4rTWigIv+59L/XyupLGEDK1O0x7wDeiRDmYYtQw2Dl057C5oI
	ZpCd48Yg==;
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Remove the dma_ops indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/dma-mapping.h | 4 ++--
 arch/alpha/kernel/pci_iommu.c        | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 76ce923ecca1..8beeafd4f68e 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -2,14 +2,14 @@
 #ifndef _ALPHA_DMA_MAPPING_H
 #define _ALPHA_DMA_MAPPING_H
 
-extern const struct dma_map_ops *dma_ops;
+extern const struct dma_map_ops alpha_pci_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_ALPHA_JENSEN
 	return &dma_direct_ops;
 #else
-	return dma_ops;
+	return &alpha_pci_ops;
 #endif
 }
 
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 83b34b9188ea..6923b0d9c1e1 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -950,6 +950,4 @@ const struct dma_map_ops alpha_pci_ops = {
 	.mapping_error		= alpha_pci_mapping_error,
 	.dma_supported		= alpha_pci_supported,
 };
-
-const struct dma_map_ops *dma_ops = &alpha_pci_ops;
-EXPORT_SYMBOL(dma_ops);
+EXPORT_SYMBOL(alpha_pci_ops);
-- 
2.17.0
