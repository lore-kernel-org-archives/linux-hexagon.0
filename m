From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v4, part3 21/41] mm/hexagon: prepare for removing num_physpages and simplify mem_init()
Date: Sat,  6 Apr 2013 22:32:20 +0800
Message-ID: <1365258760-30821-22-git-send-email-jiang.liu@huawei.com>
References: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
Return-path: <owner-linux-mm@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=51nqSG+AeVAHtis6fS6ccZxsFFLw7tU/AEuKxqluETc=;
        b=r+zakQoKpJHw5AEPIyPimXaRts1/3QJKwepc57qvhHPxXZwsZQn3VsSOR/N34VW00L
         HamrIukk+LFsmSaRuffH2EpiaGb5X/7UcApwlo8PpExTqob7H5/2S88K1x8gstS0wllX
         s1JZdcXq2LjPt5bynf3gqsPKV8fZWjAXaLaMYUEeqFORnmye8Jx0EHEt5BwiGWCcBfIL
         FwsPv5BDxNWiNw75ls5AsZKmMcM7QgKr3Il+LRL4862uiVF++DVHCvZtNPXY9uX3PHMo
         pVjbrMQ1KRrkt+iQ9Hab2Hs5aMf1QXVhhXdlZGJMd4U11CTQR9P0Ked5/ymZPyC0+hUe
         MRwg==
In-Reply-To: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
Sender: owner-linux-mm@kvack.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

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
