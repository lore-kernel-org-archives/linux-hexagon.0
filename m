From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/31] asm-generic: fix the inclusion guards for cacheflush.h
Date: Sun, 10 May 2020 09:54:46 +0200
Message-ID: <20200510075510.987823-8-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TnbCkkwCrUJoVyKDF526uiErLGT3jwDipU5D/anO8xc=; b=mPKJUt58n7+nMzhhc54oH63pQM
        mqLu44nHNaFJZeW4BtfL3Nszeye3rc8YHdjDEjGf8xg3xzYYrSfHCY5nbabMfTBfeDSOkMMmS35ou
        LOq0Cm3ec2qhR34x6S9wtNGNeuufVaiFVNGQ6EA78N1lJbfLJVQOxwHBoVtXOUJ7LEM4LvpF30O3k
        m13ERlEUD8DKFhmebKzsLwdEd7rRAmNgmGpKczfhpk/gcktxKPPvNDkPqc0zvVEDL2Y0pohvODiyy
        vtpxm6SQgeQ2Ni9spFq2UDWdSqY4HMo95ucFjFiZLFQWqx3op44MZmPTFzx+L8rvvn5EzP4yrE2vp
        kheYPImQ==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

cacheflush.h uses a somewhat to generic include guard name that clashes
with various arch files.  Use a more specific one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/cacheflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index cac7404b2bdd2..906277492ec59 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_CACHEFLUSH_H
-#define __ASM_CACHEFLUSH_H
+#ifndef _ASM_GENERIC_CACHEFLUSH_H
+#define _ASM_GENERIC_CACHEFLUSH_H
 
 /* Keep includes the same across arches.  */
 #include <linux/mm.h>
@@ -109,4 +109,4 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 	memcpy(dst, src, len)
 #endif
 
-#endif /* __ASM_CACHEFLUSH_H */
+#endif /* _ASM_GENERIC_CACHEFLUSH_H */
-- 
2.26.2

