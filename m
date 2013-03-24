From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2, part4 19/39] mm/hexagon: prepare for removing num_physpages and simplify mem_init()
Date: Sun, 24 Mar 2013 15:24:55 +0800
Message-ID: <1364109934-7851-30-git-send-email-jiang.liu@huawei.com>
References: <1364109934-7851-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=51nqSG+AeVAHtis6fS6ccZxsFFLw7tU/AEuKxqluETc=;
        b=HQPoWgN9Tli1OyQBE9oO4WPhvV1YnXF9zQ5676KjxhFzRBluBOjiv9tc6W3UHsuVRg
         3zWUIhGTeULlj6jc0LPN2NmJJzy8RXn/zBYtjEKP34eDeQD04/nZSp0stNhTi3dsbeaI
         nz11oT3SqnTZU3dnRG2GPUYZ0S/wBqjLQMNsawLVjF+9VpXLayabeWl5PdF0Z1SDvAjw
         rta2yvqmKKhUQfClqTIhmFIS9omZIxmJR2CHNkFUPRzxdFTN0imFOkVehEGr6w9qWJbU
         lpGP0RhzTLHyWr6PccDwUjLGBM8QP4iTwMd20S0TA28tqSjHHKZobnhRQPCvm0wi1zOo
         yWSA==
In-Reply-To: <1364109934-7851-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

Prepare for removing num_physpages and simplify mem_init().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/hexagon/mm/init.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index c048d06e..c0f0781 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -70,9 +70,8 @@ unsigned long long kmap_generation;
 void __init mem_init(void)
 {
 	free_all_bootmem();
-	num_physpages = bootmem_lastpg;	/*  seriously, what?  */
 
-	printk(KERN_INFO "totalram_pages = %ld\n", totalram_pages);
+	mem_init_print_info(NULL);
 
 	/*
 	 *  To-Do:  someone somewhere should wipe out the bootmem map
-- 
1.7.9.5
