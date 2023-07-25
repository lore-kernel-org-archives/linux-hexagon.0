From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v7 28/31] sparc64: Convert various functions to use ptdescs
Date: Mon, 24 Jul 2023 21:20:48 -0700
Message-ID: <20230725042051.36691-29-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
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
	List-Owner; bh=GRxlbRpeEdVxVUvESOew0TFMNyKMxIQyMiLDiv2JSwE=; b=SDzFAuqSI6X42O
	BqJZBlVoFHucr+3TJxJA3fsLCWvMtzBtW40nOWdvTKFTUfvXmchTxhuprEGsOG0ScxQOT6D4GcorQ
	qZTHM5Zs9Rl4USd41CFTY4Zbct7Sy6DZai84j1E211mXBxA+UnRgDtT1xOqtUzIDv9kWFYEV6Oy6O
	pCDY9/or94GJE5mFaEaCxznf+R+fOOwtcMD7F4wjEIP+BsE69tt3bryZUYdB27wrpRbBM5goPgvZc
	wiiOjZgS487DSW4YXHxeYNn7tWdAjXLGZQ3znJT4RPMCV6KZs++s6N0t76U0WVBLU5eFcmzJlW363
	hZV8wzsWiNFQ+bfl8ekg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258926; x=1690863726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9EaWELDe99nUon5K3Z+iJo2yPeaFSzyCnD+eyoagSI=;
        b=qNSUsqiVKVB0ESH5eMh2318rltbeTzVNrLxONrPQx/nleyciLPoBJAEyvEQiA5s1Tn
         685R6sAh2RRkBOJ+dHhwwHaTsDfn1Dq0fhp7maY379FRtPvlZFAioZBWPPk7fa1Wkq01
         qN75vY9UJqWiLkOixY4L6XdTPAaqKlrcR9SWRLlUZxoXjG975sFhxm21WZutHmQKl3h2
         OQ9WcHoISTJ2OjIGWYQNx9W6xFSNLrPRAFCGXfmCK8TcPNzYvmKngSTkC45cBTIzIEjY
         73sY0YERl7Ohg+xplAh/xTNZowvdAeC+fipfIzPvDIC0nmap4j6fccJNDYEXWoxWM6gV
         WCvA==
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, "David S. Miller" <davem@davemloft.net>, Mike Rapoport <rppt@kernel.org>

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0d7fd793924c..9a63a3e08e40 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.40.1
