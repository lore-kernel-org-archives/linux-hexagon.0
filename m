From: David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable v1 06/26] hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Fri, 13 Jan 2023 18:10:06 +0100
Message-ID: <20230113171026.582290-7-david@redhat.com>
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
	List-Owner; bh=f1JKNSBXakazUMzhdidxTLPfQU4paq0SygyU29z5BcE=; b=QI6RwkFlUHCvb3
	AqiKsLF73DN7smHgVlruRRuE5PeZyKZfLRiWM4vd2bwlIKLtrfzmRPcpPaC1EtXu+oAALxFDIMhG1
	XEfMjRe8tv7ONi8cdCxux5S8DCLE+0o8n5kknQh6QP7I2pC3lMFUnc+RLkqZOgAxV+RMf/nxCN/2q
	bfnG/XPq/fgXC+QpOZ6XJD/XmrR/oJOB4zPKEdnPqYry1EtSu5uUwYzInrEofpC/B/cq1y2BIDBPh
	/OwgqLQJd2NW2jYmd5+WqU1IQQmfSH7Qa7L+G0XeoKQoKRn5+TPhB4U4t/GQuvd/WmJKld24m6c/F
	I0/tbTAEyqU8KQ7nKJ3w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673629892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Tra/8OvEB/D6RZgFaJhZ/NUp8ml8r1Zefl0IpfbRbo=;
	b=Fx0ypC7oGtzJSDN3w5eiqeFg0b2PIDVoG+Arxx/E2k+AFUi4zoHH0967R0bY9Cd8aUtrd2
	KKBdyEPwoYiEq8S/XILqFijeam/WtL5gaHWPynsqCBGbE/oqShUc5MXnjzzYPOGvLGGWxQ
	EknSESD3UCHKp8kjBr5+Jv4ysndyVxY=
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
offset. This reduces the maximum swap space per file to 16 GiB (was 32
GiB).

While at it, mask the type in __swp_entry().

Cc: Brian Cain <bcain@quicinc.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/hexagon/include/asm/pgtable.h | 37 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index f7048c18b6f9..7eb008e477c8 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -61,6 +61,9 @@ extern unsigned long empty_zero_page;
  * So we'll put up with a bit of inefficiency for now...
  */
 
+/* We borrow bit 6 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<6)
+
 /*
  * Top "FOURTH" level (pgd), which for the Hexagon VM is really
  * only the second from the bottom, pgd and pud both being collapsed.
@@ -359,9 +362,12 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define ZERO_PAGE(vaddr) (virt_to_page(&empty_zero_page))
 
 /*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
  * Swap/file PTE definitions.  If _PAGE_PRESENT is zero, the rest of the PTE is
  * interpreted as swap information.  The remaining free bits are interpreted as
- * swap type/offset tuple.  Rather than have the TLB fill handler test
+ * listed below.  Rather than have the TLB fill handler test
  * _PAGE_PRESENT, we're going to reserve the permissions bits and set them to
  * all zeros for swap entries, which speeds up the miss handler at the cost of
  * 3 bits of offset.  That trade-off can be revisited if necessary, but Hexagon
@@ -371,9 +377,10 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * Format of swap PTE:
  *	bit	0:	Present (zero)
  *	bits	1-5:	swap type (arch independent layer uses 5 bits max)
- *	bits	6-9:	bits 3:0 of offset
+ *	bit	6:	exclusive marker
+ *	bits	7-9:	bits 2:0 of offset
  *	bits	10-12:	effectively _PAGE_PROTNONE (all zero)
- *	bits	13-31:  bits 22:4 of swap offset
+ *	bits	13-31:  bits 21:3 of swap offset
  *
  * The split offset makes some of the following macros a little gnarly,
  * but there's plenty of precedent for this sort of thing.
@@ -383,11 +390,29 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define __swp_type(swp_pte)		(((swp_pte).val >> 1) & 0x1f)
 
 #define __swp_offset(swp_pte) \
-	((((swp_pte).val >> 6) & 0xf) | (((swp_pte).val >> 9) & 0x7ffff0))
+	((((swp_pte).val >> 7) & 0x7) | (((swp_pte).val >> 10) & 0x3ffff8))
 
 #define __swp_entry(type, offset) \
 	((swp_entry_t)	{ \
-		((type << 1) | \
-		 ((offset & 0x7ffff0) << 9) | ((offset & 0xf) << 6)) })
+		(((type & 0x1f) << 1) | \
+		 ((offset & 0x3ffff8) << 10) | ((offset & 0x7) << 7)) })
+
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
 
 #endif
-- 
2.39.0
