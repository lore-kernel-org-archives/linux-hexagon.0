Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6BE2B2CF
	for <linux-hexagon@vger.kernel.org>; Mon, 23 Dec 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946986; cv=none; b=Vavse54mJw5LxWEt38hzF1lPMkU5fgirPsRilSH03/DH4Yhc9aYBDhgaSyxB/TUxF4wH/kkFwU38HmVM2p5Zy/ub7yKHULHqUIl4+7/GuOu3beNa4O7MKq3mO3noBrKlmHXWkd1DoKw5Nx6F4NscPRSeyIi2UWeiVoRxg0tZ1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946986; c=relaxed/simple;
	bh=5DVWBpP0g56PPJYmylzu2Hks40MXN3PGLVlL7LXCmXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nk0/Di71sGdRlNbkeYLICyXs/Q62Q6PNA2zdi+YWYTBVyDtwvSILc9/YvV6hPki4VrgBycoxGwcSGGVkxSbuuW5NGkeuhhG3EK9jPlCgo+uoihOwXdFnxwsVfh36sFChgKwXsHliqUWG7sSWuh0aR6DdClg3+6noLI35329zZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ECfUJiCQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ECfUJiCQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725d9f57d90so2878588b3a.1
        for <linux-hexagon@vger.kernel.org>; Mon, 23 Dec 2024 01:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734946983; x=1735551783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hW6jy85GFxw1rlbhA2IQSgcMmC6SEwxIAu1eEJQsQ+g=;
        b=ECfUJiCQSpJvmFKz3DajE46aG33PzuquigEytgEH2yGkovnRFaV/TLRHfMJMM38kGv
         Bvjk6CAbOJsq0VQme73o5MW7sWga5uSklaVBDGgP+zHt65qMgT3Ww0HslULSC+d32Fzx
         gK29xAriBNESCtd1ZXRprQ+RklgrC5HXbB+dLJSRGHNeizus4YD7j1GIAEArteshudIs
         L5ww5ZOsb4lLtkp0Ut1TUu9h0qfj90h7UhUefN82Yc6+7bVZjohD+MXB8y2N2u6XcpZl
         BREbv5nM0NQuKkWEvmuN1+aigiEJv/xLoK9krp6PCAKLm53MGyWUONdwzdtZ+l+sZoy1
         OAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946983; x=1735551783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hW6jy85GFxw1rlbhA2IQSgcMmC6SEwxIAu1eEJQsQ+g=;
        b=i+T+YwsgUblcR8hFUocFNTbCAxQYfJwN2q3A+uKXMtR4yCOfkPkxb64qYntJDymL+H
         Mn3XL6nGdeY5GF/6b9UjYIbZdAVMO25lRX0dvhypfXgJuvuZmUFD7/gj3Hd3KMSpVoSP
         Ijsc1QPGyFprA/wyMWJD+480go2Vm8layUoHMn8hircrd4rpSz+ukQttmWK44a1ivJvf
         6nkdtZFMprU1SjCs2KJIGUrG/RCDp22eamDSps/DH3UU/0nGHrHM0DkC7oM7GoP22eif
         645QGUDi+JjmyaIJDtPRyX5N9+Gt67Vm6NmEwtuOs6Phfi9KyP2Y+akb1nkDgH7gQWCD
         cjEw==
X-Forwarded-Encrypted: i=1; AJvYcCVGOcgzH7A59AIzEfJki4BnQwOoAr0AtDiK75sCNNdeTuHRDPAhXv1OFuq+g+z2YrUDxKLK/tp+4FEEQXZu@vger.kernel.org
X-Gm-Message-State: AOJu0YwkC7Z0/+MhHoCMGpnyB1prCIoZf9QG511NtXib0/HpdCozj6Mi
	DQgBg2KlrZQ72Jj98sqCY/lsuQRgN563z+Ek56aiP/zWuwfvnRYoIgwZEGXm7fQ=
X-Gm-Gg: ASbGncsm5kDihbEaFRGwbtFpKpWAVh3wmeHgKHtXsuG5dK8+tycA65CBkzHbG75lpzg
	Z58PTSAZAIaCvEFaoXOAPRdHLlpDyTQY3aQlMjbUTKAyy5vf9IYYg+YOch3IoF/1Jh2FOW3araI
	KkQdIP8dfgA2GD5LojXqstc/VEKPfvy3365fll3LjKRAUpLTXMPCX3ZiPojexeNC9cMccFu1704
	jI4x1e9MQzbA/kRFibJzTzmnIH/vOPI/ThxniOwn8948lwbzNeiG9l+h/DjgneI8YqOOoNX4ps0
	b5V51pD6rfvaZ9kPrS47NA==
X-Google-Smtp-Source: AGHT+IFRta8/SfQvcBY4OAtIB9mripqs4z6X28qqGG6H0nQGOiKq9bgrNZS2epuvDdaQMCTGZ3ooIw==
X-Received: by 2002:a05:6a21:4986:b0:1e1:b1bb:87a0 with SMTP id adf61e73a8af0-1e606dfe60fmr3973055637.34.1734946982984;
        Mon, 23 Dec 2024 01:43:02 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:02 -0800 (PST)
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
Subject: [PATCH v3 00/17] move pagetable_*_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:46 +0800
Message-Id: <cover.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - take patch #5 and #6 from Kevin Brodsky's patch series below.
   Link: https://lore.kernel.org/lkml/20241219164425.2277022-1-kevin.brodsky@arm.com/
 - separate the statistics part from [PATCH v2 02/15] as [PATCH v3 04/17], and
   replace the rest part with Kevin Brodsky's patch #6
   (Alexander Gordeev and Kevin Brodsky)
 - change the commit message of [PATCH v2 10/15] and [PATCH v2 11/15]
   (Alexander Gordeev)
 - fix the bug introduced by [PATCH v2 11/15]
   (Peter Zijlstra)
 - rebase onto the next-20241220

