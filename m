From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:28 -0700
Message-ID: <20230531213032.25338-31-vishal.moola@gmail.com>
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
	List-Owner; bh=0d5wysfOh+GKhBXukukgcSHu1mfqAPLnYwihePaWRqQ=; b=n4f0ccCyLi1ueX
	8I4U6wo9ON7Rg2JnAkl6lbbYCq38FAjS6YYdw1UasorVQfVco6MZMLnXGN6HoTdAFy1RizarhZdxd
	IJV/X5SDW5qZL46q7DJJ2yvIheaghI8jWJznXDZM/WwK7Lprnyu+yrgR+hhfSPvAGfG1MUcrc1OvI
	d0Lg6Bz5gE69bsr993sNYHi14DcfHSaduSHhfOtFI+rAZyy3lynzYkcrQGjGAxQHDDSg5VVIfK4HE
	S35MEXj9Ecq7EfN/dUf/8asNs/kgWI1BXEY55vxTJYL6AT9ojFWR/h3AJ5/ZxJVHxSQX7snIlb4a4
	O90GDzJSVMXT4EqXQPzQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568729; x=1688160729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viYddHqy4Zdgp0J9O3iaWpIktRFOpc+3TNsEHN2SX9A=;
        b=hVqCB7aFrL5Nthi8pAlbjPvcInjFZt1qHkddABmx8gtVThNjktDfpfcNDFDlw5CG2+
         3xRmURAs/k2Nz9kNjLGLhiem3PMoX9/E6HDghH1XQlgENBdym8j3RSqFBZDSSy/b34yh
         AE2QmRwS6oPUlHWjPpeT/6u7AJu6WV2M048WkEp+vu4WP+h6zxRkbzSalddZaQ9VOuvn
         LGPsCzdTJ+5x5K0wsh8kq5o2Vj7pKu44k/mXiACQfaNUMTBzpYonaoHUeQuALtzvZCNz
         9M8tSd6AM43Q88HJNwRerrYrxc+HBnHCgqChwQ1i4KI3ds/XwizMZlg5u8MI061tV0gV
         yEdA==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..5d8577ab1591 100644
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
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.40.1
