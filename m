From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 29/33] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:44 -0700
Message-ID: <20230417205048.15870-30-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764806; x=1684356806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1imWRfaXT28Tln454VWhUpR4BzNKR6UHESFdZqWEUY0=;
        b=bMzg27GqJpInZYbq5g7DlCbGyMQLVTO8/WaIXUjb9+Y1sP2Yg8U4pzTwcvHRDHiFNW
         xnksAVwNdJxrKURy2fgxnULAI227N9ToKvbiocqPRvOKs7RzP8ExmOpSZqrcqZUrdfu0
         Ly3bYv1kY3GNKQVg3ZctvJCnyIezYAOXblSfIzPoK3U4x0lQOFf2Xm+WIvk4tnnJrN+1
         YHPfjXznGMNehBha6m//o8BZSI/Chio1eErrXl3QeUgRmQPwnQk3cvQT2roiB3zkJZil
         tzHED45+1PigKvsFpmle9q7jl79yHSt/NZKlZjrviShfr3b19IL3cewZ6zZfWBjcahF9
         kN0Q==
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sh/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..30e1823d2347 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -31,10 +31,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.39.2

