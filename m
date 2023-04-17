From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 03/33] pgtable: Create struct ptdesc
Date: Mon, 17 Apr 2023 13:50:18 -0700
Message-ID: <20230417205048.15870-4-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764769; x=1684356769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds3IS9TWlY4iXOF1Vygr3Q/N2fJxO0/Dzlxnv3cq6/0=;
        b=hr7pEt7A7XcPfK4WHrNDJyXTyW/f522/QxHB9K2NM6BmG8KnIlcSk7Prak06XFsubX
         Sjsu1MPagS5Ajy0wM6nwYZFly4hHrr9DYIrVTEdELHRdfsGo64oEk7qD+41S/NMObi8y
         l8A2tz8IWZ1X+Du4Mg5V1agW+uGCUPtQdgx1HioQtiEf01hZXw902OFYpkixEmc4936W
         rbvY3hq0N/ZSHnXC+KGydT6+ZrTUjCaNrxKIoD5OlWamJ5QPi1l2Tt7uz8xTA1Fp0QB2
         97/hz5zZCcVfwzgfNZP+zBkRfPzWu3gB3ojY6/LKA9XIpl4tn1OEejbLEhRl9E9QH4p3
         YC/g==
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

Currently, page table information is stored within struct page. As part
of simplifying struct page, create struct ptdesc for page table
information.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pgtable.h | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 023918666dd4..7cc6ea057ee9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -47,6 +47,56 @@
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
+/**
+ * struct ptdesc - Memory descriptor for page tables.
+ * @__page_flags: Same as page flags. Unused for page tables.
+ * @pt_list: List of used page tables. Used for s390 and x86.
+ * @_pt_pad_1: Padding that aliases with page's compound head.
+ * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
+ * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap only.
+ * @pt_mm: Used for x86 pgds.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @ptl: Lock for the page table.
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct ptdesc {
+	unsigned long __page_flags;
+
+	union {
+		struct list_head pt_list;
+		struct {
+			unsigned long _pt_pad_1;
+			pgtable_t pmd_huge_pte;
+		};
+	};
+	unsigned long _pt_s390_gaddr;
+
+	union {
+		struct mm_struct *pt_mm;
+		atomic_t pt_frag_refcount;
+	};
+
+#if ALLOC_SPLIT_PTLOCKS
+	spinlock_t *ptl;
+#else
+	spinlock_t ptl;
+#endif
+};
+
+#define TABLE_MATCH(pg, pt)						\
+	static_assert(offsetof(struct page, pg) == offsetof(struct ptdesc, pt))
+TABLE_MATCH(flags, __page_flags);
+TABLE_MATCH(compound_head, pt_list);
+TABLE_MATCH(compound_head, _pt_pad_1);
+TABLE_MATCH(mapping, _pt_s390_gaddr);
+TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.39.2

