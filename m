From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] hexagon: Fix build error with CONFIG_STACKDEPOT and select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
Date: Thu, 20 May 2021 18:12:36 -0700
Message-ID: <20210521011239.1332345-1-nathan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621559600;
        bh=iidsKDzZJma0pYDtc53iw4RxEtwWIyBb9HtkkfDF2Xw=;
        h=From:To:Cc:Subject:Date:From;
        b=V/ORjQxoV0z/KlCNcZ8EuQZK7qJC7KEA+10B/eXO9RZJcIJlK0qUm0x4V+X1RvU59
         ZLtSYfkCwlQNewYSUXfdp6VWeLnUeA8MgrmYyoieT1bqxZ6uIKjC0P1UqMGMDMAsDi
         iu2xOIZbBWwWl5QIiwWC9yUdcsdMthedx7zM3OZ4w84AGYGf3yy/DYmKDuAoqcUybn
         stNENRxkB+vqLQIOcPFo5up4ynA1Kf/3JHa2qCjaz6wTfdr9PXvJj6tszuIiVUfQH5
         tRCyPCMvyW+cdXvPOo/L8iaTM1OVbuFwmfCIqUFIWRGc7bLAd7KXC4IsuZrcvH8Igj
         I7RIsTZ0sL4MA==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Brian Cain <bcain@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <nathan@kernel.org>

Hi all,

This series fixes an error with ARCH=hexagon that was pointed out by
the patch "mm/slub: use stackdepot to save stack trace in objects",
which is in -mm/-next.

The first patch fixes that error by handling the '.irqentry.text' and
'.softirqentry.text' sections.

The second patch switches Hexagon over to the common DISCARDS macro,
which should have been done when Hexagon was merged into the tree to
match commit 023bf6f1b8bf ("linker script: unify usage of discard
definition").

The third patch selects CONFIG_ARCH_WANT_LD_ORPHAN_WARN so that
something like this does not happen again.

Nathan Chancellor (3):
  hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
  hexagon: Use common DISCARDS macro
  hexagon: Select ARCH_WANT_LD_ORPHAN_WARN

 arch/hexagon/Kconfig              | 1 +
 arch/hexagon/kernel/vmlinux.lds.S | 9 +++------
 2 files changed, 4 insertions(+), 6 deletions(-)


base-commit: 7a42b92b6d30c3f09629c7d5ada9e3de2aba01af
-- 
2.32.0.rc0

