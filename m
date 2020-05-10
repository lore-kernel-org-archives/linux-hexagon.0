From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/31] powerpc: unexport flush_icache_user_range
Date: Sun, 10 May 2020 09:54:44 +0200
Message-ID: <20200510075510.987823-6-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Z9YRs5dLpbvo98tj/Cgt22OOiGK6aHhMzE6epEWfQXc=; b=M6E6jT1vTAkcc/uqCv5rRZBqVj
        4C9y1DKz9zmQassTsueu8yWQtNmiSAw2Hqc+MF/e1W//UGZoTW7Mkhlj5xO2Sw8y6kKhWH6Lxu081
        RTOiKkdeaCdvxRpTIMXxDZX2l/SD61dJ1ht3dJUMAZ5fSZztKAueD6GAhmW6p58R92s+FRj6moa0W
        MW6rCeXcQQ1sGtgtL8vI274YEWPu36qdr9qupNELF/8k4VcjiFVOld/2i3HBkugH4PB6MhS+BWh7/
        W8A67yIAP6eHosepHe+pXuDHyaVjcFfcdRZzmDftL4nnPz9Dlr8KupBRqGGJq8mtr1f9Lr6VMYOde
        +ETCOrfw==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

flush_icache_user_range is only used by copy_to_user_page, which is
only used by core VM code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/mm/mem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 041ed7cfd341a..f0d1bf0a8e14f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -587,7 +587,6 @@ void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	flush_icache_range(maddr, maddr + len);
 	kunmap(page);
 }
-EXPORT_SYMBOL(flush_icache_user_range);
 
 /*
  * System memory should not be in /proc/iomem but various tools expect it
-- 
2.26.2

