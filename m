From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 3/4] init: free_initmem: poison freed init memory
Date: Mon, 18 Feb 2019 20:41:24 +0200
Message-ID: <1550515285-17446-4-git-send-email-rppt@linux.ibm.com>
References: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BQ8G9BVE3DVzVU729q/zVDJ/xt9JYKvdIYyu+GEPA5A=; b=MMBGrl6YLqy8xFyin7sLyZZ8uY
	65ITCHHC8ald1TF8MWM3+gAe1X+jrCf0RNXn0X4ZVYZyx8cpLG/ZfnRnVtgx2z/+FnU74jz/2LytH
	J+OXFaPz5/TwTyERtmWAtLj5UwSyk7FKHevkpzrDM3mldHBxsV35auMzM70c4+1SFB9gK56QAeK/P
	tszHN/x8/ws/RVDqP+3ZybI4R3Lgxi6pp6oXfwll52by0rLateZyOzn80+UsLQWXCKuAuQPb4Zk/G
	rzoy6bWHpsiZ0XykfPM4dJFvdQG4uonRXAJpmUvmJvhe+ysBFQl7l8YJJFNmW8ybWNtpV3dE38MYm
	iZLkermQ==;
In-Reply-To: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>

Various architectures including x86 poison the freed init memory.
Do the same in the generic free_initmem implementation and switch sparc32
architecture that is identical to the generic code over to it now.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/mm/init_32.c | 5 -----
 init/main.c             | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index f0dbc0b..d02a9ae 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -294,11 +294,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-void free_initmem (void)
-{
-	free_initmem_default(POISON_FREE_INITMEM);
-}
-
 void sparc_flush_page_to_ram(struct page *page)
 {
 	unsigned long vaddr = (unsigned long)page_address(page);
diff --git a/init/main.c b/init/main.c
index 38d69e0..9a61e9c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1049,7 +1049,7 @@ static inline void mark_readonly(void)
 
 void __weak free_initmem(void)
 {
-	free_initmem_default(-1);
+	free_initmem_default(POISON_FREE_INITMEM);
 }
 
 static int __ref kernel_init(void *unused)
-- 
2.7.4
