From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] arch/hexagon/kernel/dma.c: make function static
Date: Tue, 24 Jan 2012 14:31:36 +0100
Message-ID: <1327411896-4532-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

This function is only used in the same file, and the other similar
functions in this file are also static.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/hexagon/kernel/dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 54891e1..0b49a0a 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -54,7 +54,7 @@ static struct gen_pool *coherent_pool;
 
 /* Allocates from a pool of uncached memory that was reserved at boot time */
 
-void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
+static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t flag)
 {
 	void *ret;
