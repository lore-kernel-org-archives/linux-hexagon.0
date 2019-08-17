From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/26] alpha: remove the unused __ioremap wrapper
Date: Sat, 17 Aug 2019 09:32:36 +0200
Message-ID: <20190817073253.27819-10-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mY7k88LdHSyLOjPzk/T6g8ct/OJWddzbOrfk0liZR+I=; b=XHFasxajBzEOduBGF2F4Hh+9po
        ANe8eJKc+3gqN4ZnGqlV9LbyZTnJ3W6boG+fyAyMSbGYf1tLuOGZPVTJnn7aZpyz8nixWF9BWBV8+
        qh7I2lllbyz5piJAdAKGpf8YOXlWV0OufY88ET0ooeCJKAr2vqY1G7gShmI7WNzattGtm6ypMhSUd
        ltoQRjch9aLls67klHNxxU7QlRGIaFXnzpdZBl+W1IcbS0rKbObi5HqhC045NMGAPEJusiWSwwWnT
        oAnJkbL3zHrG6Qa4fBSb5bLuLHGo40FUXIgEcbZs/rZz1vtNYOmRj5aXrqw3rx35Yk+nU3QUX60R1
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

No need for the additional namespace pollution.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/io.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index af2c0063dc75..1989b946a28d 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -283,12 +283,6 @@ static inline void __iomem *ioremap(unsigned long port, unsigned long size)
 	return IO_CONCAT(__IO_PREFIX,ioremap) (port, size);
 }
 
-static inline void __iomem *__ioremap(unsigned long port, unsigned long size,
-				      unsigned long flags)
-{
-	return ioremap(port, size);
-}
-
 static inline void __iomem * ioremap_nocache(unsigned long offset,
 					     unsigned long size)
 {
-- 
2.20.1

