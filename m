From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 26/29] exec: use flush_icache_user_range in read_code
Date: Fri, 15 May 2020 16:36:43 +0200
Message-ID: <20200515143646.3857579-27-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9nkBbtmLvQl1eKzV5tIp1XNxgG4m4pb8wLV/D1oxyTY=; b=PrewDot91eBJtI4CmunBQt8auz
        5Qf471gFdXaMKcMey4uvcCm1/zMSb7AxBI1tT91bJJlRm1ScK54gyxd4uAUXCbf03WqD9x+ol2NOj
        UguMrDDZudEcN4LA49bcHmbdnURGtDw3k2BGxwBkRkR12N8iephTJqGeDSHQWQjM0Ow0WcLkL4gY/
        NvIyYhsyq46MDhXpWE2O/X2e5CfxR+BoufSX/GEsGPR4xUs6W136aHYY0NicjX+NzxB21IB+GLTNj
        zSG37nkB1058MbJlOxd8otsj2ePnMSqxje3+vd1BrLDKVnhnA+TDiS4ToD8fPt86HMsp5w6cR7CE2
        3eV0aDWg==;
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

read_code operates on user addresses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a4f766f296f8f..c541867316a63 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1033,7 +1033,7 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
 	if (res > 0)
-		flush_icache_range(addr, addr + len);
+		flush_icache_user_range(addr, addr + len);
 	return res;
 }
 EXPORT_SYMBOL(read_code);
-- 
2.26.2

