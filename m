From: David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable v1 02/26] alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Fri, 13 Jan 2023 18:10:02 +0100
Message-ID: <20230113171026.582290-3-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
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
	List-Owner; bh=ocI7SPtm5F+F4G9Kfefe5I809KoUyFa7PeIqPnIC+7U=; b=ChFKtbzpIPm1Rb
	TslpMayy3YnuwAv5hSpb+UB2MIDoD0Gznzdg633MGftFABfNbZxuugQATshVrxmlHpS04fwdtqfQi
	zSQqWiHxeTN2emF0zUaolkO3YKYMMZ8RXkO8KWSN9PoV4GoLbqiE4t+6MdJ5zP5KO24q9pWRvucx4
	83xWFC0V9NOh5Z7xvwM2P5Brr+7WSuCDCeUQqqq60HXWix5ZxElmaCXJvHhO4mJ8cunFm3lYDpCl2
	y98DU5P9+Y8AR1DFcJOmuDr80Di+uO7G5LCkW4fXS9RGOgSUSPuzZyykIvaUXPtCnZ/CoR3jESszB
	/dHRWLMkXFIo06AqhevA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673629864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U3pYo5y6zzHhtAhfPB+ppqMEJelTMM0ZMYgpBnRMmY=;
	b=FeXldane0G2VjaH7gxzMZyqxErViHpw5E3PJvo/7OlF2cMvLYstlPKEiA3Dm3HWkLIZCo9
	ObND6d2BKaA0l+4gmsyuFDlWTLhEq2aGnx6Zyo/z9M32VWOYszHsU4Yl7N7ShNKRGq3mef
	4kzBjmUCog+OauRTrId0+s9atvnx5ro=
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
from the type. Generic MM currently only uses 5 bits for the type
(MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.

While at it, mask the type in mk_swap_pte() as well.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/alpha/include/asm/pgtable.h | 41 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 9e45f6735d5d..970abf511b13 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -74,6 +74,9 @@ struct vm_area_struct;
 #define _PAGE_DIRTY	0x20000
 #define _PAGE_ACCESSED	0x40000
 
+/* We borrow bit 39 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	0x8000000000UL
+
 /*
  * NOTE! The "accessed" bit isn't necessarily exact:  it can be kept exactly
  * by software (use the KRE/URE/KWE/UWE bits appropriately), but I'll fake it.
@@ -301,18 +304,48 @@ extern inline void update_mmu_cache(struct vm_area_struct * vma,
 }
 
 /*
- * Non-present pages:  high 24 bits are offset, next 8 bits type,
- * low 32 bits zero.
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
+ *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+ *   <------------------- offset ------------------> E <--- type -->
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <--------------------------- zeroes -------------------------->
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
  */
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
-{ pte_t pte; pte_val(pte) = (type << 32) | (offset << 40); return pte; }
+{ pte_t pte; pte_val(pte) = ((type & 0x7f) << 32) | (offset << 40); return pte; }
 
-#define __swp_type(x)		(((x).val >> 32) & 0xff)
+#define __swp_type(x)		(((x).val >> 32) & 0x7f)
 #define __swp_offset(x)		((x).val >> 40)
 #define __swp_entry(type, off)	((swp_entry_t) { pte_val(mk_swap_pte((type), (off))) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	pte_val(pte) &= ~_PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
-- 
2.39.0
