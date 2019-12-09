From: Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 0/2] Hexagon fixes
Date: Mon,  9 Dec 2019 14:29:54 -0800
Message-ID: <20191209222956.239798-1-ndesaulniers@google.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t/1UStflpkba+9ZUNaSHKODK6B51M8rcDxieTuoYA4M=;
        b=gm9HwVK6fxD5suhOgCk7Tqmkef4vDSdqxt5K56QTUcNLFn1QZxRucbsJCBO5HXWsIJ
         sXBCidhNZIdgVhpJ4q9N208byXFqFjIenM5TCJoAty96z/QTJxUfLcshXlCan1Kmix4s
         O0LahjEnCOuKXPGayOFyTifTWvtYWP9dMXGZC/QiO+foAjPrABjJ2dktvJfTC0CsZmYG
         ZJy7Ha9i6tHEx13CClFg5S01ki+Kamb6Ruso+dGhqEZhJ1Yc/r1lppNmuGUnXNq8bddm
         ERMeXa8CH6HC4wcnpE1ppR7i5xJCgdRqPxOzcEDt922796CspxnpGDklNHqLfk4psCci
         6Jtw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@codeaurora.org
Cc: Nick Desaulniers <ndesaulniers@google.com>, lee.jones@linaro.org, andriy.shevchenko@linux.intel.com, ztuowen@gmail.com, mika.westerberg@linux.intel.com, mcgrof@kernel.org, gregkh@linuxfoundation.org, alexios.zavras@intel.com, allison@lohutok.net, will@kernel.org, rfontana@redhat.com, tglx@linutronix.de, peterz@infradead.org, boqun.feng@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, geert@linux-m68k.org, linux-hexagon@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org

Fixes 2 warnings when trying to build hexagon with Clang:
$ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu- make -j71 \
  CC=clang AS=clang LD=ld.lld AR=llvm-ar

Fixes -Winline-asm and -Wimplicit-function-definition.

Nick Desaulniers (2):
  hexagon: define ioremap_uc
  hexagon: parenthesize registers in asm predicates

 arch/hexagon/include/asm/atomic.h   |  8 ++++----
 arch/hexagon/include/asm/bitops.h   |  8 ++++----
 arch/hexagon/include/asm/cmpxchg.h  |  2 +-
 arch/hexagon/include/asm/futex.h    |  6 +++---
 arch/hexagon/include/asm/io.h       |  1 +
 arch/hexagon/include/asm/spinlock.h | 20 ++++++++++----------
 arch/hexagon/kernel/vm_entry.S      |  2 +-
 7 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog

