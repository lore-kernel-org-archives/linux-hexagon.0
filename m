Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50497192D9D
	for <linux-hexagon@vger.kernel.org>; Tue, 25 Feb 2025 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455232; cv=none; b=CiSk3T4LvIElBcApo0cvw55dDLc2J3pGMYPpPbv4zQL9Md80iDbSSmrkZEk/vmByuu3X1rbvn+zFSovt3AYr8/4a1GU/0u+EE6wCqsKpXCcBJ/gcxWL1ViAqwpltDMKlWvRj2zQmytQrwmC2RMe13wN383y0UmREbRQn07XdOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455232; c=relaxed/simple;
	bh=uEIt0iOIE1wq+fFnae14pvBZV4BJtIqtLEBiBKsbnt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hfsg/LlY56qOPKjXq1xBrV/mPM6dhkgjgLkaJ6M6t6h7nuJi2Zi3D5BA8kOk2tXE7G463yQ2ZEbxiJj+hhE6dpUyPpShEKOUsE39sYnhAZwagFVmLAFCzMROkac0nDT/ZkQzcj6CB0+qIJvoQ2v6UKHIX+csmfrO0gRIo3ZTh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Db5U3Vsm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Db5U3Vsm"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso5571003a91.0
        for <linux-hexagon@vger.kernel.org>; Mon, 24 Feb 2025 19:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455228; x=1741060028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=;
        b=Db5U3Vsmaxgd3fgETnudmM8tmkJMVY7pGwdCHDesrQ2DmxvkCMH24Ej7WIgjzAba5j
         VXZR0IpzmcQrf1Ty36dPjXn1qFLYodTgU515y8LstS9bOvHy6b2XtxPfR/0N1BlisRTl
         IJbghtr79viov51fa80+AjLf6E5t70zAH3FucoA1JgEPDoqQKe62BDFiGsqEKByFEuFp
         O5YdSgepx4wgk4bkgQnwCnvSNfPmOccdfnZ/Zr2+8AVuGOhaIYzW1t4AL7pix9/0MMK9
         2hkYFCgVZUTAEQRkA52rtp+m3NGecfRQYvKjaOFIHSoUxnZE7NePzAFytri072RCc8lp
         58Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455228; x=1741060028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=;
        b=AAz0xdwfkWRtLaeDg86N0w4wQz7aTAqxKHzFg4EjEM5LuOo3oAHzqiLkBylZTz9qZW
         dEYU6/CIGuaaH82C4ZWtTfyjovO725BhkXpgDUx/2wV2T34WqpMioYYYweSGcPko7oJc
         omVFbRubbCDob4MEWqTSEw4CtkAbCroG2M0rAgE2UKV57KmsBzA9m66ZpSlQvmIHhaIF
         wKRzl965A/yLiP+Cf52rlvGG6k6/8pB6XB9XlGlF2nYZzOJCkK9mmZ97V2Yy7AOWmur8
         R8Xg3ol3urUxGgLSpOVh2bwjzD3hZETVXBqBZVUH03UZshGGDmrhVu3QZ25u/pZMbuE3
         lHew==
X-Forwarded-Encrypted: i=1; AJvYcCVzBSsqxuWFHvHewkfneILFwBfSnYgEybxFWdvr7NQQPg0aFKYKGtuBbxDJLqHPxLBh30CAZQN/30k1cRfV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9Y0xn0B09HIf6yh1PfBiF3lVFRnR9XGcXMhjK9ZiPDh9FzxA
	cY5G+vdaKwbQL3mHypCIKgy9cYmtUiBlaj6nBZ9isfEBls090YiiTP4f4SOIsDw=
X-Gm-Gg: ASbGncsqOSaIf9qpU1rKvMkDimjc2DieizdDuqxpVm7hYw5NdQixpj1CKSUtfLOXguq
	Lmoc1lBJ25tfUNPl4y5RxDJ5xfDEPz+igtiCVYmanrLQa85VY5W0/N09rrF5p4gXqILbh3dhhTR
	MSAbNSOwqy7lZ/MIut5qyNCh6S43MgB/CmP/h0jPyFPg3FyfCFbUBIeGCL1RTe8pRUiWthTkAhJ
	CzOlssSAbvs6yNjhm3ALEeu5qHlsxjkfTXiw79KmLp48FTVKTqASKaNHCPoC7OWzJ/YrztrqFpr
	wkUSNMQYfJN4HCghcb7SE6KvtV6+VHiuPMw8uBkZ3qaOWVIO2AlXA8fhRWp2fOHfjQ==
X-Google-Smtp-Source: AGHT+IHErQlNtWAOdWTcDw4ZwAn3kttLeu4q3Mf0dru9ScBNUcUevexLBEyVDaZ2sKSBMgz3Y5FwbQ==
X-Received: by 2002:a05:6a21:7a44:b0:1ee:cb9c:9dc9 with SMTP id adf61e73a8af0-1f0fc89a091mr2965600637.35.1740455228677;
        Mon, 24 Feb 2025 19:47:08 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:47:08 -0800 (PST)
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
Subject: [PATCH v2 5/6] x86: pgtable: convert to use tlb_remove_ptdesc()
Date: Tue, 25 Feb 2025 11:45:55 +0800
Message-Id: <36ad56b7e06fa4b17fb23c4fc650e8e0d72bb3cd.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 has already been converted to use struct ptdesc, so convert it to
use tlb_remove_ptdesc() instead of tlb_remove_table().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/mm/pgtable.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index b1c1f72c1fd1b..f28ddac0f734a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -45,7 +45,7 @@ early_param("userpte", setup_userpte);
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	paravirt_release_pte(page_to_pfn(pte));
-	tlb_remove_table(tlb, page_ptdesc(pte));
+	tlb_remove_ptdesc(tlb, page_ptdesc(pte));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -59,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_ptdesc(pud));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
-- 
2.20.1

