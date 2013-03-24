From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2, part4 18/39] mm/hexagon: prepare for removing num_physpages and simplify mem_init()
Date: Sun, 24 Mar 2013 15:24:54 +0800
Message-ID: <1364109934-7851-29-git-send-email-jiang.liu@huawei.com>
References: <1364109934-7851-1-git-send-email-jiang.liu@huawei.com>
Return-path: <owner-linux-mm@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=51nqSG+AeVAHtis6fS6ccZxsFFLw7tU/AEuKxqluETc=;
        b=VsLN5Y+e0lm/s9jLdu4FP9au5KyImiue2as0y2BcVusf1kb09+x8LEJZjcST4EdASX
         ewP8+Lk/M8Oi3HJERLo6lwsf8BHwZVg1UtVjotC2ob6U0ThwniR4CF+NEmc8Z3d9SpsX
         BOqeYUxVElhS95EVosaWspqVnK+ErBQiN3TCSkPxQPIf+cI+/q3hugxDhYldXrbQrl/2
         DiRX+Qt1n0JjuxwIKq6vqnckxbK9ad9ijzgYbbAU1HeX0DM+FetlbCFi4XddLdcqZ799
         WR8g5Z3/DWsXX0Lojh3XPn0CGoU9m/XvlsgP7HerUuSRiJJz5x9Xv3kLIZFzLyuX7OQC
         0/WQ==
In-Reply-To: <1364109934-7851-1-git-send-email-jiang.liu@huawei.com>
Sender: owner-linux-mm@kvack.org
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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
