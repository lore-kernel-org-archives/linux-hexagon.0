From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v6 22/33] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:20 -0700
Message-ID: <20230627031431.29653-23-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835754; x=1690427754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=m20u0ufiAKGaCJ1eF+oXsWKBIRL5JTjyvtae8lqFZvtXfIrM7cJtjjAu/m4Uz73Z8l
         2OzyWyLCkpN3ueHXh3OYTXgBp8fMDOqyT852NuEeBcWkgEMJmVKnx3KmXsByRx3AKFHF
         Vg5wuji9LMQRgJRH1HqmX3jxPY497r0xZlE76FEouiAeDZpP9QjhFrAgiTXpIz8r0/Pn
         raAur9OcS2AWjvRxW5kW7BBQEK8M8XOe3JN2fYON+zb1b/iUEGPKmhswAXipr/RMjiJ1
         5Ou/YPdkNRNCdvvgrCiDyHNc6JnGXPl8TTudPcGz7r3XrC0of8M4idYi+6qLUVc137gj
         TxEA==
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Mike Rapoport <rppt@kernel.org>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..55988625e6fb 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)		\
-do {						\
-	pgtable_pte_page_dtor((pte));		\
-	tlb_remove_page((tlb), (pte));		\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1

