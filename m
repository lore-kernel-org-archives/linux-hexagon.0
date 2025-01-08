Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA61AA782
	for <linux-hexagon@vger.kernel.org>; Wed,  8 Jan 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319624; cv=none; b=UyUtevADFBbwfS+W8Aj2iSudtKNON6jCJc4G3hCcUFwsYjWwG0TMId9orNL3KSNALC36t0rIbCQViwLJV/18BztQ9Bvb3FMh01ntkMGI8qzmlLtivbK4mZcgZk6Zo1/hwUW/kS1MfM29wikHe3PvybQAkJz5YfWx/nLtSWqWMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319624; c=relaxed/simple;
	bh=e3kN1Di5Fcouv11d71USulaPcPOxTFiQrC41b2k4smg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLjgXgZrWNOOnaqiGVCCc5GSQm/EWxkiVHofrwptdPD1BNHODzDLEgNxGwxPjyITuQ4J5188GgP9XoDyWiugOi6ZmxlJ0NgxBWf1DeZlSSXE7LJfEUbQSTGUVjpk2antDs8xonctQ7YYgIG2KplJoAUjVR7j3+vHE2lW4YjHckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OPgXEBib; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OPgXEBib"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21680814d42so205539975ad.2
        for <linux-hexagon@vger.kernel.org>; Tue, 07 Jan 2025 23:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319619; x=1736924419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cYfjcYM2i48jLO7NuvQJ4j04U6+7fBnrQjgIuvbLyg=;
        b=OPgXEBibu+bf+w1PQZU9CTvwiiDqbXH7bCsUbtvMlw8zPtCkSIFAawjvdGCb3QQKsM
         hkvF6T2/WWT5g24HcpHc5p3yvkjLwm/I30ck06Tv4B62TE5pF4epBrGbri+tK3FcY+lh
         v6odZaUX7Y2QYRCvoMnlF0mRc5N9lCL1OcP6XV6s4Hs+VhuA826McnUM7itxM7t7UFOM
         feTXCHOMCPKYF8zu+jnNZfc5nFmqa7pmOxItgYsleNvcSTb7gcDURL8jVIf6y0stT42U
         lL8rOatEdBu0B1rHQM3Fv6LaiFkrV2W1q0xfpwozSY4R+FrCMte28/DCD/DkYZWjEsfX
         +tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319620; x=1736924420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cYfjcYM2i48jLO7NuvQJ4j04U6+7fBnrQjgIuvbLyg=;
        b=hSrRbBCGGxgSq6jDLAl2kXemSV8GXlNqsObtT3zrpTo/QeBNExuKVFmUaZeb+hlSaD
         YYS1ql7cZiTYllQ57xQoZBBa4sX0lPz6QV40u9Zr+uGA3iMcIzdof8z/ucPaSrP57RHJ
         KZR21RogiiTK9CzTDaIg1Swf2o7vfLxAMOL7tAyXnK2RQS12kTib5jYDMLZAdp73jwoy
         yUcDw3m8gLQnLyUsnlqttxNq2WFsfnH67iW4Arvnq1LXhRnIw+18/vBEZJVpWzNQJn3+
         VRIap8pTXqCnpSEvM/pol8a8bQSef3xshM2bHj5tEva5IRbjK23LfWg/un2z2ibvz8It
         dkDw==
X-Forwarded-Encrypted: i=1; AJvYcCVhtav02lElKAu/d3UQ/BbUTKUVVEfhAUznGfvefOerVPvvYpJEOMs5sA/8SC1xXabAWZbI0mq01suiODZc@vger.kernel.org
X-Gm-Message-State: AOJu0YylBReR9C83gNRL9NCbJTra3FOlKHzJiMRVvkNZIgnqaLasgGsx
	iorkGJAbNJZmlCw9sMr9bDzo+A6uc7AgD1lvfgE/arAMOTbIlmRebb/xoeYaTas=
X-Gm-Gg: ASbGnctxXw0oShfGdR+/dq+1SWAPvZR3lKnheyWEQJyUq/nuomfhc1K81iww0p6T5jk
	R8HjYfdNLVB7fdzv+7iq9+s+9hBQ/XNu1a+2T7YRtiJeXZzQPSsQ33VAVnrWIIkiXIfOdegE+EB
	iWV9DfweBP0iuNDt9ZeMYvnb7XOZkvxGa4yvrG3v9hvKwgqUaBgSRPfVXue9lcT7mAzyReX3CAV
	weEB0TXzmlPpbJou1+ALWVd5hwVSTYdU8thf2nfI8Px7jNmxw69vOk2kSfMJKuZ1B01O23+UiE5
	i855j0Odh95PsswYF9M/iZBcUN8=
X-Google-Smtp-Source: AGHT+IExFPt1bVFS1B+HfK/rni8xCakw0mpYmNpiHCGWtvviMVtfvk5MaDovSIdy5xSOdSeWSopXEQ==
X-Received: by 2002:a17:903:2311:b0:210:fce4:11ec with SMTP id d9443c01a7336-21a83f42687mr30246255ad.1.1736319619595;
        Tue, 07 Jan 2025 23:00:19 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:19 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
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
Subject: [PATCH v5 04/17] mm: pgtable: add statistics for P4D level page table
Date: Wed,  8 Jan 2025 14:57:20 +0800
Message-Id: <d55fe3c286305aae84457da9e1066df99b3de125.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, add statistics for P4D level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/riscv/include/asm/pgalloc.h |  6 +++++-
 arch/x86/mm/pgtable.c            |  3 +++
 include/asm-generic/pgalloc.h    |  2 ++
 include/linux/mm.h               | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 551d614d3369c..3466fbe2e508d 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+		pagetable_p4d_dtor(ptdesc);
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69a357b15974a..3d6e84da45b24 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -94,6 +94,9 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	pagetable_p4d_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 59131629ac9cc..bb482eeca0c3e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -230,6 +230,7 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_p4d_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -247,6 +248,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_p4d_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49bc7b764535..5d82f42ddd5cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3175,6 +3175,22 @@ static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.20.1

