From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 23/33] loongarch: Convert various functions to use ptdescs
Date: Mon, 17 Apr 2023 13:50:38 -0700
Message-ID: <20230417205048.15870-24-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764797; x=1684356797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=;
        b=Bwk4ooUgupEoGCPug2H2Eo/HpnuuhxU7x81C/Qk6PZMSk1B54ZJ/T95wzfLs2bHmOL
         EoIfThp59UctKku6w1OEzm9Tx1+NGxZtvh5x5EZcL/GqxrGONyvWeZgGKJ7IB/ueJlyr
         3shywEfhQgNVSuay+LMKRYZJ2fcroNukWPhJ2nbiEAP2p1v1zQae9MOASciSz7iDNPe8
         PaaHFDAGtzWOJsB/jrA0V4yjZJzVFkj1D7lHE74htYvR1G0N63C9Bb92oSk5fpPTqJrg
         y20llT4kvkmAZ0rau94Yl1KLiffp2Awm3htmoO0PKOmikRHdd7NJITZhSry9QyqyhUwZ
         8Oiw==
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/loongarch/include/asm/pgalloc.h | 27 +++++++++++++++------------
 arch/loongarch/mm/pgtable.c          |  7 ++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..1fe074f85b6b 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -45,9 +45,9 @@ extern void pagetable_init(void);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -55,18 +55,18 @@ do {							\
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	struct page *pg;
+	struct ptdesc *ptdesc;
 
-	pg = alloc_page(GFP_KERNEL_ACCOUNT);
-	if (!pg)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, 0);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_page(pg);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = (pmd_t *)ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -80,10 +80,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	pud = (pud_t *) __get_free_page(GFP_KERNEL);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = (pud_t *)ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 36a6dc0148ae..ff07b8f1ef30 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,10 +11,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *)ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.39.2

