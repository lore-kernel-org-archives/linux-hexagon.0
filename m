From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v6 27/33] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:25 -0700
Message-ID: <20230627031431.29653-28-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
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
	List-Owner; bh=AYxzXm28OJmwyp09IwpYTq/XZSrBn1d+DJFpnufDw4I=; b=A70ESTihRA37xx
	I1JPeDa3OW8kuexqZoBsbYBHl6V6BBccqLxaSDMFYeAaM0ao80OVZyXdXvTFNncE0EEBmqJ3UVXUm
	WsJWULm9qHg90j2nW+T2tnKXo6mvYoG2XXVzUQAjhJ5DaZZiynTlgbcPfxRtIJ/srE57Cx0KeXIt9
	/WPjhUit4tDzl4Mh0bLnIxbmEWetJz9BJ6E/d+hwj3DPsL89och6azVOQCqlVC46EHwV4uIpMrt56
	iR9kNVhHSngmB/olDV1RC5whFo3dp1ciHtSoSzB7L1IseIG23rZB7LOSMWc0D+STSwQqvX62ZyW+Y
	Baj2QYz43G+HHsymlxtA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835765; x=1690427765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=e60Y6sevaT4oQ/L5KuHLcNtraCcaqymJSw0Pta6sshcpf6ZZ6QManSmR0ZQpDOB1TG
         Zv6Fux3N6RAGTYaqlaV6L/vXV7y5TNrp+A8hP8/1TroaBlBjnjU2829v3J+cnc+AhOb5
         JN+Np+61YaCNuusYO6cIWgMGGdhyo7H5wD/egNG2vy+zzD2dD0OPETzsjKXbKfq9Y/2e
         UqWfUGJ07+JZFMPC47CCL6nCuIIVod63+MvhTRgj6G4ml0xqLiHcn4xnMK5EG5kSpCpR
         IaKEXBQ7G4bgWt8P3QrMWU+dPATv19IcGEhHsTfe2EI7sEKEiwRzexwBCQnzrxDWjBM/
         K5Og==
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
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
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Mike Rapoport <rppt@kernel.org>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
