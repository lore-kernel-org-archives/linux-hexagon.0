Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F4156F39
	for <linux-hexagon@vger.kernel.org>; Tue, 25 Feb 2025 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455201; cv=none; b=j2qSkX8w++BRQxkl6Xa4LH/1YXKRG64pUf1PK1qx8XtgJjO4Mp1S+qHD1MXUiuwJgm9WcoagHqxrIsz5cK/FuijlxaA7oMGoHYpEXuGeyA+tNrG/VgpgjbPf041Yd+R59Q8B64qNiPe57kHVasDGJ7KwlQ5/6+kFMPmJNckGRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455201; c=relaxed/simple;
	bh=oBmV5ytFANypY5PKhoeTOhUVK0FgP+zeeiYW6bw8jKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=achbb3IfEjqmpqnQMdtQbexQTdJ9ZhQTEzM8e5nMa5M24f9lYqAamiVJUeQmeie7wMJX4yfRfJIPcgLQa1dBarfS8in5fWwA9eQu+2yiKZukSI7lULl8Fjw+/M/rjTfPytS15oJEh8Nel8Frv8OBoKDRtXvSAUwAaeNzTcNT7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bWOqBTe0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bWOqBTe0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221050f3f00so115931495ad.2
        for <linux-hexagon@vger.kernel.org>; Mon, 24 Feb 2025 19:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455199; x=1741059999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OP1Tf7pAaJ4pNIvAgoQe1yrsY5TH0xWN2DlWHIb0tQ=;
        b=bWOqBTe0FNo2JdVQczJkB9CnLCjn2VsxTrBCMVEO2bTkBwn+9fWyHYUfMDgYlHDlO9
         TDmuZaxsUyySuy8UYSL6LHNPDqNr06zGC4mt7x9TGkuiwf9KeXk58HpCAKCaDHltt07U
         YoEE47cleCA2dOCEBABOZdBBc30QtUTENUi3AKhSwSeiyrIeTHWQ72YZw8/nRNL0Eqao
         MVHiYjurnYfe/P3inyxsjUHjzMLsK9zuTlHqXbnKYH31nouu2ZGM8X3B1qLuKsy5v0OJ
         fwMwi6YsDiBPkPC9QwuTZlX4L5QbZHPCnOVXqf+5suieKikkI6Jm1O5rCiHa81+a6o9S
         x9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455199; x=1741059999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OP1Tf7pAaJ4pNIvAgoQe1yrsY5TH0xWN2DlWHIb0tQ=;
        b=Z6IsqyDMuWwRDzm4SN7w81NmQoDpAudEaMHgUxt0UKLABwfJ0eXxHRtqwC6109184X
         NCdwBoToGzcF65E6mPXKpNQukVBtkqDx41ZyMZAqiLT1hu4AWvAGKTle0dHVhAIBwCu0
         etTWFH9Cx67tGohENoR9hVJx022aFzmWOYYDJttP4xRs1sftvv8HEu+okWJSNIIOT53A
         k5IHTs18f2/gvS7vdj4YhT/8aOcCi04Ey4L0HjcrB6cfKYS+IoOfWiSDud6dePwmJEP9
         lV6mCvf7v7SkpTywwQLPokIRTOVskuJr6ETT8huYpAekBWaLISbpMo0ATGexr83OyEyr
         eKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0v7FkmAtCB73pyB04cV78eQjOJ7PpuVhjrCzLm+jQ4L2ie/StZyWrDBqstCVCXPf8lDhWp3XBKn+MXAMi@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIL8fDOYrSQ0ZgR7/YnzlNGtwhiPzjWK0aVGg2f+oTuaViC7D
	/fw70ifaJlrYxwW5rkzqJ52R4EAH10/nEDocKMTHkBiSSPOvq/g3NXGO6rArBQw=
X-Gm-Gg: ASbGncuipVFR1NMfpF4rTgFiIDu57BhYfHRezERxBqDuKD98/WueegWlZqfYoc97iXc
	wT9d38H1j00Z4pYAm4pRO+FDCFkp/pRTq9hJb3g35EI/Xct11efxBV9Um58vuDEYzsIPH9frd24
	4S1o9J2SswJ9rNPq9vp7XqiOV2mx2xyPgcna4n8ttxnG+OkOD+4SIcIHv/BBRaebEdRPDD1z10d
	wPvQLTM9IBF5ihZRzN93AUdqGPLAxpMOCOBAJg7bNqtkZJHB1eDh600iXytbeERcJVc7uoqFJjd
	lCUPZiQ7dHQM/J+QL9mhfwYAxWvgLWNGhM/g+VRaDNPcBCjKd1UchrtEtx/aXe0Qbg==
X-Google-Smtp-Source: AGHT+IFHXm4yz9k/q53vQDLsSd2kyUiUDLPeAK4sNAWc/t1WzpyNSO/kW4XJ16gHc0dMjVe/gJ+ItQ==
X-Received: by 2002:a05:6a00:230b:b0:734:9cc:a6e4 with SMTP id d2e1a72fcca58-734791ab6bfmr3168643b3a.21.1740455198810;
        Mon, 24 Feb 2025 19:46:38 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:38 -0800 (PST)
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
Subject: [PATCH v2 2/6] mm: pgtable: change pt parameter of tlb_remove_ptdesc() to struct ptdesc *
Date: Tue, 25 Feb 2025 11:45:52 +0800
Message-Id: <60bb44299cf2d731df6592e446e7f694054d0dbe.1740454179.git.zhengqi.arch@bytedance.com>
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

All callers of tlb_remove_ptdesc() pass it a pointer of struct ptdesc, so
let's change the pt parameter from void * to struct ptdesc * to perform
a type safety check.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 54f579750c8e5..18bf499ef8801 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -506,7 +506,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
-static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
 {
 	tlb_remove_table(tlb, pt);
 }
-- 
2.20.1

