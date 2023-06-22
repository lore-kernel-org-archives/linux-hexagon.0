From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v5 03/33] pgtable: Create struct ptdesc
Date: Thu, 22 Jun 2023 13:57:15 -0700
Message-ID: <20230622205745.79707-4-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
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
        d=gmail.com; s=20221208; t=1687467482; x=1690059482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g10wkISUfh+NWh/zmhT9FX+m3ZttfvdTUqPKBonJP24=;
        b=pU1rNku+EwfuvvAUFkFumH3vBy2yB8eY8b9rmQMddlJoc9QhOnRcokyjWDtIUPPy9P
         MyE7phtpnefNxvysKqFF1dCChREaY4VAw7Hj9WJFlZFrzpk6eifBId3wubz0Vyh/S2pn
         8/Y3zkVGHHKKYxzZzu8HCxLQTltPQvJHitS9QsbrsAUgPjueiuuK933isxWF/RQdLHvt
         zcy+Qct09qmvfH+KRctZzkT+vvZGDQDyiysBgsbHpUxND18HRJm9vVFEK6S0KHOtgU7u
         IRCWYGiDuX3Hydg/OjrZHIGz2lGmohOF8cCd3deLunhE1oH3PJ2GTuP2PJzlmW5OQRrp
         EAKQ==
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Mike Rapoport <rppt@kernel.org>

Currently, page table information is stored within struct page. As part
of simplifying struct page, create struct ptdesc for page table
information.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/pgtable.h | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b482e34f..d46cb709ce08 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -987,6 +987,74 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
 #endif /* CONFIG_MMU */
 
+
+/**
+ * struct ptdesc -    Memory descriptor for page tables.
+ * @__page_flags:     Same as page flags. Unused for page tables.
+ * @pt_rcu_head:      For freeing page table pages.
+ * @pt_list:          List of used page tables. Used for s390 and x86.
+ * @_pt_pad_1:        Padding that aliases with page's compound head.
+ * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
+ * @_pt_s390_gaddr:   Aliases with page's mapping. Used for s390 gmap only.
+ * @pt_mm:            Used for x86 pgds.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @ptl:              Lock for the page table.
+ * @__page_type:      Same as page->page_type. Unused for page tables.
+ * @_refcount:        Same as page refcount. Used for s390 page tables.
+ * @pt_memcg_data:    Memcg data. Tracked for page tables here.
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct ptdesc {
+	unsigned long __page_flags;
+
+	union {
+		struct rcu_head pt_rcu_head;
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
+	union {
+		unsigned long _pt_pad_2;
+#if ALLOC_SPLIT_PTLOCKS
+		spinlock_t *ptl;
+#else
+		spinlock_t ptl;
+#endif
+	};
+	unsigned int __page_type;
+	atomic_t _refcount;
+#ifdef CONFIG_MEMCG
+	unsigned long pt_memcg_data;
+#endif
+};
+
+#define TABLE_MATCH(pg, pt)						\
+	static_assert(offsetof(struct page, pg) == offsetof(struct ptdesc, pt))
+TABLE_MATCH(flags, __page_flags);
+TABLE_MATCH(compound_head, pt_list);
+TABLE_MATCH(compound_head, _pt_pad_1);
+TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
+TABLE_MATCH(mapping, _pt_s390_gaddr);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+TABLE_MATCH(rcu_head, pt_rcu_head);
+#ifdef CONFIG_MEMCG
+TABLE_MATCH(memcg_data, pt_memcg_data);
+#endif
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * No-op macros that just return the current protection value. Defined here
  * because these macros can be used even if CONFIG_MMU is not defined.
-- 
2.40.1


