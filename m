From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:19 -0700
Message-ID: <20230612210423.18611-31-vishal.moola@gmail.com>
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
	List-Owner; bh=dTuRzYvln8WGEMK5nE3R2wNnv7hTvfh4aVU5L1q1WyI=; b=ohlpUgvuB8MCy4
	E/kR+IrGQzRh3Mcub+6PMEZW7acHK0ZMql27X2fyjbQKMqk9jxTijfkCok+qq1+X5+1Y62Qupwco7
	xVk0v5aI1a550VdXa2N7EZZYJNvHvSkaguZCmYP/FllP4meuxsHmOVBEERXhmlhU1mSKffIMEQnlY
	e6PJkwwZN8FoQYYdxSZRD67vHnKKa32oRTrOL9TNxxEqecB7C4rhVbxX4VNkVM8riRFgt456eQHGx
	rCTYVAqnds1cFyN+tLjrLEOZzlvzSj/7KmFdS3db+YP/yuatgVhYLEbJhXoC7rdx71OFF2w31040C
	Wg7bjSERieeNH/7yhzDQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603947; x=1689195947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSn6cSkj4IeRf8/BsqHClLl3fDsZeC4rpAPYblqUB6Q=;
        b=ciZzI2nnG7zqntS0kYws3Bstzr3nXcXM7AVbRLfJcQTue8B9i+jyLvzKLDy2A9P30Z
         c8kXhocxLYHnQ/QqwZQBscO/Jnyd5DcosG/E4dwS3uAecJsY0Ja9Z3xqw7MsgC6nHjA4
         QA0ciLqLZYMqWOytaJmxjnukXuzthDnZTPicAtRgEtVTuV0GYf1zJiBPTow39XMnG090
         B3bVtajux9wQLuem4VZP38wdaF1Bx4OpAJ5RgPldzLuFMNXFpzdfCqZWClGqvnQMYt00
         /HHhjhqAxABJiO4Fj5XqD6Wx6l8ZOt09hebTgkaibUDXMgVCd7dGCAjsjguwOTWs8p4I
         GZ1Q==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert+renesas@glider.be>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
