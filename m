From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:20 -0700
Message-ID: <20230531213032.25338-23-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568713; x=1688160713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twP3X2a+WodLh3389MnIMBhN0jbH10mGEhh4PvePsM0=;
        b=PfN/YuXqEhOYfWlhCizTVYhB0yTtEnGBcp1Rf+NGxnIYb5NMfNjpOJp7si8Gqd9u2Z
         fVUf7A/NR+jmOjDUmFOcEU9lVtXwdNmW/KajF2dl5HDRHfmf/W944R+zyeedwYfvy537
         14PZNj7A3uugHcuLzifkUVqBMDywmdqymi8GehMXhWnbSeCktA8GuayP2Gw4BIeku+KV
         EWgr5cqL7Y75WorTm+eBQ331vxvi6DIr56AVXpyFUK5xmnNLyeer0KWpXh+3ggToS823
         Egfk0bra3X4pY1o6khSRW89GKMQyeeVJx3oX9CNStxK0FHLZpfrALdAzG2hgMTcdbX0M
         +9og==
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..9c84c9012e53 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.40.1

