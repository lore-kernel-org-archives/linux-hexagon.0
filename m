From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/21] alpha: remove the unused __ioremap wrapper
Date: Thu, 17 Oct 2019 19:45:38 +0200
Message-ID: <20191017174554.29840-6-hch@lst.de>
References: <20191017174554.29840-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mY7k88LdHSyLOjPzk/T6g8ct/OJWddzbOrfk0liZR+I=; b=fdN6u+CEf+vSmm16FmpHqQHa76
        nopBqUx5+Rd/wnZqw6hStkVt5b2OBTGkF1xfxsjTyLwm9MipA/4ybAxP6iDhXuj15bjLWI9U97CDO
        bhsROLnOeIFIL16IKhkI68KAEOXpPb1Q6A9Leu35T4wJ+8DTkNXzBKoCZ9tEOe0fPYCdSj/tXeiDK
        2gJaVdzq1OmbNcgSJV/ahbJ1GaHx7l4ZJWBSE3/HaPrRQzt3+d4DFhONNgqG+BgRr7Ul3N6DI9FpP
        aC9v74GOkB87MmMYhXyjtdAADhHsAbFA57z25HEBAelUC9tqCWcDXZXJhktyY7SkqRVCjkUP0kVAJ
In-Reply-To: <20191017174554.29840-1-hch@lst.de>
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