Changes in v2:
 - add [PATCH v2 13|14|15/15] (suggested by Peter Zijlstra)
 - add Originally-bys and Suggested-bys
 - rebase onto the next-20241218

Hi all,

As proposed [1] by Peter Zijlstra below, this patch series aims to move
pagetable_*_dtor() into __tlb_remove_table(). This will cleanup pagetable_*_dtor()
a bit and more gracefully fix the UAF issue [2] reported by syzbot.

```
Notably:

 - s390 pud isn't calling the existing pagetable_pud_[cd]tor()
 - none of the p4d things have pagetable_p4d_[cd]tor() (x86,arm64,s390,riscv)
   and they have inconsistent accounting
 - while much of the _ctor calls are in generic code, many of the _dtor
   calls are in arch code for hysterial raisins, this could easily be
   fixed
 - if we fix ptlock_free() to handle NULL, then all the _dtor()
   functions can use it, and we can observe they're all identical
   and can be folded

after all that cleanup, you can move the _dtor from *_free_tlb() into
tlb_remove_table() -- which for the above case, would then have it
called from __tlb_remove_table_free().
```

And hi Andrew, I developed the code based on the latest linux-next, so I reverted
the "mm: pgtable: make ptlock be freed by RCU" first. Once the review of this
patch series is completed, the "mm: pgtable: make ptlock be freed by RCU" can be
dropped directly from mm tree, and this revert patch will not be needed.

This series is based on next-20241220. And I tested this patch series on x86 and
only cross-compiled it on arm, arm64, powerpc, riscv, s390 and sparc.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20241211133433.GC12500@noisy.programming.kicks-ass.net/
[2]. https://lore.kernel.org/all/67548279.050a0220.a30f1.015b.GAE@google.com/

Kevin Brodsky (2):
  riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
  asm-generic: pgalloc: Provide generic p4d_{alloc_one,free}

Qi Zheng (15):
  Revert "mm: pgtable: make ptlock be freed by RCU"
  mm: pgtable: add statistics for P4D level page table
  arm64: pgtable: use mmu gather to free p4d level page table
  s390: pgtable: add statistics for PUD and P4D level page table
  mm: pgtable: introduce pagetable_dtor()
  arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
  arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
  riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
  x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
  s390: pgtable: also move pagetable_dtor() of PxD to
    __tlb_remove_table()
  mm: pgtable: introduce generic __tlb_remove_table()
  mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
  mm: pgtable: remove tlb_remove_page_ptdesc()
  mm: pgtable: remove tlb_remove_ptdesc()
  mm: pgtable: introduce generic pagetable_dtor_free()

 Documentation/mm/split_page_table_lock.rst |  4 +-
 arch/arm/include/asm/tlb.h                 | 18 +-----
 arch/arm64/include/asm/pgalloc.h           | 18 ------
 arch/arm64/include/asm/tlb.h               | 31 ++++-----
 arch/csky/include/asm/pgalloc.h            |  4 +-
 arch/hexagon/include/asm/pgalloc.h         |  4 +-
 arch/loongarch/include/asm/pgalloc.h       |  4 +-
 arch/m68k/include/asm/mcf_pgalloc.h        |  4 +-
 arch/m68k/include/asm/sun3_pgalloc.h       |  4 +-
 arch/m68k/mm/motorola.c                    |  2 +-
 arch/mips/include/asm/pgalloc.h            |  4 +-
 arch/nios2/include/asm/pgalloc.h           |  4 +-
 arch/openrisc/include/asm/pgalloc.h        |  4 +-
 arch/powerpc/include/asm/tlb.h             |  1 +
 arch/powerpc/mm/book3s64/mmu_context.c     |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c         |  2 +-
 arch/powerpc/mm/pgtable-frag.c             |  4 +-
 arch/riscv/include/asm/pgalloc.h           | 75 ++++++----------------
 arch/riscv/include/asm/tlb.h               | 18 ------
 arch/riscv/mm/init.c                       |  4 +-
 arch/s390/include/asm/pgalloc.h            | 31 ++++++---
 arch/s390/include/asm/tlb.h                | 43 ++++++-------
 arch/s390/mm/pgalloc.c                     | 31 ++-------
 arch/sh/include/asm/pgalloc.h              |  4 +-
 arch/sparc/include/asm/tlb_32.h            |  1 +
 arch/sparc/include/asm/tlb_64.h            |  1 +
 arch/sparc/mm/init_64.c                    |  2 +-
 arch/sparc/mm/srmmu.c                      |  2 +-
 arch/um/include/asm/pgalloc.h              | 12 ++--
 arch/x86/include/asm/pgalloc.h             | 18 ------
 arch/x86/include/asm/tlb.h                 | 33 ----------
 arch/x86/kernel/paravirt.c                 |  1 +
 arch/x86/mm/pgtable.c                      | 13 ++--
 include/asm-generic/pgalloc.h              | 60 +++++++++++++----
 include/asm-generic/tlb.h                  | 23 +++----
 include/linux/mm.h                         | 52 ++++++---------
 include/linux/mm_types.h                   |  9 +--
 mm/memory.c                                | 23 ++-----
 mm/mmu_gather.c                            | 19 +++++-
 39 files changed, 228 insertions(+), 361 deletions(-)

-- 
2.20.1

