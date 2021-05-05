From: bcain@codeaurora.org
Subject: [GIT PULL] hexagon changes for v5.13
Date: Wed, 05 May 2021 16:09:59 -0500
Message-ID: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620249018; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=ljqGh4vdZ4x6txKvkOy9TSMun4WY4aIky27Q4tklUF4=; b=BSckRQp6dQmX8tD83uSwpnCRm1PmQU4BbBPmBbbi59u+G5PAv3m9NfsoONxkgC/3ObQ7vt8Z
 7Z14nZKMSwb5oWxCorMJ+zh/bUA2bgaULKDDjhs6ZRhbfvuPNiBooMb8ssF4IgmbyRjVZvNH
 XAA576YhzLnMvvhbaZcad55EceU=
Sender: bcain=codeaurora.org@mg.codeaurora.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-hexagon <linux-hexagon@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: sidneym@codeaurora.org, 'clang-built-linux' <clang-built-linux@googlegroups.com>

Linus,

Please pull the following changes for Hexagon: they contain build fixes.

Thanks,
-Brian

===


The following changes since commit 
9ccce092fc64d19504fa54de4fd659e279cc92e7:

   Merge tag 'for-linus-5.13-ofs-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux (2021-05-02 
14:13:46 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux 
tags/hexagon-5.13-0

for you to fetch changes up to f1f99adf05f2138ff2646d756d4674e302e8d02d:

   Hexagon: add target builtins to kernel (2021-05-03 11:04:22 -0500)

----------------------------------------------------------------
Hexagon architecture build fixes + builtins

Small build fixes applied:
- use -mlong-calls to build
- extend jumps in futex_atomic_*
- etc

Also, for convenience and portability, the hexagon compiler builtin
functions like memcpy etc have been added to the kernel -- following the
idiom used by other architectures.

----------------------------------------------------------------
Sid Manning (4):
       Hexagon: fix build errors
       Hexagon: change jumps to must-extend in futex_atomic_*
       Hexagon: remove DEBUG from comet config
       Hexagon: add target builtins to kernel

  arch/hexagon/Makefile                    |  6 +--
  arch/hexagon/configs/comet_defconfig     |  1 -
  arch/hexagon/include/asm/futex.h         |  4 +-
  arch/hexagon/include/asm/timex.h         |  3 +-
  arch/hexagon/kernel/hexagon_ksyms.c      |  8 ++--
  arch/hexagon/kernel/ptrace.c             |  4 +-
  arch/hexagon/lib/Makefile                |  3 +-
  arch/hexagon/lib/divsi3.S                | 67 
++++++++++++++++++++++++++++++++
  arch/hexagon/lib/memcpy_likely_aligned.S | 56 
++++++++++++++++++++++++++
  arch/hexagon/lib/modsi3.S                | 46 ++++++++++++++++++++++
  arch/hexagon/lib/udivsi3.S               | 38 ++++++++++++++++++
  arch/hexagon/lib/umodsi3.S               | 36 +++++++++++++++++
  12 files changed, 258 insertions(+), 14 deletions(-)
  create mode 100644 arch/hexagon/lib/divsi3.S
  create mode 100644 arch/hexagon/lib/memcpy_likely_aligned.S
  create mode 100644 arch/hexagon/lib/modsi3.S
  create mode 100644 arch/hexagon/lib/udivsi3.S
  create mode 100644 arch/hexagon/lib/umodsi3.S


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
