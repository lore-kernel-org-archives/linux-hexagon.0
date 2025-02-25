Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965EA4D5AB
	for <linux-hexagon@vger.kernel.org>; Tue, 25 Feb 2025 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455192; cv=none; b=gkG5HsdgeISPBO+VlTFrBPIeMurpvoboV4TWL+POCAm4Di748o0ttFM2FK75pppGRzdTbRg1umHi4keWbVS8d/pa0CM+LEIkOfq94AH+6zsBZVQynjmqXnorVv9sg+bFB6RVjKJIdquW4ZIvralYHIumMS4Y1XSQGLmQTh/7ajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455192; c=relaxed/simple;
	bh=+Ao5l71m8R2KBR4pKhSeuqtrK/FFUTZNCirhHcI/U+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUGsPdja6mspN3CgfHoxUwh+kezv4a/Qz5hiMRjI/L7bAyi4oU/v3pUh0CoOTXXXE9qQCMuXLifRiLvlhnSNaalO1Rldj162cMStBWJlciuYMLqpYpfivcBkgI6+WMrGkBf0cuMLR3ggQ1XpdPww6YZhlZ1/zdKn7q106qYm5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XqQAFeu9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XqQAFeu9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2230c74c8b6so4755145ad.0
        for <linux-hexagon@vger.kernel.org>; Mon, 24 Feb 2025 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455189; x=1741059989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=XqQAFeu9+jAY7gKK2np4vO4g91b9uWMd/6TX7uoukDIaD/obEG/vESFDxfKesdbDoM
         DUhZSnz6YFmvEDmpJ/nWXcwRcGca7LDIIKRDNxDtW2hjagjoenxWRFn4/kcvQXf3ACwl
         zJDVmBz48yBwHLGQMaHqSbxVJmbCZbQdfveZIEfNlYxG/y799JFM4vRo7yeCq+nhdKP1
         Q+5kr2LA3g3RrNO2bmwI2bN4c50lMhba78Jbd+BDEVb4CwQBNN9S1j46EM/7O6ZtGOUC
         k7tXgspl9UxEDV8bfxvY+EQ3QwjNTMjGgtNLzJafFP4GWzb1jmwV2nUqgBedoxCyHI37
         fAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455189; x=1741059989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=YyT4iHOum7G12jzTZRUiMb5HJkimlrZiPO9V9QIbxgFIi3ci50e4/de+QfiQIkKSAW
         /GftSTX3IqQO7C4eGUk2ysl/U33erjp5DJi/LXJyHA89VQYhjtBsN26U/ZyGT7i6F9lG
         2QmKEQ3+0dYIntrhVOCzBxpmEFmum2Tzekp2QlToU6ccB/8cGDJUevbW6H0e2beeugFN
         xVg6V4RPq7/Arp/lt9Ix9bGrqP2FxNW38voZMh/h9g79pgX0X9AtMnsWMEelhCIwncN7
         dxgU3Dd+LzwacZaDgPFXBcSDBbJ2MVO430HpMG1nmUwlR3KwlFb2QbxSQGOLaaeadDww
         EMXg==
X-Forwarded-Encrypted: i=1; AJvYcCUki0etsoUN3KbHHnSCtGONDv7uw50UfJSPDFfvm3tdK8ogDDYTkuVBxa0U5LBGtirvtGS1mCqY3zwUPlyJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qLKMre6ydk0Mi1sQHf95cIx0bikaO1a12sam9VSsBiqnPJOT
	XB5L+a1HaOxQYi7p+TQJv2DJBnqboGG7Fu4Kmf5irI6yiZqG2gXmOJrab3+sqdw=
X-Gm-Gg: ASbGncvHUEQBz0hoCV0E7V/BMAVEa1LkRM81tRRvQKbHpUVxOW4YRRFrDVx5X8FFQHo
	OYdWpj72sI3DqUuTPtDiwxxOu7mjfR0x+d6wkZrpDsuH1QRnJqTZyq9Sws+7BocDL1aYy910vxq
	75IIDzLrsSweDjGC+R5g2oTLc7ffZSOq6HXjE/rcnBWuiIQUo8JjxC7cAODRn9Af1MBR78SLdb8
	WyOVaqeuFiZMvjv1ZAvJzjr3h0XlEQVUEY7W52crz4WWHAYiBHkrJHYmV3fe85OMyyfZ4VzRMDb
	PoyAkMh0KFQ5HCaLQePZ8H+qRML3ZqYKWKzu5yvU+Gb61n/aGHCy+I3vp7Yl+8xfMw==
X-Google-Smtp-Source: AGHT+IGBfXw23ytiI6FvQDqnu6HA+6X81xKlY5Cdi/AJkyrR2YGvsG8wye6vZ+K3tNu1qHLJYKOiEg==
X-Received: by 2002:a05:6a00:22c9:b0:731:771:38f2 with SMTP id d2e1a72fcca58-734790de607mr3427312b3a.8.1740455188892;
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
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
Subject: [PATCH v2 1/6] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Tue, 25 Feb 2025 11:45:51 +0800
Message-Id: <5be8c3ab7bd68510bf0db4cf84010f4dfe372917.1740454179.git.zhengqi.arch@bytedance.com>
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
index b35b36fa7aabf..54f579750c8e5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -232,10 +232,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
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

