Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15A20F992
	for <linux-hexagon@vger.kernel.org>; Thu, 23 Jan 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638911; cv=none; b=GikkV6qTkl/ZoK8zIi4OydD2XS+F+xqajwBhSX/u8FaP19UbWwsstz1oJx8swxS1AtjaYotkkw9o7fKl7Gl1x/jnhyvKEZ34/yCuv4KorKNaD+pBW+m0HqFrsvBAq5p5J0K5+z6XEjjWvdg6cQ2CHXwpaah58pnVtT7hUp9YNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638911; c=relaxed/simple;
	bh=FefxEocj4IoJjXKARUpJHCYOj+T2Zg9VgaSRz05BYQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NR+S4F43jDWU8m/7dq+nCUzTSXkroeKtSPINDTWB7GpnFz+1TLf+8WuzAfPGoXVvO+jdrBD4MC4XPutDfvi1ua3prm4vRFTl1dYv9NsbVod4N8425yhpUDnqniRsToWcXm/kRQThlJF74vjzKTdSnHd80PInWIRLwkBWSjg3Hok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PebiQot1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PebiQot1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21649a7bcdcso14938165ad.1
        for <linux-hexagon@vger.kernel.org>; Thu, 23 Jan 2025 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638908; x=1738243708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=PebiQot1rb6XbHbzslfJsKpQcKPxtVRWfvW44wiTQeZcn+FPb2jW/MNDRjdLx6k8br
         3442zb+LePJbf/eefreQDFW5bpNEpafOYF7xTQDkFXzsr+9Bbcpie1mckFpTKNXbUxAr
         Icdp3NKqYa9Vu8Wy47GHD4CXfEBFbujZ9DFs8y3+Ee7kHhTyn5o/FFBAmrU4zOwkWyZc
         UZMf6AHZ7e+UDvM9vymXCA7cWG/T++ephvUmyUCJnhiL5wmVftKMsdQMTigMvTqGAuvF
         KJdGHNU6mSbcLgett1i/pz5tgCxaiRDhYCZ2Zoc3DkRyqRYo7Vzi3ggEu7/h0YFGZxgr
         qcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638908; x=1738243708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=MsilZII4vcAYYT91knnqF/x7PgL028vRv/vLwZw/P6jjpCRVY9ZwU7fBdtxD+HHGUF
         zvA/OXjzZdGV2eymnEToBLLLlz1Q1yfqBCWQ28lkk3uSEVtT7gyEhyc0LV0S23e6uEfj
         J7BukSlCAHlx9+aimlBVyXi79lejXo8uQq8MXtbgGUxKDzL4/npDqhWoHiXKIKGs5Mpp
         JPchK29N2NhjDRQ8ANr1XqA8HCoMuunw6ytbDO7QQjSnoO3yU8AlV4a+tze1CKJwBrLD
         alb2sMq21fLxcb7VflGhasM0twZjTkftgkEnL5Xxvk09itYAMVM1SWvhnG2f+j5XkmpB
         e5XA==
X-Forwarded-Encrypted: i=1; AJvYcCUkuAG6dZy4Quzmh1JMUIyRxJsXQwdUmTQqHkhdzLsMZA9RcqtBItMlx5S6IYM35Mrgrupffe94IN+BLf65@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UT13fbCRg2xj9SgHF0/UBBIWpgxsZTQzHC5ZGosXKuuIDLmv
	BykRY3TSoU3R9yXadQqsFhq1KXaxVRB3ftU4x0j5FemMUDN1Q6GZrTsbfC2Qa90=
X-Gm-Gg: ASbGncvAW0kQH9YlfuwoGsd2kTbjEc3peDlKDiMpwBPYIhYK1wvHJUlys0UNGz2xO7I
	D8GqoRlP+XE/jeH2+/JTtYdvLGcHTnybQEBqGmET7b7KcoNcnTyDMFEqBWxIaXtgmsg/rssX8Mu
	nuRNzhtza1HFkxL4tTJMl/BqS3qP6dqD1N3WVVIIPUf4rN5w5ufCGhPCt2dK46V7xe1k4vXx5tU
	ZjGfm2glhxHFUGOtcdZYugR2+OpHdT41grBsFLgVKqkcPHGSa5yHfUVRBmxaUQT/V/veDT8da6h
	pmo/YUUvqOlkcLprR80uaNQkRm/kRuk4GyTJlgJmrd8k
X-Google-Smtp-Source: AGHT+IGvH4jPt9gEk2i8wJlEQCGHtq7Z8F/nhrt9cHdxqXKECEeUfNk2qVC/Ig+lLuwaqRjslO9WHQ==
X-Received: by 2002:a17:902:da8d:b0:216:386e:dd8 with SMTP id d9443c01a7336-21c3540cd05mr367659545ad.17.1737638908563;
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
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
Subject: [PATCH 1/5] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Thu, 23 Jan 2025 21:26:14 +0800
Message-Id: <e2a1b07eda16eb84bdc51f6227fec02f2c0a54f7.1737637631.git.zhengqi.arch@bytedance.com>
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

Now only arm will call tlb_remove_ptdesc()/tlb_remove_table() when
CONFIG_MMU_GATHER_TABLE_FREE is disabled. In this case, the type of the
table parameter is actually struct ptdesc * instead of struct page *.

Since struct ptdesc still overlaps with struct page and has not been
separated from it, forcing the table parameter to struct page * will not
cause any problems at this time. But this is definitely incorrect and
needs to be fixed. So just like the generic __tlb_remove_table(), let
generic tlb_remove_table() use struct ptdesc by default when
CONFIG_MMU_GATHER_TABLE_FREE is disabled.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/tlb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e402aef79c93e..10cdbe0e7adfe 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -228,10 +228,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
  */
 static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
-	struct page *page = (struct page *)table;
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(page_ptdesc(page));
-	tlb_remove_page(tlb, page);
+	pagetable_dtor(ptdesc);
+	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
-- 
2.20.1

