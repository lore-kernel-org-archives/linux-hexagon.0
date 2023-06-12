From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:16 -0700
Message-ID: <20230612210423.18611-28-vishal.moola@gmail.com>
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
	List-Owner; bh=nsEQXfqRwlYiPJCf47zoVRTHUhD0v0ifml+EGyry56g=; b=YeRiFeeQ/OgfDk
	nc2U4WJGoKGDCQNokZA/gfOGAZV2g6KSQDJWqHVDhvAR/AaGVwcQMCWyN18tLlq9meMZ9/LG7iPGy
	QiH975jNdsJmFQGVK0sgOa0FOfsWEWwVESpTyYtcG2hG+B9MEHyMHgS4Ra38pZtTeKeRnXG5sJPoe
	HX88nHFum940LDBwybrlpRxH3I943IQc8K3A8hM+AYsxKneEclI84BKj7ZLQ+6gRSIUOK9VmF4qad
	MW/kP5lczvh6SgvWyxff0I+uXZXFeMT+cqRWAKC8FIqD5nQbWuWBotD0477ULl0grXECrCNQMmFc1
	Mg5xNViLz9LzVrPE4jKQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=; b=J/c80SSC1VBC/Qn56fyOzZAnV9
	UEUpd5Et1oHaAPRYcUxLrbX1+rVMQUkRtP9voFJWE4jtEjHED3gVtVCDkQsOqJRibf4MUYg57nBwU
	mDwKUUmjD9k5YGskYJMoDRVohwAN3x70oOc8EXvu371mZnLd7eJu1wuNC9/aOPcVmXoobZOrRPl/u
	z+og7U0c7r1yCuxuOrePeKGuifJwNNlMrKDYIBDPX6oH60hmGjse1Uv+O1KPLmFxcJkjsjIDF+85K
	1Pg3sBlcYXLcmgbTm5pqD0JdiH/gItSKZc7XnUoN264/c3zCD+qsl05LAQt8aIt/kAMLQi1sYk8zD
	HI0MqJEA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603941; x=1689195941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=;
        b=qp0OZHJwYJBDFbnZ3ou1P2Ehue21X+g8zcdgyQxIvQy+nDe0qfAi0dHJH17SnCCz1g
         tKKUvfmw/BkCu2VWGVC9FTcKBTfgeit8iCuiiB2iFwBx6PIhFHMGEsTNb4ySvFT/d3ft
         wztSHCS6L0P5NyGlzSq35fcEZtgvv+BauybZ4ibvcrCUVHnGp/kHvLFHDT0vMZoFlpUX
         ovC+Ec8QSOvfx2fBvS9GXwZis3S10LP+c5zNsCcscOq3kZyLxngh/87tdHFT9B3GKdNj
         CWUudKrbpvmp3qcd3NPPZgIOvQGRSzySt8ja54VpNcHj9wUPZRrXlqZutJQePE3+1Opa
         Ut9Q==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1
