Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC44211460
	for <linux-hexagon@vger.kernel.org>; Thu, 23 Jan 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638932; cv=none; b=ZBBVnTACVlnB6VYeEQ5n1fnXkf3K6EEAuUMKef0qChFLSmSnkktT+5mD4BXSyWeJ99PD5i/sSvZvVhkICak82gE2kbt9nc8FlcVd1Eylp4e4ZLsKIi5g7SmfbWAuSYJNgIZEzgxoG3V9ig1Z8W4L7nv+LehFZ0fk0h1Qk5GlU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638932; c=relaxed/simple;
	bh=9R+hVIAoZGq7muh+MjTEAY3Ux6O+nL5GCUlW0n8y7ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdKbsdGoUZedzBziJm3LoR7fkc4IW/37YkJuhNj5cWrBlBKzdZsPygKXdXjbqnDykbBTq84OmJJ+MKvjKEoAR/V+a3dBbIH5vLIUKVSggW0TPZXjhz2E67yZkZBmlWKF/tlTyrlQrCeM8+mYfnbnaPoYuTkwQG/0uC2fuEX2CnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ce3VjbIZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ce3VjbIZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2162c0f6a39so38993445ad.0
        for <linux-hexagon@vger.kernel.org>; Thu, 23 Jan 2025 05:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638929; x=1738243729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIKiL/cvy76O78IwclMxfA3FUb4EAj4nzgq2isZtk2Q=;
        b=ce3VjbIZd+oz5uvh5UAHxpNNSQoC2Vy7XUHuXxSU10OE+YnQunnntolwruH20HqUS/
         lrhtN87EA2JgnXgDe3UWXVuzgKbmZNvTfozBF96h7xUXO67HblWunt4fA/zrIlj6ZFO1
         PuabBN0UoK5a4ihzlrazfiaHdHsnghyP+ISFMaJc8V3n5Nan0C4UNB7iu4yj0H6CBa7A
         mNIQ7HhVdlJcZTuzaQ1DZYYHaB3HRrxMkxOTHLMiCQAXErcKOHtxcIYpjWUKJGBCH1Hg
         RjU0Wtl9ULTEtM+L7pXOyJ0rGpBOFHlPVUrnZlHUgi2Bh6McL33VmafNmS9SLyh7eFGm
         RJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638929; x=1738243729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIKiL/cvy76O78IwclMxfA3FUb4EAj4nzgq2isZtk2Q=;
        b=Kcdc+ZR4MMwIYR+niTsLuILpU/4/FTvMHQJlagfv5e9ejoI2zjP2D/LIm8UUYMX5T5
         5bK5ux+T+Ui3p8VNOVGGn4zB+iNdmMZHOEgJDgAeoB2gNBQoHt2zn2roT+6zkvbmnn3L
         4+C8US032jxh4DqqLLA5z9cr//HqlcySIs9Rm1Dgrl0C8m8PkN8RGCHwiudBG/ro2Bk7
         m1xzZ3yO4bnUxQZ/EzZTcp6Zu3iKb+Xqxqll+cY5KW8b2/V8RQklXCVIWpaHjYesThi0
         Nru8ds3yQihZ1ELy9/9+Q9l1znPjjR5p5DIAcn3FRYuR194t+3bgZ25t7AggxiqkhsHs
         iWKg==
X-Forwarded-Encrypted: i=1; AJvYcCWgRTq0waZjVb4XA69JHH4b5Ptz3fLtEgujQBITyCCUQV1BS6iFzFvBabbm8xK20qCNck3ZjAwEKjl7SfEm@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFOsBqZ/V9V8kxxEZYVq9RBr8TNKMLeh4whPLIEO8Jtg4KYv5
	L5IkHGqkQx2pgRsBwD7tuFxWlT2kNeBSGS8Rah4QKinUTJjSXk6SUHlNl/yiFcs=
X-Gm-Gg: ASbGncsDLqiORWaBKZTlftC3EzSbEtjqUOJ9Y4ordxC2rlYmEGPkhO/E9oXirO5sxbU
	i1gJoLQe1w3Ru9kTZxKsIeOIqy/GGWc6QsTewP9BzRRyJriVr/KdIAx16UfQqaqdjYu5P3yRJYl
	2Zbt40yktZOYc/TS2wb5ua0yz3FFx03tl5SqMFi30aUkyizILkDQF9KtLTFJUBrLEA5Ck5sxoBC
	XgNs1ghjYmWrdXqXbqxqRCeLBfyoUAdnhDicepHmmKasMWBp3oOo+AN/EqeK2Zswp/APvPFwuPR
	iLiX2SUI83UxTGhVo2F68PhAhwjlSUpMuzzwucy+W9Rb
