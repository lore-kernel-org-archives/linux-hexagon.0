From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 31/34] sparc64: Convert various functions to use ptdescs
Date: Mon, 12 Jun 2023 14:04:20 -0700
Message-ID: <20230612210423.18611-32-vishal.moola@gmail.com>
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
	List-Owner; bh=4eVfCiv7dbpOE1wa4QSy9IwM5Bbmdl3/KvdZv/kuuhU=; b=ubbeEJVCun6IXk
	KtDv29OZBJVPDo8DlV/59DntqeKBBsWuV+P4jslXAiSnhbYEGX1P5kRVUFFzM1mxQ3M2VYAGt6T3X
	YtOll6dH6Fc68v8Wa3v/eNNXWNsj9Hlg4w52qEBD864e/NqBWmVq2nEX/mbhJCJ7mOD8rCB9FXziv
	Hg5zfZYQZXywjsNNEKBHakMFfKNdJhR0ThdiMhhRE8tV66T6HjmnUU+DBUsj39JvfT+OcFR39qaU7
	UfUNwHYFKhc4TOLQfxpjkqpA+AWcSBzgYHHujYsghO/JaGxpSHq5g39xMMX8OTX240dfzb3XgwplA
	gnHCZugG39HSsuQ3Wuxg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603949; x=1689195949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6EpXhLB/ZnHGYzIKEyphwqiyS9zUDTms38NuP0TFmY=;
        b=HZjqN37hCOK48cvGmZP3MyXHPsSWerODKITkESa+8okEvm66QeHMRWeJrMA+h9zAy/
         b08e3G4t5lsUUKbLUtaHE2GPHfm2Y6f2xgW3YiErhjVlP8jaPnDQQDBBPDgWToXRn7mW
         PpzBiVyA5JSxI70xxYGR2PwmojuW4ejIHH6298KzStJQkqMFOYKQH99Y1J/uWKo9ZDSM
         eRMw42CLQFJ3ndhOIFwgLE2rhtWcbpTrYEwDV/LXUoaY8xrQBL0kpr9KnDHMQo57XMNA
         dJaliHJT5dELYDcW6j8kH/iUc98Tn/GD3Nr/eiXjSdRocwfmdaU0ArfMHM4wLvGwtdMu
         leiQ==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, "David S. Miller" <davem@davemloft.net>

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..105915cd2eee 100644
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
