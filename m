From: Stafford Horne <shorne@gmail.com>
Subject: [PATCH] mm: Remove mmu_gathers storage from remaining architectures
Date: Sat,  5 Feb 2022 23:19:53 +0900
Message-ID: <20220205141956.3315419-1-shorne@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXpUWimVQCvLi12RE7G95TNrEuugIM/jhy8DgSTBsu8=;
        b=qLWx413D4IciL39NYeWr8qU1KR5zagd8EE38Tq5GVf3hMtZW9LxygN0yy4Sa4G3nK5
         o7XjAajXRMf22xa6ELrr0cEaDEXotb5UzArukoNtgfGjDRUSdt+7iyJXwik0SHr9Wodh
         yljY+pGNwNds9QoYnXSPvr51dv6aOyDrGAhTYjB8BrhXAFdzEi1BB/kqxntwvbR2GUeY
         b9ZEp1bPcveeUhL+pWpSX54NZ/noE5QErwkq5YbhW788sNH/8JdQx4bZ/H1DqmzfaZfU
         IXI+p9FgouIgMakWQ0kSdXK+ETMqZybLhlyTcP+2my+FKNPyJmA5vcuryETrXoHZjX+w
         PZuw==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>, Brian Cain <bcain@codeaurora.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Mike Rapoport <rppt@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org

Originally the mmu_gathers were removed in commit 1c3951769621 ("mm: now
that all old mmu_gather code is gone, remove the storage").  However,
the openrisc and hexagon architecture were merged around the same time
and mmu_gathers was not removed.

This patch removes them from openrisc, hexagon and nds32:

Noticed while cleaning this warning:

    arch/openrisc/mm/init.c:41:1: warning: symbol 'mmu_gathers' was not declared. Should it be static?

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/hexagon/mm/init.c  | 2 --
 arch/nds32/mm/init.c    | 1 -
 arch/openrisc/mm/init.c | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f01e91e10d95..3167a3b5c97b 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -29,8 +29,6 @@ int max_kernel_seg = 0x303;
 /*  indicate pfn's of high memory  */
 unsigned long highstart_pfn, highend_pfn;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 /* Default cache attribute for newly created page tables */
 unsigned long _dflt_cache_att = CACHEDEF;
 
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index f63f839738c4..825c85cab1a1 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -18,7 +18,6 @@
 #include <asm/tlb.h>
 #include <asm/page.h>
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 97305bde1b16..3a021ab6f1ae 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -38,8 +38,6 @@
 
 int mem_init_done;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
-- 
2.31.1