X-Google-Smtp-Source: AGHT+IEu4HBG3SpWH9djQXZ235PefY3+YNVKU7kJShvdW8r3VF7F38seuaHQ6/TN21qUw52tcuL1Ag==
X-Received: by 2002:a17:902:f541:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21d993172e2mr55309915ad.1.1737638928616;
        Thu, 23 Jan 2025 05:28:48 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:28:47 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/5] riscv: pgtable: unconditionally use tlb_remove_ptdesc()
Date: Thu, 23 Jan 2025 21:26:16 +0800
Message-Id: <86e9fbf586912f3689e98c4dee2180b69b399638.1737637631.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support fast gup, the commit 69be3fb111e7 ("riscv: enable
MMU_GATHER_RCU_TABLE_FREE for SMP && MMU") did the following:

1) use tlb_remove_page_ptdesc() for those platforms which use IPI to
   perform TLB shootdown

2) use tlb_remove_ptdesc() for those platforms which use SBI to perform
   TLB shootdown

The tlb_remove_page_ptdesc() is the wrapper of the tlb_remove_page(). By
design, the tlb_remove_page() should be used to remove a normal page from
a page table entry, and should not be used for page table pages.

The tlb_remove_ptdesc() is the wrapper of the tlb_remove_table(), which is
designed specifically for freeing page table pages. If the
CONFIG_MMU_GATHER_TABLE_FREE is enabled, the tlb_remove_table() will use
semi RCU to free page table pages, that is:

 - batch table freeing: asynchronous free by RCU
 - single table freeing: IPI + synchronous free

If the CONFIG_MMU_GATHER_TABLE_FREE is disabled, the tlb_remove_table()
will fall back to pagetable_dtor() + tlb_remove_page().

For case 1), since we need to perform TLB shootdown before freeing the
page table page, the local_irq_save() in fast gup can block the freeing
and protect the fast gup page walker. Therefore we can ensure safety by
just using tlb_remove_page_ptdesc(). In addition, we can also the
tlb_remove_ptdesc()/tlb_remove_table() to achieve it, and it doesn't
matter whether CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected. And in
theory, the performance of freeing pages asynchronously via RCU will not
be lower than synchronous free.

For case 2), since local_irq_save() only disable S-privilege IPI irq but
not M-privilege's, which is used by the SBI implementation to perform TLB
shootdown, so we must select CONFIG_MMU_GATHER_RCU_TABLE_FREE and use
tlb_remove_ptdesc() to ensure safety. The riscv selects this config for
SMP && MMU, the CONFIG_RISCV_SBI is dependent on MMU. Therefore, only the
UP system may have the situation where CONFIG_MMU_GATHER_RCU_TABLE_FREE is
disabled but CONFIG_RISCV_SBI is enabled. But there is no freeing vs fast
gup race in the UP system.

So, in summary, we can use tlb_remove_ptdesc() to support fast gup in all
cases, and this interface is specifically designed for page table pages.
So let's use it unconditionally.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/riscv/include/asm/pgalloc.h | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 3e2aebea6312d..770ce18a7328b 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -15,24 +15,6 @@
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
-/*
- * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
- * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
- * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
- * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
- * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
- * for more details.
- */
-static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
-{
-	if (riscv_use_sbi_for_rfence()) {
-		tlb_remove_ptdesc(tlb, pt);
-	} else {
-		pagetable_dtor(pt);
-		tlb_remove_page_ptdesc(tlb, pt);
-	}
-}
-
 static inline void pmd_populate_kernel(struct mm_struct *mm,
 	pmd_t *pmd, pte_t *pte)
 {
@@ -108,14 +90,14 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				  unsigned long addr)
 {
 	if (pgtable_l4_enabled)
-		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
+		tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
 	if (pgtable_l5_enabled)
-		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+		tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
@@ -143,7 +125,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				  unsigned long addr)
 {
-	riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 #endif /* __PAGETABLE_PMD_FOLDED */
@@ -151,7 +133,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	riscv_tlb_remove_ptdesc(tlb, page_ptdesc(pte));
+	tlb_remove_ptdesc(tlb, page_ptdesc(pte));
 }
 #endif /* CONFIG_MMU */
 
-- 
2.20.1

