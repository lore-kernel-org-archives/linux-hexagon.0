From: Joe Perches <joe@perches.com>
Subject: [PATCH 03/25] hexagon: Use bool function return values of true/false not 1/0
Date: Mon, 30 Mar 2015 16:46:01 -0700
Message-ID: <466b3b5d2d219de964950d07cc938934a7ce7baf.1427759009.git.joe@perches.com>
References: <cover.1427759009.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1427759009.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/hexagon/include/asm/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 1696542..8d22ba5 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -56,7 +56,7 @@ extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
-		return 0;
+		return false;
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-- 
2.1.2
