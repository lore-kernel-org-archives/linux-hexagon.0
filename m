From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] hexagon: drop empty and unused free_initrd_mem
Date: Thu, 15 Aug 2019 11:35:33 +0300
Message-ID: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

hexagon never reserves or initializes initrd and the only mention of it is
the empty free_initrd_mem() function.

As we have a generic implementation of free_initrd_mem(), there is no need
to define an empty stub for the hexagon implementation and it can be
dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/hexagon/mm/init.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f1f6ebd..c961773 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -71,19 +71,6 @@ void __init mem_init(void)
 	init_mm.context.ptbase = __pa(init_mm.pgd);
 }
 
-/*
- * free_initrd_mem - frees...  initrd memory.
- * @start - start of init memory
- * @end - end of init memory
- *
- * Apparently has to be passed the address of the initrd memory.
- *
- * Wrapped by #ifdef CONFIG_BLKDEV_INITRD
- */
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-}
-
 void sync_icache_dcache(pte_t pte)
 {
 	unsigned long addr;
-- 
2.7.4

