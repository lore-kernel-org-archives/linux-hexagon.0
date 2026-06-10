Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887C26FD9B
	for <linux-hexagon@vger.kernel.org>; Wed, 10 Jun 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130269; cv=none; b=MymLMrzgVifiHVsxujhncH13rV7CFgjy/tixlSRI89IUJ9VmTB6JOr+Nm/nRe8yQAN0h8zQpxiAGC29StEWU8K9njBMfGk+7TdVIfXMVp+pyS1It8+wTZDNN2gGJo6NeDNEklEOeY2un2ekSv2UnosrsF2tDtxnnjZFKSmQ+Y3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130269; c=relaxed/simple;
	bh=7qESKhmeQ2ZCPCD+Yx2/oS5Iv2mIx1jyg09EXRD5euo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATM8Npyv41WzKZtgbgu8a7CjvMeSX9PRbKGZHN9u8r+a2hIs3rt61DAXi2i6UNJVT3L15WevHVEnwvUFmncUPSDkWAdxqJz/HpzspnVUn+Gk2J/700dPTzuslYVr3DlwSQcQcmMcUgPF9grpOJImuk9jgkL31CrG0gI0YP1TWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ5ZlUhP; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ5ZlUhP"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-3074adb8fcaso1773174eec.0
        for <linux-hexagon@vger.kernel.org>; Wed, 10 Jun 2026 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130267; x=1781735067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YKgYwbXHs9uriDa4H6yf4eIdSf4rT7QZ9yMscjJe9g=;
        b=IZ5ZlUhPWfWulW26JFc0C6NPjYo61zHc3qSWkjHtkuSea8DSrADs5lEII01Ue827wx
         Fia8RdHE5eY+J7vVwjNmArNh5m5tUHEdvjyVBhqa9XLHcAA7WGswEF/1ajnWgV2hoTNy
         Hl5//Se/pbe7j1JjWW6tYp8Uv6lfoJL9s4VDljLyTFfDUJFMJ6OQZJD8X3r2xf/nTSpC
         oK6g4nJJgI8p8+WCucLxhF+S2sJDu4N6rt7X67qL12nkD8lIlp3x/bfn7l+/2mBZYqFZ
         PhScVYFeb+PmPKjdpdeuRQ0SHwFn7VCdfZiqtSFUeYbHmZP8Lu9A9dveXoerLyDH/xHB
         /6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130267; x=1781735067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YKgYwbXHs9uriDa4H6yf4eIdSf4rT7QZ9yMscjJe9g=;
        b=D1+r1qPizo83VWn0+OyEZArZyhdyWTDyfCWPszL4g5OD/QH3PD7hpPkRplAlOeDfnQ
         +WK8OJKBnFm9OOe9I8w5vOJjHbRT3L9qMPi+UbQ6JLOGMAH8CPnXW7ANkX2WZJyRSQx3
         zPuP2sSTSHNl9ndNQ1Gnn2Wjgoe8oGFHakpax9Z+i9ASs71agPie2+JPoDOGNM37JiUR
         UdZr36y8HlFF15TJBxTtn0zvbyp7+pnXW5OF6vyrSbagBkhqgtrshCPhR6mS9lbXpVIy
         gSYx+GdPNY0GqyEB/4H9ThhaDn5A1+abFvL17YOIHrtZAcGxB7IeYJ5ptzPqSJSKLh9s
         p/6g==
X-Forwarded-Encrypted: i=1; AFNElJ94gam80WH+tku3KTuQGy3lwXW/wa1zK+UxsaQcd+Nd1zZvj9Y0rtRNfvrk80Ce3rn+TPBs8R1hX7ScbNOs@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz84ameFmu19yXprH5BRTvPB5UaukOTkXUp5j5LYbszmm/RAkK
	Phgu0+L1fkIOcYDDgX/QIQKy6IHmhpjXZtLB07v5bluy0K5Z/hhP37V1
X-Gm-Gg: Acq92OFwjUrAv1C7mWJ9aCKOkOQ+84e8CTmKukyyRkUSEcdFs5J2w5W4k6gPxRM9Hjz
	/tYo5KTTiE49zB35TXc2Q0pBVlb/c+WLF/fZt2x+zCnuegojVQ5dfnmHpmci0TFT1N+ZPypW/p5
	EEqjwikgQ0BjoAjMsLnujhTvNtrN/ChBxH5IBIQKxP59lzicay1O/DNXjxVG3SJsNMKHMmw268D
	a5tuWct4jzjolDmnSD7QRK4Q/hwPeCo5e27+d57ZMzKz9XxKbwWqcBIuZ056ZwWCueDCmWNA6DD
	lRWBwWmqps7GGWET42pBcShZf9nu9Rlg7nyEhjL/W7QV+J2YqUkgEos8BJga8PrSv6S14gqC1ok
	wWT0Sa8G7fqofnvbF9ZxzM3tIrUOBnc8S+c9LCwvp4ZZ6WtRcNlrAa+kdPWTqFwoOGRrZwxTgKA
	/ooIPSZ1P2/elGEaERXjtuGhvtQrMco+J9Es9yWgLsqWblyGEYxr1jxdezM/FJAdkyBrgyMQu+g
	CwIitpW6IKAvxTN+D4APRNY9nKepU5Iz7vx2fSp/EnMT8S9KHgEz3fLkAtWuUO+kgMF4Wp18PRw
	ulS0LNzFxMG92yRAhHG5qbzw4HD5j1xmhn1koX0=
X-Received: by 2002:a05:7300:6da6:b0:2d1:d434:cfe3 with SMTP id 5a478bee46e88-3080411cef8mr243124eec.0.1781130267174;
        Wed, 10 Jun 2026 15:24:27 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f6381fsm18674572eec.0.2026.06.10.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:24:26 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-hexagon@vger.kernel.org
Cc: Brian Cain <bcain@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH] hexagon: remove code to handle nonexistent CONFIG_PAGE_SIZE_1MB
Date: Wed, 10 Jun 2026 15:23:52 -0700
Message-ID: <20260610222357.108394-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two Hexagon memory management headers contain code to handle
CONFIG_PAGE_SIZE_1MB, which has never existed in the kernel. Remove
this dead code.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/hexagon/include/asm/page.h    | 4 ----
 arch/hexagon/include/asm/pgtable.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 6d82572a7f21..6eac99438e3f 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -28,10 +28,6 @@
 #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_256KB
 #endif
 
-#ifdef CONFIG_PAGE_SIZE_1MB
-#define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_1MB
-#endif
-
 /*
  *  These should be defined in hugetlb.h, but apparently not.
  *  "Huge" for us should be 4MB or 16MB, which are both represented
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 27b269e2870d..0c62df423a1d 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -89,10 +89,6 @@
 #define PTRS_PER_PTE 16
 #endif
 
-#ifdef CONFIG_PAGE_SIZE_1MB
-#define PTRS_PER_PTE 4
-#endif
-
 /*  Any bigger and the PTE disappears.  */
 #define pgd_ERROR(e) \
 	printk(KERN_ERR "%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__,\
-- 
2.43.0

