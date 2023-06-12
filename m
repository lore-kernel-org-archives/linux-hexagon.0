From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 32/34] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon, 12 Jun 2023 14:04:21 -0700
Message-ID: <20230612210423.18611-33-vishal.moola@gmail.com>
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
	List-Owner; bh=3rClI9xzgfZfMHZeGuYm08IKP9/NtBGenGSOX7Gan/k=; b=IYwQiYAqcDmsTh
	7kcHIftiTKZvg6MXD+Mg292x0TWxpy/e9dlQgYrbNfa7N76Wx1mN2Yq45Jh+ma6fg7/MmAkok3327
	zqIL8+BBZDR3exRlwjN+5q9k41//OCJc7u3hgx4HwJvu+tskzMrDvstXmn/x/fKw16hstBBHgIZrC
	h1dmTeFZarhGjJ7eCQPvUDNvtX+nZBJTU2KJMyHvsX/0IEy2u5QMBbfNOGMOa4bFwO1bukrMzH+gr
	tRdXVgDClJTc01HXRZVH74FNaB8uAesfLGMXO2VzOIvEolD1eAmllNT/TIi9h+iML+3qFHBTSnSgL
	2o4dFFW+llt/hgRK9XKw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603951; x=1689195951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=;
        b=eOGJOp7jJTQ8Qtwco1FoDid2kdNhU5TzJ+8oTbvEbumqL3nQk9f2JlPpUk6+vVBHXw
         bRV5gt25GkskwnqufNjnti+xZOoYZnavni3acnpZrn1jo+MmuLHwqDsH6AdCefai5bKk
         AAXb7bC/rUfzM5Y5JNC2uvXF2EwFePa6CfTpeOCze3Q765zcxWqm7xds3eAw0lRtuTsf
         BcL57/8mkiS9/4+PfEIujQe3OJ/SAHQmhYjUTcU73/gLJF/ExdRrGcc3uAsWdkuXE+Gy
         4wgk7G2Doap3dB0ilCFuRYDRNdtR39NjevfAI+zLdtvH3iP4AClD5Rnj/kfEF228LJIt
         Sr1w==
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

Part of the conversions to replace pgtable pte constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..8393faa3e596 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!pagetable_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		pagetable_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.40.1
