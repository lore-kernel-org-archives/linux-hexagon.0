From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] dma-debug: simplify counting of preallocated requests
Date: Tue, 24 Apr 2018 16:02:34 +0200
Message-ID: <20180424140235.9125-3-hch@lst.de>
References: <20180424140235.9125-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QUH0a68gaSoEHBkkKkLLGw43cUAJLU8T3RebdlHNc9Y=; b=tyNQ8fiXJWtb8zSYEUFEF2fVu
        P0VUoLfxQfEhPe/n6McdL748zkdDQrfHNQIzZXDIRdv77tBIdczkHvBPjLCiCkTSHa6LJswziaLDZ
        r/nze1o6IkRm7Bwp4TK8v6Kg9S0VQ9FPmMy9G6mxs43M1NQ2cS2sEpJFG2o/NVI+nOvp4a41ylgBO
        4xWLUp4hnU0kvyJQJ/Q4hR8doeTK5zV6++s7obPy9E+dZEf1OkpaMmxNGaktDliFWHHmDU/cBiqUk
        NQSeArDWo/1/C+euI+29/oZpDzHyARKt3D4Rq09eDnr3vl2kg05srRfajHHylN6V7HUewWfMfjllG
    
In-Reply-To: <20180424140235.9125-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Just keep a single variable with a descriptive name instead of two
with confusing names.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-debug.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 712a897174e4..075253cb613b 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -132,7 +132,7 @@ static u32 min_free_entries;
 static u32 nr_total_entries;
 
 /* number of preallocated entries requested by kernel cmdline */
-static u32 req_entries;
+static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
 
 /* debugfs dentry's for the stuff above */
 static struct dentry *dma_debug_dent        __read_mostly;
@@ -1011,7 +1011,6 @@ void dma_debug_add_bus(struct bus_type *bus)
 
 static int dma_debug_init(void)
 {
-	u32 num_entries;
 	int i;
 
 	/* Do not use dma_debug_initialized here, since we really want to be
@@ -1032,12 +1031,7 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	if (req_entries)
-		num_entries = req_entries;
-	else
-		num_entries = PREALLOC_DMA_DEBUG_ENTRIES;
-
-	if (prealloc_memory(num_entries) != 0) {
+	if (prealloc_memory(nr_prealloc_entries) != 0) {
 		pr_err("DMA-API: debugging out of memory error - disabled\n");
 		global_disable = true;
 
@@ -1068,16 +1062,10 @@ static __init int dma_debug_cmdline(char *str)
 
 static __init int dma_debug_entries_cmdline(char *str)
 {
-	int res;
-
 	if (!str)
 		return -EINVAL;
-
-	res = get_option(&str, &req_entries);
-
-	if (!res)
-		req_entries = 0;
-
+	if (!get_option(&str, &nr_prealloc_entries))
+		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
 	return 0;
 }
 
-- 
2.17.0

