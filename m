Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21669192B6D
	for <linux-hexagon@vger.kernel.org>; Mon, 23 Dec 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947001; cv=none; b=NmBmu7zlI+NEM4y8t6EkIgV/hc/JXWIAkUWuckyyGsN0o5FJfjdXSX77clDjT6/+lt76y+O21/ZhuxGVowgT+W11jedjoI0R1+BRGDGdbrT0F7x5oUVDf8e/MlcL3qbChz4WBJTcZcahISTW72CnCUC1i0dMAEKf8jg/D/2VLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947001; c=relaxed/simple;
	bh=eSQ1cqjI0k4SQFzb/dlIm3hCd3v5CZjZJpupq9IDdtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAeHxDP1M9JHnTGZ8m15tbEiWwTspZU6NF6RXjcxXo03X70rQ/6DcDVJguk/w1kqM86pjP3yHb8Gy8jzDwci/e0TO4UbiepjTm4mUFeRMTi3QwzVJJcX5JwBR7RsxQ4Eduwod6++avrZd1b9tfxrhA/WbOv9h/T0sbo2LzCHOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ht+5ilzY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ht+5ilzY"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fcfb7db9bfso2727469a12.1
        for <linux-hexagon@vger.kernel.org>; Mon, 23 Dec 2024 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734946997; x=1735551797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=Ht+5ilzY8Y8XYLiW9Ff0M8w9C2lLtWgJAwin0q+DBGggZW9G8x1NeFvrT/DmYzaP+s
         V8FxEkne/FTfG96izndxnklHmrQpys3F8suSdWDww+RgViN+fX1c3x3Rvx+hy18rFHRP
         hFBZD+UIP+jCH9ra+z6AVokYgAUUePp/+G2cuUFsrqxPYsEXDFWjHoIzUktjv8G5ZPsd
         BMNsPCOBLoV5KtXFLs6pxcAbbdEiatpbkDk2k/6kERUHvpCHIuzXQrEzCXxhuMWt+vm7
         LMeKU7bPIJ7SV0VDUfI3A8h6v7wScr/YWW51ipUwNNfD9r2yDFi0LRCNC0IdqacYpltN
         G5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946997; x=1735551797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=mUqoDfYj/VgaX3xeM8xWBF6xX1f5o51E2lW3PbwgoIRUmYZHhMWqmTGy4B3MXUB2OQ
         YGw4xoh3QsAHAxFjkaOXCsm8LkKXVFtWHyeEXXc5tj5B4g5WBenj3jx5WdZ/RMeX2dpG
         PaCGE7wI5TUBoC9k6+bXpiBlb9yDC2mGScYmYwj/t6RlXM19181lkWiWUj81nYUGR2i5
         MCe2QZi3y5aNPDMXXTiexTZBtYlUj4zkdn4UWEtZiv8pKGGsnFQpKJquxWJ9GxaFRLSr
         ZvSAdwLLw6oiFuURbQma4ETkFIe/93x9uqIMNeA+UpyAJhl93vLyyDZBIElZy6wwal/s
         OTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRxW3nMBufbEnqhGO6UTkZENvGbBhVncB+tH1Nab0+iffMXMnj4nr1m5WE+okPYE1yAibKmSeqXHvyEX+n@vger.kernel.org
X-Gm-Message-State: AOJu0YyA61QTFG7/LkSAKKdW0abjW+4T91q1kvq6yXTmMm4XQRdN7Ou1
	9zfwGimMcqm/gb8m2VnAC+JAnCK1WOkTsw/4EC6KGnNFujB+sJe8Nlddbo7sgCw=
X-Gm-Gg: ASbGncsNw9aS93GVOCxcvCxJo40QBeJ0EWEI38xzTNCuVBdl39XmrNTySh3LTs3J/VK
	w6BsocLJS1tWT8EdoaRruv6hH9Z/+SH1Yh5Eu0AB0FM9s256XnPMCDLihdensrYnCwIhx+hA4Fr
	xfv1RQO1+mdbsAiELidTkPLE0r0Qs1lwrS4pzmdUUz7JY1GhfRqIZfdxsR71udwEnInwJon5UmC
	uBMbRbJhtbLAv+DJwxlbQlKjUCAmSmqxLtcTS/B/HXbkmV6MMl+A+NtzoPMwSVNxs0FIn3M4Q8y
	KePEadAhsr8PY+jxbRN8nA==
X-Google-Smtp-Source: AGHT+IETS5CqVMOZwuklYBKyw2d6q7hBKdfBjuJ9ZQ+tZcvMnTE5pZk49SgpvcM01OaAXbZV7hq4vg==
X-Received: by 2002:a05:6a21:6da9:b0:1db:e338:ab0a with SMTP id adf61e73a8af0-1e5e0447f5bmr22664720637.8.1734946996090;
        Mon, 23 Dec 2024 01:43:16 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:15 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v3 01/17] Revert "mm: pgtable: make ptlock be freed by RCU"
Date: Mon, 23 Dec 2024 17:40:47 +0800
Message-Id: <b59adb960b2075822a6e57efc7a52e7eb7780068.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  9 +--------
 mm/memory.c              | 22 ++++++----------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d61b9c7a3a7b0..c49bc7b764535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2925,7 +2925,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &(ptdesc->ptl->ptl);
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90ab8293d714a..6b27db7f94963 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
 
-#if ALLOC_SPLIT_PTLOCKS
-struct pt_lock {
-	spinlock_t ptl;
-	struct rcu_head rcu;
-};
-#endif
-
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
@@ -489,7 +482,7 @@ struct ptdesc {
 	union {
 		unsigned long _pt_pad_2;
 #if ALLOC_SPLIT_PTLOCKS
-		struct pt_lock *ptl;
+		spinlock_t *ptl;
 #else
 		spinlock_t ptl;
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index b9b05c3f93f11..9423967b24180 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7034,34 +7034,24 @@ static struct kmem_cache *page_ptl_cachep;
 
 void __init ptlock_cache_init(void)
 {
-	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
+	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
 			SLAB_PANIC, NULL);
 }
 
 bool ptlock_alloc(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock;
+	spinlock_t *ptl;
 
-	pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-	if (!pt_lock)
+	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+	if (!ptl)
 		return false;
-	ptdesc->ptl = pt_lock;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-static void ptlock_free_rcu(struct rcu_head *head)
-{
-	struct pt_lock *pt_lock;
-
-	pt_lock = container_of(head, struct pt_lock, rcu);
-	kmem_cache_free(page_ptl_cachep, pt_lock);
-}
-
 void ptlock_free(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock = ptdesc->ptl;
-
-	call_rcu(&pt_lock->rcu, ptlock_free_rcu);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
 
-- 
2.20.1

