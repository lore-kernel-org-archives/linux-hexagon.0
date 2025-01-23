Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07520FA99
	for <linux-hexagon@vger.kernel.org>; Thu, 23 Jan 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638952; cv=none; b=BUeSehjSN8EoRVK90ttCWhSkUQp3Wv9Jeh2aufl2KAhz2Z0nXDO81t61zUVVJefBV8QpAm76Cb0Ff/dijshxigdgH1w6M7W1QcF9uyEIgI2zPff/0aUCfBscwsxdy5qCRvxRjv4RNBLvqzuyV13UJqeNqH81A6XqZWHF/oXAFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638952; c=relaxed/simple;
	bh=xyoxab241Xbf++2pkWevGXAMdg+Lltm4zD7nrlxitWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDlrAQ4JcBDInHUMJU5ncELpbEWJ4dF22rqH4X6pad3ysJvV7V/SWofEzJWQ2uDgZaaIPzH5qzo2dVB/T5B9WL2DTNNa6RrTgdKt9wt5bNk6SZD0jUjbzl0d8ZNkpGBC8H86QGMUbHKlEqrw/GYFFqR4FICf+rz7XpWLpGEIBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M/dznGMi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M/dznGMi"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166022c5caso13618385ad.2
        for <linux-hexagon@vger.kernel.org>; Thu, 23 Jan 2025 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638948; x=1738243748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=M/dznGMiy55gDN4Bz8oivIoQTni4ET1ZdrZPukL3yR3sGAC7Cvy+xQhynQvdI9/yh/
         ZQhlAxWVub1c7f2ZbaFFGvnfuvRkZb9H503JbCXZ9Vwkj9KLUpJs858s5RNnYjaiIaUw
         lI+tSM14c88PHsh54pfbFBxD5Suu8dOiyPSrV0KN+iVRZYm9Cm7ppVSRLoIHQSBzDtdz
         Jsh/HsULJhEJkCcTSeINtQcE8kD55A6TDD3zUx8V22bZSdALpxtluCsNKwjK4/IFZG5q
         ocjAsy04352y4mPBGnCbJBzRQ0CcXjQltc3ceT0KbJtw9ZluGYhD3Nex0Q5FhRZl2RLm
         rHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638948; x=1738243748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=m5BlPec4RNsD1Xt+BiApzlDnpbHtbX/gCutwOgk+PD8rvvkq+Z2DiSxeZiNFKwPiPn
         ++qhCy82TS+bMlMuIXs14mhSV2n7bPsTaltXNINbUVSpc74pb5r6EBkooZR2bCeH4ICl
         2tO+MZksk+cY794xhrhf8iA+ibirwtIps2anyxD3QZ5DLEeXSH+25tCCqsXRz92fAb8h
         wRAen3OwBYsiSpg1Az/ENvX7Lvnv7XmgA5GoUjnshAjlGcCYLcwzy7ejpL2CX6CS6boh
         KJtWLbfNQNkWvAyb77LpxiWdJkYATNMomHq0fzY8hwr9tLBiF9Pq/EQXWxYO9tM3WEC1
         vmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvvr1PElFTnNlMS102grdohAOTgdcqaaVbVWOvHeU0w6SNGXrKYW7wbshjN2i5KOmsyOrtBPAbwACPf1c@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMo0my2zDgyNK5OTpOMJ6/EoIibcTg0KQ9Y2vqRcepkAT0pey
	a5e1d1wlj663WeWcvdc4XOytu12TPLsFo8PDqoo2pe8BwKWEl5P/dtHpDKwtQf8=
X-Gm-Gg: ASbGnct0TC0pojmnZa7VIH8As9nDqYQa/NZALC7vufSEI2hNO417AKR5NH5igf5/3cA
	LJBJljLWQJ8xV289D6VFmBPTfWi5yHK0bE6sy3quEAUNhdA8CauHYqrqaPuUnrZQiSpPoVpSLV3
	yGn6mb17g34eHeEiNq0gqQBypeRR1/Z3iUP/PxkzeVGPLLN+4O6cPsoNyPY690ag1pOpoBXfk5x
	ftH3h3nkLp8o44CA8LIbO0dxJY7ctjDz05cBKN5iYxZMwC7fmTQZtgqeJt9+7GMErAUD2UPVo5M
	RW37thj8d7aQBkDTH9YwogG//eUc/cSrjjXkwmfgVcJ4
X-Google-Smtp-Source: AGHT+IFkSdO3UtmG5jKkAJtanqQZSHufZoNoVtMFPHl42HZUz79kP6iB5Pw4LWGczfrtYHtt4kZUXA==
X-Received: by 2002:a17:902:f54f:b0:215:b468:1a33 with SMTP id d9443c01a7336-21c351c67acmr376126085ad.4.1737638948337;
        Thu, 23 Jan 2025 05:29:08 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:29:07 -0800 (PST)
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
Subject: [PATCH 5/5] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Thu, 23 Jan 2025 21:26:18 +0800
Message-Id: <62d6a04c3a0e70efd435cc2c8a4d9d07d94e7ece.1737637631.git.zhengqi.arch@bytedance.com>
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

The tlb_remove_ptdesc()/tlb_remove_table() is specially designed for page
table pages, and now all architectures have been converted to use it to
remove page table pages. So let's remove tlb_remove_page_ptdesc(), it
currently has no users and should not be used for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 10cdbe0e7adfe..dec030cb12108 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -509,12 +509,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 	tlb_remove_table(tlb, pt);
 }
 
-/* Like tlb_remove_ptdesc, but for page-like page directories. */
-static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
-{
-	tlb_remove_page(tlb, ptdesc_page(pt));
-}
-
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-- 
2.20.1

