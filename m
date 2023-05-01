From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon,  1 May 2023 12:28:22 -0700
Message-ID: <20230501192829.17086-28-vishal.moola@gmail.com>
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
	List-Owner; bh=HR/haTJLSXRZemE5O2pV1loGmM1+ddrHSLyIVrlglo8=; b=nu1o5AuRlc37SZ
	gKvx0FCCE7RtGNUp8wywlSzNAIiDHHV55sdSLKUMoG9jrlwjJF9HR8HMNmouC62pVGE/s0Vs8c0m1
	Kd2/Z39psGLJqVAPQVKr1NHb9hl17340n+qZNfJ4/xRSiJlLLJOsLe1OGSl5863tord3Ow2f3lyJl
	LsppN6lJ/qHUO5TJrxHebZLHy9YnLZ+eU6MPgMh6wSamH5yK48ZLu/E2UuoinubpMPlbvQzn2TTsC
	jVkpr0kkZDMyo/jCT3zviayCjm8Bbm36mPE5zcXEoCyR2soZj5gwR+PHfR3Z0OMP1C7KISww1eyN3
	YicJs8zxIij+zEXo8dqw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969354; x=1685561354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=;
        b=sCYdFD4O8Had2jReQPDULWIb6jXMWTBVOP1xIsSQDJFrjK4Unzq4xPir2vv9xD60ba
         KhnmERHxh4wjne9PTfzHFe7mUKtGQVGSRxsSTI7oGHQc7fKexIRwy4BhAuhQWGLGw+L4
         jhaBOvefDEjvTltxe1zcg9AOJCenWnwtbQvW8h9UKrmrEmLrYzROLydP0XMIyNyplCDF
         ksvZ9Q2L1rfMSznCSwk+WHikKvzxa7zVAjndA+MUieyvTGKh0Hnkx2VWar6ZLI/SEpj3
         zJ2Emm1btVtqn0B7TpGayRWt9h4mLeUHtWruxn5Hxr1lyas/Ibpq/YOzX0vO1bUnoNNT
         ju/g==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ed868f4c0ca9 100644
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
+		ptdesc_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.39.2
