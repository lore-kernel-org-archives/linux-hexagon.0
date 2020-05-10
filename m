From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/31] MIPS: unexport __flush_icache_user_range
Date: Sun, 10 May 2020 09:54:42 +0200
Message-ID: <20200510075510.987823-4-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cJrBcFesCCHH++zA2oY5v0CcV8x8Hy3MLhhCCmCGutI=; b=Cg8ydy2JfxDHx5WmYnD7+gYELd
        8yHBhwrMLD+8iu6qbARUIj6XxDlcwEvBbb7nXwQOrHKnxsroWOnlfuvlGUdDhV/0m1yHgAvs2wcX0
        0nTesUo6HDGCtNqlprctVmEu0OjdVaV3FrOqUb+WfUd0ujwRbQByelb9z40XX+8BlAzc6SQk4wMOS
        qx243a10+i11d788jTKiopU1cj87pLDj5CABp+NSUkX+73QGcY7uVvOAyFND1BQ33cdRDYJo3bl0r
        HjzhAWhnzcKcNLGIc7bhJZGHWJH0xu2Yeaz4OZVWbPkWTQzzgGanwZBO+suwdAD8iv4drunTvEGcH
        okQcV9+A==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

__flush_icache_user_range is not used in modular code, so unexport it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 33b409391ddb6..ad6df1cea866f 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -36,7 +36,6 @@ EXPORT_SYMBOL_GPL(flush_icache_range);
 void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 EXPORT_SYMBOL_GPL(local_flush_icache_range);
 void (*__flush_icache_user_range)(unsigned long start, unsigned long end);
-EXPORT_SYMBOL_GPL(__flush_icache_user_range);
 void (*__local_flush_icache_user_range)(unsigned long start, unsigned long end);
 EXPORT_SYMBOL_GPL(__local_flush_icache_user_range);
 
-- 
2.26.2

