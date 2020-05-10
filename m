From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 22/31] asm-generic: add a flush_icache_user_range stub
Date: Sun, 10 May 2020 09:55:01 +0200
Message-ID: <20200510075510.987823-23-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Va/n37rYCuAAoV36whN9eOvE6XYTvehBkXPYj8DvT9g=; b=Usj2wN1plegQb5kK/z8yEvAPtD
        pKwFWkquIlrBQxUaK3+7Q0UvhcaNGaIo1Vw9g2ixpudxAmrHyvmm7w7+pnQTUCauDOCQWrl77gIY8
        JJvPXOjffu2DCkPu0sOjOatlrG0v+OYuWsB+sb1uxgL770BCpg/kw/5W4Lj20epVcYSt8kiZkwIhs
        eCxBhx5/XrpKoAeIxCR50uB4m1xBy/d4PtuXXfpgBmbNy684hmm1T0LinQMieeljCQMt40Iw0tucd
        IWuG+Gl6EdCqsw6M0RzlX4TDvFWgGY4SY244LJ2ke7yY+LRc4yTKa4pqgq/kNTx6wF0gQWIx1bAtC
        t5Cyja2A==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

Define flush_icache_user_range to flush_icache_range unless the
architecture provides its own implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/cacheflush.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 2c9686fefb715..907fa5d164944 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -66,6 +66,10 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 }
 #endif
 
+#ifndef flush_icache_user_range
+#define flush_icache_user_range flush_icache_range
+#endif
+
 #ifndef flush_icache_page
 static inline void flush_icache_page(struct vm_area_struct *vma,
 				     struct page *page)
-- 
2.26.2

