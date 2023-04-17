From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 09/33] mm: Convert ptlock_init() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:24 -0700
Message-ID: <20230417205048.15870-10-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764778; x=1684356778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2z4+jy2VvwYGAEqDadtXD4/9gzlnrS5efeNMpJ5P9k=;
        b=I/h1pnbYM2DwgRZCSJteD0jcjPogajwYvoNTWu05FIt8Dug2P9e0wRrWLPxc4zYyi2
         bF+AVTemVcp3diPO+7OSxLM72RxW/MppC8vSDXDjD8liqzM1pBLkxoUoebzionO/oxsa
         qHKGIp7d97W6jlem/3yxXQy6r/jNX2Q0ie6VB85Wwsz/8JpbJnzPVNlM6MFS7XC7iPJr
         OFMLKNx0UPHxfGtNqDckarA/92oBRif46FzIncuYkpkQ+fhRc09HfBoH8I7mBRTJiPxj
         c4VsiDutZTNuFgmpjh8q1KLiugVszPA4Gaz711F805EB6LUcut5gmvOb7RYuzrO1w3sO
         Wqsw==
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7eb562909b2c..d2485a110936 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2818,7 +2818,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2827,10 +2827,10 @@ static inline bool ptlock_init(struct page *page)
 	 * It can happen if arch try to use slab for page table allocation:
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
-	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page_ptdesc(page)))
+	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
+	if (!ptlock_alloc(ptdesc))
 		return false;
-	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
+	spin_lock_init(ptlock_ptr(ptdesc));
 	return true;
 }
 
@@ -2843,13 +2843,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 static inline void ptlock_cache_init(void) {}
-static inline bool ptlock_init(struct page *page) { return true; }
+static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
-	if (!ptlock_init(page))
+	if (!ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
@@ -2908,7 +2908,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(ptdesc_page(ptdesc));
+	return ptlock_init(ptdesc);
 }
 
 static inline void pmd_ptlock_free(struct page *page)
-- 
2.39.2

