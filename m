From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 32/34] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon,  1 May 2023 12:28:27 -0700
Message-ID: <20230501192829.17086-33-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
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
	List-Owner; bh=4I2aSDHkSVG3Z2p1QiA6PhDolYEqaoYepGd/jcoXqSc=; b=T277iLjUjOtamm
	RFiEnZ7XZ1SoNd5rng0iJ8ehOE/NWg3ag4+6EcMCXwXORyXc6IqRzreXtXbd1OqkizCPqvWu1rmNw
	/STDSmt/XTqDMUKOtMrhlGRFI+Xj03cj5XBVmCIITBkuEyKZN+KvUy+7xGCUCCHw9A3syXEo8PRCI
	MGuA/vb7Zm+RqtN2WWGA/vC+FQASQI18inIdSv5PaDDmYnC/sS3sqf6ZJmrorgTjTcnF7tzgdmj6I
	RPE/q8MXcc1V+1JnfoO9igR6cYlo8s/Gn+rOMRacEek/e92Mw7rbMExQc8o8DwvcT58ts2YIAMtcW
	XlFH3VMiEQL0FpE7UlbA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969361; x=1685561361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=;
        b=YCg1YMo/xitXPr8EH+7i7/M0wYddD4PRgw+Xim9LG20m92WUdC9kOQT3fMeSkFJ8bz
         2xW9Qv874by/73QMdHiVk+wqz4B7HUYL6Uj2zbe5cOYZkoH3JAXPoFdQlYFWToTwzHn7
         dFfF9W+SZdFlY3dKNimMml0EcpIP5K8qP91gmqtjuJ3sBzpu94RZheVZlyc0ZtXP5Kh9
         Ho0HyuApLfDJnfV0KIWHGVL4xeGycAgKdLMplPIR2oWrmLtc//uxDTAq/yAuqmVSMzMJ
         fvK8MGrkhlBYA+kuhjIoxK7FCwuGLTfgfMGFdrbgTVFBoKNwWCi+6p4VuuSzDnIOEdqU
         o3Sw==
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable pte constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..964938aa7b88 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!ptdesc_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		ptdesc_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.39.2
