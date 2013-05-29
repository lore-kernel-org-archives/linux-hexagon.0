From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v6, part4 21/41] mm/hexagon: prepare for removing num_physpages and simplify mem_init()
Date: Wed, 29 May 2013 21:57:39 +0800
Message-ID: <1369835879-23553-22-git-send-email-jiang.liu@huawei.com>
References: <1369835879-23553-1-git-send-email-jiang.liu@huawei.com>
Return-path: <owner-linux-mm@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q38WKLYP7NgRbyB4mKpKaDO4DmUYEnl8XmMGWsvyy0k=;
        b=G4nYROHuNCRB8+al0KambchBdtoKOIOg7NsJo3cdEyR1fQZs4gcDqAIaOqbPlLAVTS
         KDmZez3eELnkYYo1LDoCItj0nGkWsaM+ZPCOHLZpTVglTYCvubHJxoYUEnJwMxwCVRG2
         yPIYAdSHRVR2iXA8TGZ7mfVURJfsF3Keet5l81xFYZEVEuEBIh1C0jwrk5qf4Waq/1xX
         Cnbq+7tQ7DC14HdSh056UaeAMZB2RQrUM+cgmKbl4hpZPTZsAFsx3xjY3Nmtf9ekyzYP
         8WR0OG1Iys1ip5crYlO3Tmwwju/6UclqouU4Map5LzFNJsUlzqIR4Et7+iXW+YGPM22A
         Cc6g==
In-Reply-To: <1369835879-23553-1-git-send-email-jiang.liu@huawei.com>
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
 arch/hexagon/mm/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 0ab5b43..88977e4 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -71,9 +71,7 @@ void __init mem_init(void)
 {
 	/*  No idea where this is actually declared.  Seems to evade LXR.  */
 	free_all_bootmem();
-	num_physpages = bootmem_lastpg-ARCH_PFN_OFFSET;
-
-	printk(KERN_INFO "totalram_pages = %ld\n", totalram_pages);
+	mem_init_print_info(NULL);
 
 	/*
 	 *  To-Do:  someone somewhere should wipe out the bootmem map
-- 
1.8.1.2

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
