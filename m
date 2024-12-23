Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC6193429
	for <linux-hexagon@vger.kernel.org>; Mon, 23 Dec 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947049; cv=none; b=lHe3YsJ3+HVfkcaoR3KYCoc8NGPPgF6ySWbyUv1j9ckjWvGPUZdDU/q48to3BDI55KsYwUsWOd4D56rGoGHaGS0S0jv5EgHC1A/61TC+Dx2Mz/gbzEAr2X9IbsXw7kWwL20FEGOke1KSzLorMpmSfvYmmJvWpSOqZJCoTsnGfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947049; c=relaxed/simple;
	bh=jiyynG1cSpqMCUPKcTsBXQhnImP0khzMQlCaAfJaSPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIqTojqz1ppkSnE2Ol4TjAu4+kYF4g23u3Jq+UPACMrMZuQgW+rnYBqiONpszgQHXZYhhWNQXWQCspqh2fwOR0YCvjDLrYB+14CDFl/73KPvgG/NTyKx69ldpuKoERMv4MBmjUgH41Jf8HO/qJtR/WxEwX1ByZBHqhvpgrAc5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=l2fu92Xr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="l2fu92Xr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso3050885a12.2
        for <linux-hexagon@vger.kernel.org>; Mon, 23 Dec 2024 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947047; x=1735551847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=l2fu92XrLbHe5vKbq8TlynuLMNL/slbV8aqe9gAKoq6PUKk4R39Tw71RcoiemwvA3V
         ccpUwy71aYHNzaXMwEyBiinbk6QGTT59LJKntkwb+/uPWqaJy+Hae4Ol43D/77ZJ15Zt
         PzNYD45G+KI181VY0KP4MnbbCpy5kYt9eoOEIUnuLBiL4+4vA0/6NsmBXMXBOhy5lp/G
         3FjcSgNIWb2upkwDqTTw7pJreMiz/lnQNM88ydOkaHa8GR7xfcYYyO+i7lRUwx4MQnsY
         5UH3m7mQUpS0PHy73O361BxTO+zBJGOWgU7CgCjhLMEdQn7IPTdAFOh7k+Ka67BkUf85
         eLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947047; x=1735551847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=juv2Y2wqLrUJWDgOwH7eKE5gCrcJKP99Bl9g3WWwi98F3B6yyAXT3453EMYKPTN/6B
         P31coZdcx3jIJxPXZDzbDS5iiMWRlNNLa3GZhQEV1DxZsl5d1XSf//K+ayqkeXt4uDyr
         HlQ0FGxBdgj4dIM68DzufGTwn1CMBH8R8L8WyOB+yJU+i7XzW1LUaoJWGXBAQawbVDj5
         c9zonHUCyK0wgWXgZB39GfAk9Xobn+2kJSaibIba21NLMwPPP6ea7+raoiwg6LwOVyXD
         kGQUdUypH+4gZ8pTZDxPL8KIs9TIe4zlqY+C8xKjVQHCL6NCj6c+d1Y/7qOpNAHWKgLn
         TdFA==
X-Forwarded-Encrypted: i=1; AJvYcCVp45HlX8OKMb1IjB8EPtKl5Pcz3sD4qB0OMoaoFifsp4LlbIPi3LCCQx2NylZkhCphR/Dp/OchmeG0ADeC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7OUcNQIOENcgV6LkruLaHjGifbcudM+3cl/M+C+2ZbTfE/fu
	dBEhQ3hSX5b9izdRfVsPh59qPCd1jRUDZebvTxTfMoxg9Pbv2YoPW1iAPEjZta0=
X-Gm-Gg: ASbGnct4MKFOyWd5ZdU/npv0MS2z/kh/RyvIT2h24kx7AgpNgPTlrfcv6Sn5FPi3Kya
	M2UsZSzzYh2v2CgiPvzRpOn4X98nblOHpjk2w5/0vj/HlH/OI2kHkZlaGUD4QIaXlqRFl93N6fn
	72DDkCudnnyvabs9PCC/FMpw7q5QVeMuI6Uj+70KxA/ezL9+KFW6z6dyftpfjGc06/e7zoAazQ5
	96qkO+Ai8nXzGqOwzeB7qEKzqnXUMkXvnZf6s7XcL9kT9vcMk4aSLGyx44UZ75GVFBY++WlfYMo
	c/Ajoqa3I+5IYqXdIPKLGA==
X-Google-Smtp-Source: AGHT+IEE3DAo82DBKWUM6FD2Qxwd8GTGkBziQ/dfcNtaRbY+efEiB7FXaTM2aY8g2l19VVq60zkLag==
X-Received: by 2002:a05:6a20:7f82:b0:1e0:d575:8d4f with SMTP id adf61e73a8af0-1e5e081c5acmr19810935637.37.1734947046731;
        Mon, 23 Dec 2024 01:44:06 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:06 -0800 (PST)
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
Subject: [PATCH v3 05/17] arm64: pgtable: use mmu gather to free p4d level page table
Date: Mon, 23 Dec 2024 17:40:51 +0800
Message-Id: <7c12112047ac230809aacd0379259414b9b0d3a3.1734945104.git.zhengqi.arch@bytedance.com>
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

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1

