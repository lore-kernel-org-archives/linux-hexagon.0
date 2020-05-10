From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 24/31] xtensa: implement flush_icache_user_range
Date: Sun, 10 May 2020 09:55:03 +0200
Message-ID: <20200510075510.987823-25-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h1wlmdmJ+SbuSyPJIzXhJQXOtYNYFSmh0yN4ZKBWMKk=; b=lfX0+X5PBMIFZiffuU4usV1LLT
        8RwgCLh11SKaJzMwL/11PCBnwFU0RQmjNSM74OctGeL3iXSNdBRM2pyO/36qGG76fJ5G552PdDpua
        BiK4yXJUaQatBqA9eHDbmu6QdyxrOSn0CjzKHla0vqDE8pa8bnvLPGm4YeJ9hp/w7DS8gwelEvGxh
        yRMp6Z6/B7l0lgC4bjLF0g7JJQE9qUw+/mqBYg2+w7zJH+6v/258QkcJYr6m/lXu5Gs3M46GvxiCd
        gY7QyyTZxvqtz0G0Wv/Z5SOB0WROnYjbKKAWVMgW1ywN/QbFCMC2PXE1Sd+HYOoRXI/7JYyWxOoeH
        nH8NIhgA==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

The Xtensa implementation of flush_icache_range seems to be able to
cope with user addresses.  Just define flush_icache_user_range to
flush_icache_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/cacheflush.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index a0d50be5a8cb1..460e666ad0761 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -107,6 +107,8 @@ void flush_cache_page(struct vm_area_struct*,
 #define flush_cache_page  local_flush_cache_page
 #endif
 
+#define flush_icache_user_range flush_icache_range
+
 #define local_flush_cache_all()						\
 	do {								\
 		__flush_invalidate_dcache_all();			\
-- 
2.26.2

