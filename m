From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/31] asm-generic: don't include <linux/mm.h> in cacheflush.h
Date: Sun, 10 May 2020 09:54:47 +0200
Message-ID: <20200510075510.987823-9-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=INn4CtVqYhB5mCs8+6rhyM+JLlbdj/x9vTgOvRuFchU=; b=Sg0UDw1w5Rayw8JxN+k3lD3azg
        F3LeJA2/NA5rszW6L3bzCrDJXtE6EYULe7GCZftRW+QajvPEaOnjbzGVwfOBNuqPACprzdRviAmaz
        S+sHnwIfQVWKsYOX5X9bFoG3LRFun2LeegZtne7Zn0gjo40GSq0VynMuje/ns9TcGFevaXQCehbqC
        46/TtfsAa3m3mTbp2v2h/j9RjHXcoUHFNAqvM5y854a74KoqPzQGYg8Ujm4SDbizp9Vw47R04MTUf
        YK7yk0frjTctX3aWY011R8+bXrWx4QW+UhAD/NEPVGv+ow8wIUHtdIaqv0zmgcQ1o75L3D0sfJt+T
        VFLY3xcw==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

This seems to lead to some crazy include loops when using
asm-generic/cacheflush.h on more architectures, so leave it
to the arch header for now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/include/asm/tlb.h         | 2 ++
 arch/x86/include/asm/cacheflush.h | 2 ++
 include/asm-generic/cacheflush.h  | 3 ---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
index 70ee603839006..ff9c62828962c 100644
--- a/arch/um/include/asm/tlb.h
+++ b/arch/um/include/asm/tlb.h
@@ -2,6 +2,8 @@
 #ifndef __UM_TLB_H
 #define __UM_TLB_H
 
+#include <linux/mm.h>
+
 #include <asm/tlbflush.h>
 #include <asm-generic/cacheflush.h>
 #include <asm-generic/tlb.h>
diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 63feaf2a5f93d..b192d917a6d0b 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_CACHEFLUSH_H
 #define _ASM_X86_CACHEFLUSH_H
 
+#include <linux/mm.h>
+
 /* Caches aren't brain-dead on the intel. */
 #include <asm-generic/cacheflush.h>
 #include <asm/special_insns.h>
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 906277492ec59..bf9bb83e9fc8d 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,9 +2,6 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
 
-/* Keep includes the same across arches.  */
-#include <linux/mm.h>
-
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
 
 /*
-- 
2.26.2

