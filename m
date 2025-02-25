Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED44D5AB
	for <linux-hexagon@vger.kernel.org>; Tue, 25 Feb 2025 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455240; cv=none; b=twipz+Y5U4ccAm1/MZmseUUyJw9U/9mXl8HFqCO6FubnaSU1rxNj0lDwutam+rAA4lUYQcUjvMLM1gLQAM5jHeH7mqnQHt1ls8EBgKHN2RXKkSta4O4fFukD9FADlox2nlvL9mjFQcCd9ltggxNz2tzrTg+gU5D3cwMZ3/hYYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455240; c=relaxed/simple;
	bh=007QVVVFe489JDQoxvXq6IPNtqGHUmY/RQmaczrx98Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0GIYp1csFIJQyO7jVxOjXqifyVJDjGzN4gTVAywy4FNbTlmYR2X0znx7bCRYeTGcrz+jGHJ3N6IMJg/xVYetgNQJR01t1bwVbasr6dd2f3GUeU9vx+Vi8IwtF6WbXIYroUNTm94CkWjO6wnfp5srs+dtp7/Ua7Zvzakja3oKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N62m9mDv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N62m9mDv"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220dc3831e3so95477865ad.0
        for <linux-hexagon@vger.kernel.org>; Mon, 24 Feb 2025 19:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455238; x=1741060038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=;
        b=N62m9mDvTU0KT7/zOgSYI5Gj+Rt2Y3m3JKGSoFuLFr5cQorgKfTRV3LgEs7+XNq9Cl
         PX6qN90TgUX+eHKhfEK8YzIInYLCyIA2/pOt5HC5z8LmoAvu8jYNeJ/1n7Wy5AZ8lSPC
         EQ26Vg404rAFBoO2dNhd67BfEQKALCw9FTmPKOaabEw50R2u18jskTqSg7vpL45v2F+l
         oiu+1rGs13S30DbRSlEK5+05Ejsz0bg5QepFgIJfGolmaG/57Qn897DbgIanmZnB2ayr
         RQkux5Xr14cSTPhqWwo1Ne2TRXGddxosb9mt7RE5PwdXQh2DtuoP4h7G69I5OvjvxgsE
         vMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455238; x=1741060038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=;
        b=fGugmnJAkRu2VzrR+lJdB3DjV2yjkDOlmLt8B9jcTxFM7c706l4ynBi3INJcWSAGQm
         nLmQXbC1lk5j5FGh0QMGUqHcXE5sRbQ+e9YyRoWa5Coll1tg0QoreK4EwhQV44dDjaXw
         zOcx1Q5yfNzKvMvTNVuFPbvkgF9+d+S+w1PggwoPN3LZBbdE9mkhWQgDJJ3X6wHkBsdF
         JtKezNEaQqUqdS5JxAUWjjDksEFm1OCSYboG3RIV/RdvlgKJLJ+dI1TllE0iDeMSzn+p
         HwO5gHVeYJQt2kf6nID/Z9sYykjwkuMPVwcx3o5KRNSxSgyF+IlwSw/a4A73N6W2oRii
         8CXw==
X-Forwarded-Encrypted: i=1; AJvYcCU5QUwMKfDhDJCDy2RFc3hcMJ9OV8Tolr8NaZ5wOVLd9by7BT2fSUKeGNMjFFX/azVPd9RsTVtw16fwi2G/@vger.kernel.org
X-Gm-Message-State: AOJu0YzrdArhG5ZQLS2gcvRJFOEmDHWnnuIfPdLG8y83X8eN7ZAjbPi3
	OtHoARIvcfOAsG0K7aPLgFxnB6rYj6DHM/iQ7EIxSygtL6aKEiiXXrbTnTzbFQY=
X-Gm-Gg: ASbGncsibfIld0s1i31j5+wL0aiiA0GQTD9T/YvSMyC2F2haTWeh5aPInx4/Xgh4Gz1
	UzADHhr9Z54YMw90xYoSaDmtbQk10sEaRIRcDMG8y0cFIm4RdrqoXsZ7t1FzNHEMwqGHpaiETB7
	x80FF6CkP+vh0BpFZq+jVs+iOmjs4UQuec+O6Xl3eK2KWRAzEWi9Jh1r1La7gWwiY9CvD9H02dM
	1EK2OsjER/RThkgXkRfznmA0KWEGzgDNN5bgpjEQQ0abeFAYqx82KCvtrHIK/cFRKH77cGfeCQ2
	aN2Z8cp7RGFhPbB60YyA6QpJjHI3mKz+Sl9hsA9Nrn8Do5xONK4/PE6MFY4qXcmb/A==
X-Google-Smtp-Source: AGHT+IHDwvQZzbKv24vEjKNvLJNI+R1iJ4OqsIlmXN9p1d6u9OWq0+ZfVfD6gOTuv6xGQ3OntwSRRg==
X-Received: by 2002:a05:6a00:6f0e:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-73426c62969mr26062579b3a.5.1740455238550;
        Mon, 24 Feb 2025 19:47:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:47:18 -0800 (PST)
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
Subject: [PATCH v2 6/6] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Tue, 25 Feb 2025 11:45:56 +0800
Message-Id: <3df04c8494339073b71be4acb2d92e108ecd1b60.1740454179.git.zhengqi.arch@bytedance.com>
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
index 18bf499ef8801..dd292c6d3ce88 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -511,12 +511,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
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

