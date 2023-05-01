From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 19/34] pgalloc: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:14 -0700
Message-ID: <20230501192829.17086-20-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969341; x=1685561341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfen1Ya6fa7BCRlN1BPOcmTNp3Sy/DALCm51X/wHZX4=;
        b=NGlfJzK3SLIyrzVeCW+cy/LENuF7AIYcpLjneyCln8/dN8tsSa+TUgx6Zs0xZt09V/
         AUoO/9vVboMIkkiAJKzWw3zNTkXyZHbg5i+Uv3Zqtu+rX4tuOiaEx2sdsDxoZuaBDGgr
         vod9dLgUvGamVrCZ2EGOCdE8ToYnRSXk/vhm78x+dP7MR2nyb1QcOC5STzovq8Qe7Hqo
         h0w/rTHUO6l4DW/cRdBZ54cZqeORpVG+YoPGSUP9GNzfvkM/15zFtG0hwm7rzS97mp6T
         8K3nb/fOTHh3fKdVDbkoQtqh9GEw5zSK4hVf63htcA2MUZQPuMJk5JXlIyYiKdaNTnZr
         +1fQ==
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Arnd Bergmann <arnd@arndb.de>

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/asm-generic/pgalloc.h | 62 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index a7cf825befae..7d4a1f5d3c17 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -18,7 +18,11 @@
  */
 static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_PGTABLE_KERNEL, 0);
+
+	if (!ptdesc)
+		return NULL;
+	return (pte_t *)ptdesc_address(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
@@ -41,7 +45,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	ptdesc_free(virt_to_ptdesc(pte));
 }
 
 /**
@@ -49,7 +53,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  * @mm: the mm_struct of the current context
  * @gfp: GFP flags to use for the allocation
  *
- * Allocates a page and runs the pgtable_pte_page_ctor().
+ * Allocates a ptdesc and runs the ptdesc_pte_ctor().
  *
  * This function is intended for architectures that need
  * anything beyond simple page allocation or must have custom GFP flags.
@@ -58,17 +62,17 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  */
 static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
 {
-	struct page *pte;
+	struct ptdesc *ptdesc;
 
-	pte = alloc_page(gfp);
-	if (!pte)
+	ptdesc = ptdesc_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(pte)) {
-		__free_page(pte);
+	if (!ptdesc_pte_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	return pte;
+	return ptdesc_page(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE
@@ -76,7 +80,7 @@ static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
  * pte_alloc_one - allocate a page for PTE-level user page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page and runs the pgtable_pte_page_ctor().
+ * Allocates a ptdesc and runs the ptdesc_pte_ctor().
  *
  * Return: `struct page` initialized as page table or %NULL on error
  */
@@ -98,8 +102,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
  */
 static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
-	pgtable_pte_page_dtor(pte_page);
-	__free_page(pte_page);
+	struct ptdesc *ptdesc = page_ptdesc(pte_page);
+
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 
@@ -110,7 +116,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
  * pmd_alloc_one - allocate a page for PMD-level page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page and runs the pgtable_pmd_page_ctor().
+ * Allocates a ptdesc and runs the ptdesc_pmd_ctor().
  * Allocations use %GFP_PGTABLE_USER in user context and
  * %GFP_PGTABLE_KERNEL in kernel context.
  *
@@ -118,28 +124,30 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
  */
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	page = alloc_page(gfp);
-	if (!page)
+	ptdesc = ptdesc_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_page(page);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
-	return (pmd_t *)page_address(page);
+	return (pmd_t *)ptdesc_address(ptdesc);
 }
 #endif
 
 #ifndef __HAVE_ARCH_PMD_FREE
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
+
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
-	free_page((unsigned long)pmd);
+	ptdesc_pmd_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 #endif
 
@@ -149,11 +157,15 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	gfp_t gfp = GFP_PGTABLE_USER;
+	gfp_t gfp = GFP_PGTABLE_USER | __GFP_ZERO;
+	struct ptdesc *ptdesc;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	return (pud_t *)get_zeroed_page(gfp);
+	ptdesc = ptdesc_alloc(gfp, 0);
+	if (!ptdesc)
+		return NULL;
+	return (pud_t *)ptdesc_address(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
@@ -175,7 +187,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	free_page((unsigned long)pud);
+	ptdesc_free(virt_to_ptdesc(pud));
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -190,7 +202,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 #ifndef __HAVE_ARCH_PGD_FREE
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_page((unsigned long)pgd);
+	ptdesc_free(virt_to_ptdesc(pgd));
 }
 #endif
 
-- 
2.39.2


