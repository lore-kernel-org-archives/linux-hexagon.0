From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 21/29] sh: implement flush_icache_user_range
Date: Fri, 15 May 2020 16:36:38 +0200
Message-ID: <20200515143646.3857579-22-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3bgjHBt5jDLELtVeoaM1eNLq4RdOdC1sIUbPCNr5dBM=; b=PY5DcSMBF8f0ibSo7jAy9FC3+S
        mAwyl4WKUmR73DT7SYrYFWoVLUegLr2gkrn5MPisJgUjQWsi7AzbRTl3L6pQSxmsIAkg9i6ldUhCH
        d6BxDhcvbUuSgZ9ypdbU5r8Xau900ZIFKMu9JBx2MS9j5ICAVxS9WvLf9pWizvR2B6R96dXt8AR2Q
        01A9xcXTQ9cWl2jOVc+OZ4B9JpyY3jOmt8uknU/c+CvtdPMjw6EoqmFE9/HsvGI5ZKUrmXsv9F+1P
        nDQ7gtKObDdBQxDwDHAe60zv1pZnX36cZFNCaDfiZI61zGQ2CxfcYJQ4Wlaf2liB9HWOzfZVk6RhB
        JTJqlRyg==;
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

The SuperH implementation of flush_icache_range seems to be able to
cope with user addresses.  Just define flush_icache_user_range to
flush_icache_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/cacheflush.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index b932e42ef0284..fe7400079b97b 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -46,6 +46,7 @@ extern void flush_cache_range(struct vm_area_struct *vma,
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *page);
 extern void flush_icache_range(unsigned long start, unsigned long end);
+#define flush_icache_user_range flush_icache_range
 extern void flush_icache_page(struct vm_area_struct *vma,
 				 struct page *page);
 extern void flush_cache_sigtramp(unsigned long address);
-- 
2.26.2

