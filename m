From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/21] alpha: remove the unused __ioremap wrapper
Date: Tue, 29 Oct 2019 07:48:18 +0100
Message-ID: <20191029064834.23438-6-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mY7k88LdHSyLOjPzk/T6g8ct/OJWddzbOrfk0liZR+I=; b=YfZGqVfAie+1eOlgbM6fW/GZMo
        Xg1RyexTks4UpgWHmYdUMDBCvjF6csLCJFbqKjgZC2/OhqjMj5zTRoPsiNZqOx0VDZffXVh5Gub1A
        vMZR4CHsN/k7ZWXe7+KLgzMzkmtTx2f1OCqcamdKtA18IkFrGDHi1IDxmURfcenMKWF4JqY6VW4b5
        KJAGXYtcFH5Z2Y80MfDsTLzoI1UnDLG7LDlx0EKNzVclOz0sIww+5oLdaIMr9S27Q6bgItw2Sr4Dn
        0OglTnWnuOfR7B1ednv5AQaFZt9XMISu9j3mEtAUre/ccTQuGm6Z2JtwswuexVGwPwLenhh6+iv9t
In-Reply-To: <20191029064834.23438-1-hch@lst.de>
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

