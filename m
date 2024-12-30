Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785AA1A3A80
	for <linux-hexagon@vger.kernel.org>; Mon, 30 Dec 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549836; cv=none; b=S/awJnV2S8nSJWqro8AAFIlJqtskEb2cgzpUnngQgUumXbnKkDr/zdCzRIA91b20ausz9CUMhper3hrAnAH7h/U1pjjwHrexxfD2T9qW/bEFzP4sZOx9QINvietXaxNyLaWfGiMVWFBIferj7B3TfDxroc09uLTMARv2m4npep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549836; c=relaxed/simple;
	bh=w9Tb6kkg2Q49UGEfUZpSUyo28N/wow0+21NvTYUEzY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDHtZ2Q2Yvy7d2nVXxcZr+kXQgwV7o/GytFPPXGhl+FH0tD2Zxde2c7jDAclOL0mLLdRLMqSAtX/87BTLpfKuFCpzrowSy2EYGOd+2kjb+G6WNHdkZtwk5zNVfDhAJNCYxFS8PxlxjP/aBq0SO947prg/6lWd5zW23612JYavfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lpmdJRKR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lpmdJRKR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215770613dbso83815525ad.2
        for <linux-hexagon@vger.kernel.org>; Mon, 30 Dec 2024 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549833; x=1736154633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=lpmdJRKRNSjV6jzealahBTbWBkbRefJLZhZvysU1hXvoXIMV6ujKiH8TOkeJeYR0jn
         vt+weg1F53fTu2H67buFBHFnQ7Aw0sKwfjNfo39vDGDENOhy2pNOeE0MgzO208rDj8GJ
         +vRwboC/mFKKNu4NJWYZ2fbkTzZBY2eFpYPCBuBibvTgMofe/hSMFP3MqeDAGDT20Q5l
         xoKD6EkwtzB2udxGv9zAku3XDiJcK7OXnblIDB39BEFQGdhkvy9p+UYtIwapYnx4ACeL
         0xJ8gtWzRxKDQuJW/wRjeaLkGrtQACzSj0SRSrJiF2Ta24jUIsPARuTNR8mP0s63NmQI
         PGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549833; x=1736154633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=ZaNGxv/sOi6ACFiWQQF3tL4QfWvbkMn7BM3drbFFHSHYqAQXT11NIee8a8Ngwmd+ni
         1CuzX+GwAuLes/dgxEaGUgQPupo/aDfML1ckfQyY62lvspcgUUCGzQLD3PsIN8bySnTj
         WoZomQPPbzB9PSfYQztanidYzUG3YAfTCmMuluWxRoVDMEufT4A9e1rBxWf2kNKBiM9R
         7lq6kwbWU/tDSObotX7qtSYZZ2xOzRLO9sZiePfwroJ3tS9k3k/715zjzkVcBC66kWpO
         mJK209aDrS2TFCyX771VotSukpVCMx3zx+IokLuiBksF4nQecZmYhEnbHWzgz9Z7LgLy
         ZOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfLV1NoUik6ZaWmxsL5w4UjiVd8vb5yIUhB1jqx6PykWhr2xxDRPfy0LVdBQdvQV8lmgOG4meMpzsehFyI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DUON2eioShwWCV7Jmg9dkYJ3OXdhPuvA39v7nO76ujutn2y3
	E1JUvZBGCulDqF/OM/P+Kfmlc8sZdXgXoFWNXfprFP+mtmVfS+QE3zaR4HOh3gg=
X-Gm-Gg: ASbGnct5IqL11dzgnKUUCCZEjHfC+88qKk2xaLg1U/C8NXqvcakti2QGSeBvHj7q4oc
	Djy7NeA5SkmBBEZY0EZzxL5A+q7h/N4xSseh+GDKfXJQFlb/8x9HqXq7u05VzWdQSwtZsKw48L5
	5V9t4Gc0wrlHiNlnTLJb8LNdREvKosN0aV+JckSBlVdIqDESWbV2MNBw4M+fkYjWtcgJI1kTK0V
	E+Ut25kjXGBOlXmy9Cd8sk+KIc0az86KuqBH+/LrjfoBunvbAEE1Ggjtua8Mskk6WZZOhWPtXxP
	mgoXyZfY4qSXkixN6QH1iA==
X-Google-Smtp-Source: AGHT+IGwnjGmNRtsc6wvIZAIM8FV7PRxiURIME1KaVRQ0EplG8wu3sXxm46oGULh37KJjV0x+YOVDQ==
X-Received: by 2002:a05:6a00:2181:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72abdebb85dmr42631070b3a.22.1735549832564;
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 09/15] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:44 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1

