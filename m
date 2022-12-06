From: David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable RFC 05/26] csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Tue,  6 Dec 2022 15:47:09 +0100
Message-ID: <20221206144730.163732-6-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Csnp7+G+nJ6v80HtGCFuXSpzWH31MuaqWetNrAY41Ak=; b=Tt+Bg1SsARAfkj
	ATyScKh+EhcqehHvsfZaH2luopCxSd5WQjiQ5YrGP4xFd9rM85Z0W66vxdBwH2BJogRr9HLruit3L
	tVtDbJSbvuN+HGYXutmxzmnwaXhbNBu6UKfrlq1V42GqAlcc3kMOQOMVtdWzbcOYGGbD5eNiGZbGC
	W/HaH/b3K4wVBR9SotLxU4sJvsUCm9U0FFYI3QVGOquz/JphD7WtFq47Tr9JpBMx1w1Vj3ZCWM6T/
	o5d8LJ5R1Fm/Q5PemLsRekKCTBevWEh01fGegJEix/j/jXb6I5yetUl7laU1wuQ2mtwdnNmPooq0J
	wY4zBMumRXRbYjE9gM8w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670338120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m667yVBx2IVyTiq/RwCkjJ3H3w4clpAfkhfbZM5/ykg=;
	b=MmUhq1T00FrbNf2Y/UP/ENHjPqjDKYLXRnhqaHoTnWXEHTAXsvHWG28dPXalf1oBh9D0MH
	fUswzUUMlKo7HX2FMj40GufzhyY65dmYEC2GS6iPMX6jP7B1oXTQ9+10+3ropGXw6RAXuA
	9yS5hyD3FOg9m3w++xAmdUlwf+1pZyo=
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
offset. This reduces the maximum swap space per file to 16 GiB (was 32
GiB).

We might actually be able to reuse one of the other software bits
(_PAGE_READ / PAGE_WRITE) instead, because we only have to keep
pte_present(), pte_none() and HW happy. For now, let's keep it simple
because there might be something non-obvious.

Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/csky/abiv1/inc/abi/pgtable-bits.h | 13 +++++++++----
 arch/csky/abiv2/inc/abi/pgtable-bits.h | 19 ++++++++++++-------
 arch/csky/include/asm/pgtable.h        | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index 752c8b3f9194..ae7a2f76dd42 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -10,6 +10,9 @@
 #define _PAGE_ACCESSED		(1<<3)
 #define _PAGE_MODIFIED		(1<<4)
 
+/* We borrow bit 9 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<9)
+
 /* implemented in hardware */
 #define _PAGE_GLOBAL		(1<<6)
 #define _PAGE_VALID		(1<<7)
@@ -26,7 +29,8 @@
 #define _PAGE_PROT_NONE		_PAGE_READ
 
 /*
- * Encode and decode a swap entry
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
  * Format of swap PTE:
  *     bit          0:    _PAGE_PRESENT (zero)
@@ -35,15 +39,16 @@
  *     bit          6:    _PAGE_GLOBAL (zero)
  *     bit          7:    _PAGE_VALID (zero)
  *     bit          8:    swap type[4]
- *     bit     9 - 31:    swap offset
+ *     bit          9:    exclusive marker
+ *     bit    10 - 31:    swap offset
  */
 #define __swp_type(x)			((((x).val >> 2) & 0xf) | \
 					(((x).val >> 4) & 0x10))
-#define __swp_offset(x)			((x).val >> 9)
+#define __swp_offset(x)			((x).val >> 10)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
 					((type & 0xf) << 2) | \
 					((type & 0x10) << 4) | \
-					((offset) << 9)})
+					((offset) << 10)})
 
 #define HAVE_ARCH_UNMAPPED_AREA
 
diff --git a/arch/csky/abiv2/inc/abi/pgtable-bits.h b/arch/csky/abiv2/inc/abi/pgtable-bits.h
index 7e7f389f546f..526152bd2156 100644
--- a/arch/csky/abiv2/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv2/inc/abi/pgtable-bits.h
@@ -10,6 +10,9 @@
 #define _PAGE_PRESENT		(1<<10)
 #define _PAGE_MODIFIED		(1<<11)
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<7)
+
 /* implemented in hardware */
 #define _PAGE_GLOBAL		(1<<0)
 #define _PAGE_VALID		(1<<1)
@@ -26,23 +29,25 @@
 #define _PAGE_PROT_NONE		_PAGE_WRITE
 
 /*
- * Encode and decode a swap entry
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
  * Format of swap PTE:
  *     bit          0:    _PAGE_GLOBAL (zero)
  *     bit          1:    _PAGE_VALID (zero)
  *     bit      2 - 6:    swap type
- *     bit      7 - 8:    swap offset[0 - 1]
+ *     bit          7:    exclusive marker
+ *     bit          8:    swap offset[0]
  *     bit          9:    _PAGE_WRITE (zero)
  *     bit         10:    _PAGE_PRESENT (zero)
- *     bit    11 - 31:    swap offset[2 - 22]
+ *     bit    11 - 31:    swap offset[1 - 21]
  */
 #define __swp_type(x)			(((x).val >> 2) & 0x1f)
-#define __swp_offset(x)			((((x).val >> 7) & 0x3) | \
-					(((x).val >> 9) & 0x7ffffc))
+#define __swp_offset(x)			((((x).val >> 8) & 0x1) | \
+					(((x).val >> 10) & 0x3ffffe))
 #define __swp_entry(type, offset)	((swp_entry_t) { \
 					((type & 0x1f) << 2) | \
-					((offset & 0x3) << 7) | \
-					((offset & 0x7ffffc) << 9)})
+					((offset & 0x1) << 8) | \
+					((offset & 0x3ffffe) << 10)})
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 77bc6caff2d2..574c97b9ecca 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -200,6 +200,24 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
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
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-- 
2.38.1
