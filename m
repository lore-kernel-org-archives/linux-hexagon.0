From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/29] c6x: use asm-generic/cacheflush.h
Date: Fri, 15 May 2020 16:36:27 +0200
Message-ID: <20200515143646.3857579-11-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9OkRp1p3UvpvhrMloqYZ5BRhhjLRydsct9faQtkGwTk=; b=DdyZcp26/ow147BL9gUGZZnER7
        vcCTRmMp36OtMyz9pn19PFkols5p+Nj3kQQ+jlz3xQh4MH/sjs2KmvQIAZVQQceUPBHHlCJNPsBhE
        +V4VFDQRDsfz4ppjxrPcVC0i3Znl6X0WZ+eB02i4ZAUvjHiteAVQo16H/TU3CzVSOW9lJG0ALia4r
        ovxaKmklN2eUI0ytL0Xzw2pUigOnnXYHm4EAbYD4UjXdBFdaCsw5Eft4WE8hp7WGJOJZgD6A9e+WW
        z7TDLg9mqbBwkpvdSpQOyl6PRMV3rhIGbixYdQJOTjhWvpkxEleX4gG2HEIv1CzggF07ZucRfNtL/
        pgIYQmMA==;
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

C6x needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/c6x/include/asm/cacheflush.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/c6x/include/asm/cacheflush.h b/arch/c6x/include/asm/cacheflush.h
index 4540b40475e6c..10922d528de6d 100644
--- a/arch/c6x/include/asm/cacheflush.h
+++ b/arch/c6x/include/asm/cacheflush.h
@@ -16,21 +16,6 @@
 #include <asm/page.h>
 #include <asm/string.h>
 
-/*
- * virtually-indexed cache management (our cache is physically indexed)
- */
-#define flush_cache_all()			do {} while (0)
-#define flush_cache_mm(mm)			do {} while (0)
-#define flush_cache_dup_mm(mm)			do {} while (0)
-#define flush_cache_range(mm, start, end)	do {} while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do {} while (0)
-#define flush_cache_vmap(start, end)		do {} while (0)
-#define flush_cache_vunmap(start, end)		do {} while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do {} while (0)
-#define flush_dcache_mmap_lock(mapping)		do {} while (0)
-#define flush_dcache_mmap_unlock(mapping)	do {} while (0)
-
 /*
  * physically-indexed cache management
  */
@@ -49,14 +34,12 @@ do {								  \
 			(unsigned long) page_address(page) + PAGE_SIZE)); \
 } while (0)
 
-
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do {						     \
 	memcpy(dst, src, len);			     \
 	flush_icache_range((unsigned) (dst), (unsigned) (dst) + (len)); \
 } while (0)
 
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
 
 #endif /* _ASM_C6X_CACHEFLUSH_H */
-- 
2.26.2

