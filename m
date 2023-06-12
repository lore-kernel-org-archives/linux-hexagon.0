From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 29/34] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:18 -0700
Message-ID: <20230612210423.18611-30-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4FhigkC1CjL2k/n5tnsnhnqQSJxWtPANd614V5H15CA=; b=cYzm0X4yw1GP0y
	TNJcsJnipNXDB2FS/AlnLqwbDPezrVUeuhSojC5NvmzAvY0HxCWDqD5FpDUwoohZ94KXdOkLAPyJd
	IIdSFo5KXtvf3/h3aH6bVF7bDJLSpcM8W7XMvuKAoJgAk5DGFy+Y2pS5i7WtQdlLa8WtdKt2OjeIr
	Vz3mKgJgJN6V6qsaprYHR8bvK+G97L6XtaPWX21WeB5+uoi/dyntnPBaPzl/ySWF7Tom72NroxcPF
	r/86QWsL0GhhwEVcQrmcHKtdHsRTVG46bhIwvfyWfyYHeAZ/06RCBk1u4uudyFPstBwnsyQ5yOkwD
	AiL+ZFfK2+GSjNkVu7gg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603945; x=1689195945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAmT8w/AncpH6QVoSIrvIComylZ1SrhYEKCy+DX5WSQ=;
        b=TKVGiilQ78a/OhIPJrQkIG23uSCTs20i/bAbbkbs/oLPcc63baV2HRxlfziGdsvmbT
         NGwmW85cSCp6KespeqLEesubwuI3LepWWanH5S5npuzVlt9k5eU+arhtadffMS44bFKz
         tZe3hNLEkkGFlp7EldonlERGCsKXmABWlm5tuivlOHa4YP48jZLg/NXNUT6fL0OAV+la
         FfMXzF6x14kaKnLc9TNsZyJBWsa9Csrn4MI3KMBJ6+29vVkgPdAEbVwqoitINTtP8h57
         PClm1IA8Ha5Fd3vbc4M29HaqMx1DRRQlZyGElsQzM+NPYmwv6tn2zngJCKwAeXiQVKW2
         CRrg==
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/pgalloc.h |  8 ++++----
 arch/riscv/mm/init.c             | 16 ++++++----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 59dc12b5b7e8..d169a4f41a2e 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -153,10 +153,10 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define __pte_free_tlb(tlb, pte, buf)   \
-do {                                    \
-	pgtable_pte_page_dtor(pte);     \
-	tlb_remove_page((tlb), pte);    \
+#define __pte_free_tlb(tlb, pte, buf)			\
+do {							\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
 } while (0)
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3d689ffb2072..6bfeec80bf4e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -354,12 +354,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pte_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pte_ctor(ptdesc));
+	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pte_mapping(pte_t *ptep,
@@ -437,12 +435,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pmd_ctor(ptdesc));
+	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pmd_mapping(pmd_t *pmdp,
-- 
2.40.1
