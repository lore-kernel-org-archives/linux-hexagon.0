From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 28/34] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:26 -0700
Message-ID: <20230531213032.25338-29-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wmZx5lkZgWG9LYOkMKxjydwD4uNitHcOHc3oJmIC/4w=; b=j8PfqFlJcgpXc6
	aKaCxdQBfkH8EAE00TrKbq37bB5grpkAL2NxDgpqpyDDqF+FJPRo39Bm/v+hznS2AyiMl5C38vbbb
	dUH8NMPXiOlHtgAMl4E1NE1d5KPNbPY1pwKP0LIZTR2ISZreUBN9N/bevfFrwGVwR4kC3PXd9nndc
	yRz/cUX9KDy8WbFr3KwReozW6VuR53OFg6mzRnYZjF9RLefflERYBXFqLDc08Zds5JiGH9I8+MY6S
	+6IOWuDfTtAcPV65lOz28v6BAUG1XJQOsNbYaxpbbHymEqhXToxeyUmio0M3aBVDMqKAEhZ0eLkmF
	43Ix2hJMJwbCkFKavvlQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568725; x=1688160725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=R4JOyFF5oGis8NxGU8pSpePc9JPXMsijgUHIihoBFDMX7vxfyfSgK9gS7L9vsvgMnj
         MoFYSUO2hucvt6EXtvpP7cclM0FlcdhnlFMXLdspy+TrRtUW4byNtMBbPaBMOtheTLzo
         JyXpw6dclXVn5TBmIUwO4ll+Dwj2sxioBm1tcLfW7tR6/lFa3tmkjwZ+b2UxBU9kd/xU
         9674/17mKjyw9zKVkY7JTqJdm8j6Ukk6MApKOQVf0MMoClbBMESl6AhiCYUKK1tGclZh
         a/IF0OWr+we0YPVHDLrOdoGrQ5ob2G14WJkmdrRtqm2pP0cB8C0ATsRWLlC+f5L22Z3U
         c7HQ==
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Jonas Bonn <jonas@southpole.se>

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
