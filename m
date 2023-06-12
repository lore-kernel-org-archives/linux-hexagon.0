From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 28/34] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:17 -0700
Message-ID: <20230612210423.18611-29-vishal.moola@gmail.com>
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
	List-Owner; bh=Z2/cRlr/E3QUsnbU8J7xNVRJOWoROIos2N6JhqQsZSI=; b=zrVooGV7bMn9fc
	iXAiKol5U5pBpkAGe2EFYMbQJb6uaQrN1W0FFEYagFsz9CbU/IJkwjF1H5AwUlRiP3jTmR2HMKmde
	T7/LRkuQ9OVAIdlJmCumfDioMZlMYPVTk2TrSbuIT6oUJrUizqXybz9Puim97w+5FNqb80ztF6RHP
	a/ujqAAdEKXymLYCdqV3SyVVwMRtlodS5H3t4XVBz6PIN4+oevGtfwfTq/1T4PfAki1wPpbYgnqVE
	7I9QxKHyIvj4tetb3r1jdZzR4zA7BYh9eUn1tOP8bGHEtf2WN1qlIz5bskeSU+uvCQWgDRxugCqSp
	h9zlRgwsJ6DFaw6aDbLA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603943; x=1689195943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=iC1t7ghfm9ecJs1x+mmEzeWS2SIjJKEgK7bxy4oucR/f+MfVZU1qsYKmxWlYK3St5v
         mfNdwnEbyVpOCAZkZBQocohQ9uTAKfouC9/50tiV+ofF8yr/r0xQFvh1fNWAqMX4eSyF
         ymqrJp033zjJJcGcMzZXmmZ/yN236luhBhvJ80nOlgUY6UjLfyMIfHGDH4uYCDgG1Yuw
         Qj+o3ciesPmzibkl2iqbskrx7aUBCJV6cn/sc9mp4OIhLm5DRTHYxNGTzKEY2jXsQ3j0
         sN44pjWt5AeKRt8Gf4eHzyt1HMP4kxf4IL2Kuq0LJJYg24qsvy+zvN4scp5/4UYjNDhu
         bvPA==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Jonas Bonn <jonas@southpole.se>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..c6a73772a546 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -66,10 +66,10 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)	\
-do {					\
-	pgtable_pte_page_dtor(pte);	\
-	tlb_remove_page((tlb), (pte));	\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1
