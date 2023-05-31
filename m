From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 31/34] sparc64: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:29 -0700
Message-ID: <20230531213032.25338-32-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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
	List-Owner; bh=zx3Xw9WrUY+4jgLmdIeICesP3gpnwb1+nJeRhRCtruo=; b=tsA5fnzwFrTke1
	oN/5Gs4xunqfIdH20zp1lLOMQVtKhPJeuDeOwcrgQPBthP9lELgzQyO+rNkJlSpSakIWilvsndr/Y
	2YsKbqE6jXy81XZ0eKKyg7in1gO2Cm7y+aZFAMPFkC/2nGiYz3MAWQPF74FpwuEUi5n+LW5yU2qz9
	n44RdykgTjubOYoyp1i2JahXm1Qa0tizRWJ0mV5UgifIO2gFCVnT2Iqk3HdpKAw1wgtS7ILdINoi1
	OLKqA7KfOuvQyfsL2uEaglDa2/k7vZdpTTeyaD6MGTV0X2l8v7doJKlj1SxXlwoWz+hmrat9jf7dV
	BeCXi3mhqkbWnMK4B0hg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568731; x=1688160731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GRmBDGAiDB5ohg5xpMsC/Ie0xVPC3qwwrjfZtpy6VU=;
        b=TzIQcYP8UmEvu1XoUXTmQnAashbo2T6eYaCRckVyeMmLMro7gHhzasHCkMcWFCcICP
         qASPopGO4jPsUUoq2oo54YJvtjYAvzC57SSS0Yqri4mv3NjvTdLMSdkLvvM7oA4Ee24y
         wtM1hRp99610fYgP6iNO/jZdKl6qkgz0kh/qsgBmVzQ/w0d6rCW5SOQFK0BhVT7CHUOG
         qPxfe0g3o4O3N6ywZpv0i38BDLHQS9YQOgCA2owyv5y3xv1tuRhfQmBHrNK0am7f5K2A
         BF7Ua5SoJjDL0sDtWpclX2w1tSSbohGXIW608mTIM4bjGCvoZIGoxKxNqCAe4MAT2CZW
         ovbw==
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, "David S. Miller" <davem@davemloft.net>

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..8a1618c3b435 100644
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
+	return (pte_t *) ptdesc_address(ptdesc);
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
