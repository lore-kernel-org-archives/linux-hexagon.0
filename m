From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon,  1 May 2023 12:28:25 -0700
Message-ID: <20230501192829.17086-31-vishal.moola@gmail.com>
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
	List-Owner; bh=Wbb3FZ7V3w7BQasgQYwQCafaTK67GWy3CSrjAAOp4t4=; b=rjVHWACP+BbSUr
	MopJxP4pghd49HNBFN36aT81poKuLI1wqceKaps732ls5mkgVO/plIEoiniLJ+70sC4G3nORpwDUI
	NRNBrVXvLtGndRedR0aSUS9cVcuXzWRxWxU3p/p30MPH5svkMRLQ1yBSJsgsHPHSd43H7u6GnJ/GW
	UEF9enEcc+zPA84T5M6UwEn/Xl95OWwRT7ffhl1zzydAwz0UwwTud2JGwme9dD/6mc0QROLIpri3s
	YG5UFGVdqD5+5kcWzkr2EF84LUr7YEBY7VOa1Am/fRQ3vEKRYQZ/EVF/T514hk5uflASQ2/dP6swi
	R67idzW7FTjjGXNmkYiA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969358; x=1685561358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aCjEZJk/he0B507v8WHbAo+ayyw9u0whNe5hSh1Qc0=;
        b=AK+jJQIndwyipvZ3j74RRrDCnGWb55RfRTFZCAj1QjfEP6JtcEnkxab8VHfUxlnJqD
         nzyDIYAX6jvOrQqc9g/TswPCkcqNA0B0b+SVKLMEmNApHkelPozzZarkoTrP2UobldQU
         E6NqDV1CfueV3wQaPICMNftiMflroUHircwtbGv3hyeRwqO/KqZCxi3BNAP0dk8lYID7
         5OwqBACQpi+nvrf0goZMdOfhVuRwRiXsUHvkFH+vRl0eIOaoeix6IqEc2ZJsYZWlONhr
         qoO4S8rXijotpMJHxa1FWYbjKdY7R5WGEGDzLNmBq3rOIwjAHcvHuIBKVpOdfgv+tSJ1
         RDOQ==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..ce2ba99dbd84 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
@@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.39.2
