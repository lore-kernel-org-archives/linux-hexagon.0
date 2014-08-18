From: Pranith Kumar <bobby.prani@gmail.com>
Subject: [PATCH v2] flush_icache_range: Export symbol to fix build errors
Date: Mon, 18 Aug 2014 11:59:13 -0400
Message-ID: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=iAKQxXqyCD1EcxRwOtXI0Eq3ofsr0x98iRdaWmJl9qo=;
        b=FRTEFYTsMhTGI5Cx8zhK0ZS/wz4NYSUflimd/MV17gZDJHG6Pchcrd6gvbu77RHgFo
         V0nF2UGmd19f0/A86GvjgBfBhb+IS8THL6R38wKZ83j+w/bYlGtaph+TBzC+0IZEdYCr
         cXvgViVoEc9Af/cTY7dHupvkZHXnj0pM8BOZCe+FEu1+uBEX4bJLaOEszB3gcpNbe72U
         ua56z87K+zuZY8zUGJ+2DATC62ryOugpihifN01cTit5LFU7B6dA01ocD+ecoCn6ljOx
         MDmvsnuA2TxuRyLFdsOZXBQp9CDoj6zZptM9EPA4LFq8wtnDYy+/bvvp1qFy6xLHev3C
         lt0g==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Noam Camus <noamc@ezchip.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tony Lu <zlu@tilera.com>, Kirill Tkhai <tkhai@yandex.ru>, open list <linux-kernel@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>

Fix building errors occuring due to a missing export of flush_icache_range() in

kisskb.ellerman.id.au/kisskb/buildresult/11677809/

ERROR: "flush_icache_range" [drivers/misc/lkdtm.ko] undefined!

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arc/mm/cache_arc700.c | 1 +
 arch/hexagon/mm/cache.c    | 1 +
 arch/sh/mm/cache.c         | 1 +
 arch/tile/kernel/smp.c     | 1 +
 arch/xtensa/kernel/smp.c   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arc/mm/cache_arc700.c b/arch/arc/mm/cache_arc700.c
index 4670afc..e88ddbf 100644
--- a/arch/arc/mm/cache_arc700.c
+++ b/arch/arc/mm/cache_arc700.c
@@ -581,6 +581,7 @@ void flush_icache_range(unsigned long kstart, unsigned long kend)
 		tot_sz -= sz;
 	}
 }
+EXPORT_SYMBOL(flush_icache_range);
 
 /*
  * General purpose helper to make I and D cache lines consistent.
diff --git a/arch/hexagon/mm/cache.c b/arch/hexagon/mm/cache.c
index fe14ccf..0c76c80 100644
--- a/arch/hexagon/mm/cache.c
+++ b/arch/hexagon/mm/cache.c
@@ -68,6 +68,7 @@ void flush_icache_range(unsigned long start, unsigned long end)
 	);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(flush_icache_range);
 
 void hexagon_clean_dcache_range(unsigned long start, unsigned long end)
 {
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 097c2cd..f770e39 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -229,6 +229,7 @@ void flush_icache_range(unsigned long start, unsigned long end)
 
 	cacheop_on_each_cpu(local_flush_icache_range, (void *)&data, 1);
 }
+EXPORT_SYMBOL(flush_icache_range);
 
 void flush_icache_page(struct vm_area_struct *vma, struct page *page)
 {
diff --git a/arch/tile/kernel/smp.c b/arch/tile/kernel/smp.c
index 01e8ab2..19eaa62 100644
--- a/arch/tile/kernel/smp.c
+++ b/arch/tile/kernel/smp.c
@@ -183,6 +183,7 @@ void flush_icache_range(unsigned long start, unsigned long end)
 		preempt_enable();
 	}
 }
+EXPORT_SYMBOL(flush_icache_range);
 
 
 /* Called when smp_send_reschedule() triggers IRQ_RESCHEDULE. */
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 40b5a37..4d02e38 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -571,6 +571,7 @@ void flush_icache_range(unsigned long start, unsigned long end)
 	};
 	on_each_cpu(ipi_flush_icache_range, &fd, 1);
 }
+EXPORT_SYMBOL(flush_icache_range);
 
 /* ------------------------------------------------------------------------- */
 
-- 
1.9.1
