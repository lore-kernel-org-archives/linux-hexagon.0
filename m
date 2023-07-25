From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v7 24/31] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:44 -0700
Message-ID: <20230725042051.36691-25-vishal.moola@gmail.com>
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
	List-Owner; bh=7AgLdRWD1d13Q0eXjRsrFhxvtpNJkvmTJkmIWQTWFkw=; b=vngBlOBLqopVpw
	LY6bTrZSnwuTyvXrQugNPOcucFCAwMaq4x0vpVu+wRn5NvEXzpn8paD/aZYlYetTChLUcPJ2rob+R
	T8VZJYiPnjXwbFmUV2He9UxIgpOx0JW70lAUNc/E6iIkKxNFuY+LsjVKijNwWxfGVOPd4xUzU6FK9
	rFCxSSTfDdnC37ziLxdGlKuxvyBxmxJF9uXMIvgwAWmCSAEEH79GJPOUChG1/TUJINlK4s5GSdk8i
	tmyABlaoo6AqnvFpFeuNiPXaNq1cYJNRod8+aqCVXauBz/AO1vqDgdS3HYmaV3QD51IFzMRvR1I6S
	kwNB0E/J2SxwOt8Kzepg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258918; x=1690863718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=dhPD8MhdzMmnO7UJpDnYU2UUndnCrctJzCVX4h8RxV/2AqAGAmNSSgBAimCgoOXbFI
         jwqB3InLHcwQnBW7LGy3zNpfxtaFx0sRNMrc2BW/oP9Y9sT30Imc49n106obHaMafKD9
         3iENsXyRilYTy2IVeIDj7UinpA3gJg4m95b/YmknsgUr223VL5cVJ4//6IC3DQ94xugG
         7BqjgjAuhv+rjaUhUgEIiEByqDs5npSuOOnKXGMd/lRwDVio+iIe4ROtQu1UVk7GVi+q
         O8m155eNSAMp9dX3vcmdIfcwnE6nUvi43OowEy4OezSv6ZkWZbIGQtYJYSHuCGDVV+u2
         iZCA==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Mike Rapoport <rppt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
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
