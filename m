From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v7 19/31] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:39 -0700
Message-ID: <20230725042051.36691-20-vishal.moola@gmail.com>
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
	List-Owner; bh=cNDF89c4BL5gZUVx/cCndll5G+sKSUct0840p+p19BY=; b=HJHJf+5rs/hZom
	k+WEk8RYJa4RZlLiC/YAPVt7BY3DU33b6b+8RoNulUW/qx2txxF3ncB70qE+lofsuzGfeaGnqlzWH
	aZ2qtPqdqi64ZCVqWScI1IzmkZEWiF8cKF3Eg5oE1sph6g/CLnEVlLN/hr6CG/qxjbd5eN4mYPvII
	EK2pz3S9zgbAdYy76HIaT7kBbCGbgkc6t+j048WwRKFMCk2Z6/2TOPCYEYk63n7FZabAbQLjfaxca
	7kfpN535aU3eBzwQH3y4kRIh8LhovrzkP9jm3aSNlGxfg8kvhAG1w4XMJwzbnFhZapXZ6LQkwxYmS
	9A4dW2HN9k/7FEsneUXA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258908; x=1690863708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=isSLzJlVCcu3DqkromZhEI/qWyA5zzmxG1x9IbP6194I1DKOByM/hDEPdxe0FV3MLw
         d6Rw+lHZ9WlgptdvBWiFzGMaM6KUoRlGp3xu2jda8iMy45KiL59BtGKHYho8dHuVUxG+
         hJLuMObqibUKBJwga6VwRPSAoh79vGoLNGxF2cxBKo1aHJdauK67/yOhDfLuLDKzblyJ
         F0wgtxLKGut1KlZ4xgsSxueuM+T0O4hKbp6cFWk4PiHYX5rGa1VxC3c5t+U93CbfreQA
         BhDLct+PPc5ibyvQ9RmPu/T+BvIQhbpSiLzGAmfokkxsUZTkKg3EAjaoANJECHoNxZLs
         xbZw==
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Guo Ren <guoren@kernel.org>, Mike Rapoport <rppt@kernel.org>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
