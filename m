From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/31] asm-generic: improve the flush_dcache_page stub
Date: Sun, 10 May 2020 09:54:48 +0200
Message-ID: <20200510075510.987823-10-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nX/OxofzDc3fd8yYsXOf0skifLYVUPlkWiksPKDCM7I=; b=TpZbr36sANtLkJvaxuIu9aM1KW
        oFrz3VJ8TKCFIfHGzIiUCULvUWWsc1FxymJvvH8drRJ/X1w1aXjvV6yzLqwB4Z0DZUKMIJKi+lI6U
        nyI+awV3bFWK24fHQ4FBnkZMIJzGo//5yhrw6Tvopim9t0SDjG2NOfxtBOGSgX7Z05ij05ckfhQkC
        ZLJV75ZK4xlfHir11InzLMsareiwxBndphxx0tHFSOyPvjU80XFlwKqGbd4QrnmfdrnnhSsTfWF7e
        S7hPZVHtB3AM5Chq3D53XXM0bUivy48c760lElDacqcTAFpdLnl59s2i7QPtXQ/HQnlw2Bz2JA/Yr
        rvU3E8zQ==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-mips-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

There is a magic ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE cpp symbol that
guards non-stub availability of flush_dcache_pagge.  Use that to
check if flush_dcache_pagg is implemented.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/cacheflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index bf9bb83e9fc8d..bbbb4d4ef6516 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
 
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
