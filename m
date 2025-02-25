Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC977FD
	for <linux-hexagon@vger.kernel.org>; Tue, 25 Feb 2025 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455182; cv=none; b=U3TFokol3+zaIXpX8k1PF/h5IkuCtXhctsXOqJmaoLwzr8hx4JfLxtBH8PkGNxiQsgJiLyKcbxlf3JmxaGoSG4aldv4uOxzaW0h7xKviDhUset4gAlqV4Af+KYZmXi1GYER6k7iNzrfJiddy1aTdq8KbPcFTdVdeamaWBVGa+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455182; c=relaxed/simple;
	bh=Xarqt6bJuNP7uDohIoZXfOCmOa/TOsimsTJDUmQhEAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mpEx7Xma5QmuG2iADI/Xkj/4MDIV8DbDO8/+1HEFVaDwi3wgWapOvwncyavgnYnaaNm/zKqDNQJFxJw8fldQXHIMxeXmzQrFpfHJjMvLCdr0xPMalW6xwt39pXspo1NaAq/qKIpt59EtUWpt5c7VvP14z+skWsJpTpPV2ANBDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gdYlHQw6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gdYlHQw6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so107886915ad.0
        for <linux-hexagon@vger.kernel.org>; Mon, 24 Feb 2025 19:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455179; x=1741059979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28rhiB/GEX2aHidRfZsL1f1ynE4sxX3e1xrVD+t+cg0=;
        b=gdYlHQw6UMjvN66luBcJmpWC6mmBua2s+rF8MRPWFK89E4pqFtOL2sKZqJrZVhYeoi
         h0Az2B5W1RBkBDeXejxczzYtLaSHKgpaSe5nUZHyxE0sWPvVQ7egJNVQDD1ys4IP3awN
         qLM6wTWZZd+dWGjMGYn1T6VnY11ntvSuzT5g+i2JYvUa/QhroLjt1YE7cACEwy43Tlpv
         jo0AVkh3/z21TprOUpO6VJXxdZ5N+k1uTSGjpctRfwQfY+oc+T1qk2RWReDM4epWndH4
         L/VBJ1fD2gDNNbcNJZPmjF1uMUrsJieVg2ui5gAb/yK4rfTB3LlvdY6TbmJofmZ5KAbk
         G/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455179; x=1741059979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28rhiB/GEX2aHidRfZsL1f1ynE4sxX3e1xrVD+t+cg0=;
        b=Bt8pQEr+9A09Ikyj80P43hB+RAv6GvB+QoCEA4q0pQR6OTFpg+xbvcjIPhDzrWlwTw
         3my0G61+zYP+2RZJwii48h7KQ9+p0E8Mi+ZV6ijWSMcRV2iCZMrprCJlUU2AEAYh1L3P
         SxLAej9/GovzGInfOI7pb0QQO5RXNDTjENuWbvGpYem8mWyPwqJIorfYtU0ybSmM54ea
         Qu4GrFcbW+/ZIKNla84NWxWc8cu75H4+CfvY7zT1NRKfNoLX9gIiXbDtzbPNs/U+z05C
         OKup798D8s97QQOx0cHsPoCYqDE5VwWIqVoKHnAoC7FpwacrUSKeNMQYmtggZvSRJKmD
         UfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqmZID6VKs5+imXOgS2qEeYFE9ahRYj2qR6inT81qDBIwMccZo9Bkze2coMLVaXlDxi/bABhgeSU2ZoInu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17yn+Wfbn9h8PAG+dO9kG6xuz13nlMNMfRDMvqYUU37GdtLSV
	x0RkzowouCC9ig6Drhk2R34yAMFI2LD7bKEbW7Sl+Mxy73smdf/6/lVJzh+q+Uo=
X-Gm-Gg: ASbGnctd0xJu5cL3y1P88htq7X9ZhpAONHkizqcdxhX3trC5gnM3qjKp2D5qSYrLh63
	HnG2awjTmUUomi+lJcQwbCVVV30XlHieKS1axfZZFmM3TaQvmiZG9BhQlLTG9dy7IskaXkIOXa4
	8VYoDYY6pVwfW5X0bxDUdngbT/TCCLn+t2DmBBTCpx2B10S1MLRgeK+c7GR6+870Gqwv8SNTkQ4
	Fx7IcvNm3D8kibnfUDt14z0wPdxp7wC+H+PQr7wZPwX3k9YcAnhQ+ZIWQMbljJSGJFBmbsvnqIl
	2dUj2tcRDtieviJGMDXKRI7Cxn+LGszarS/ILP2y7M5bO2NzxOEHfpHmjEXLQ5dH7w==
X-Google-Smtp-Source: AGHT+IGCQV+aaAngRw7XrsDoRTV1d2A5MeKYpMO11TDMI4tHHu1SHT60kqvv/nxGByOS3x+4jf7H6Q==
X-Received: by 2002:a17:902:e744:b0:21f:89e5:2715 with SMTP id d9443c01a7336-221a0edd8cbmr248196785ad.19.1740455178926;
        Mon, 24 Feb 2025 19:46:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:18 -0800 (PST)
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
Subject: [PATCH v2 0/6] remove tlb_remove_page_ptdesc()
Date: Tue, 25 Feb 2025 11:45:50 +0800
Message-Id: <cover.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - add [PATCH v2 2/6] (Peter Zijlstra)
 - remove [PATCH 4/5] and add [PATCH v2 5/6]
 - rebase onto the next-20250224

Hi all,

As suggested by Peter Zijlstra below [1], this series aims to remove
tlb_remove_page_ptdesc().

: Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
: there should not be a page-table anywhere near here *ever*.
:
: Yes, some architectures use tlb_remove_page() for page-tables too, but
: that is more or less an implementation detail that can be fixed.

After this series, all architectures use tlb_remove_table() or tlb_remove_ptdesc()
to remove the page table pages. In the future, once all architectures using
tlb_remove_table() have also converted to using struct ptdesc (eg. powerpc), it
may be possible to use only tlb_remove_ptdesc().

This series is based on next-20250224.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/linux-mm/20250103111457.GC22934@noisy.programming.kicks-ass.net/

Qi Zheng (6):
  mm: pgtable: make generic tlb_remove_table() use struct ptdesc
  mm: pgtable: change pt parameter of tlb_remove_ptdesc() to struct
    ptdesc *
  mm: pgtable: convert some architectures to use tlb_remove_ptdesc()
  riscv: pgtable: unconditionally use tlb_remove_ptdesc()
  x86: pgtable: convert to use tlb_remove_ptdesc()
  mm: pgtable: remove tlb_remove_page_ptdesc()

 arch/csky/include/asm/pgalloc.h      |  3 +--
 arch/hexagon/include/asm/pgalloc.h   |  3 +--
 arch/loongarch/include/asm/pgalloc.h |  3 +--
 arch/m68k/include/asm/sun3_pgalloc.h |  3 +--
 arch/mips/include/asm/pgalloc.h      |  3 +--
 arch/nios2/include/asm/pgalloc.h     |  9 ++++-----
 arch/openrisc/include/asm/pgalloc.h  |  3 +--
 arch/riscv/include/asm/pgalloc.h     | 26 ++++----------------------
 arch/sh/include/asm/pgalloc.h        |  3 +--
 arch/um/include/asm/pgalloc.h        |  9 +++------
 arch/x86/mm/pgtable.c                |  8 ++++----
 include/asm-generic/tlb.h            | 14 ++++----------
 12 files changed, 26 insertions(+), 61 deletions(-)

-- 
2.20.1

