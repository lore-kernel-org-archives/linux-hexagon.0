From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] regmap/hexagon: Properly fix the generic IO helpers
Date: Thu, 18 Aug 2022 14:12:27 +0200
Message-ID: <20220818121227.151016-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jwxp1KAydS2ZvfU/XwwFFINkOhcLog6j6vbpvOxklTw=;
        b=KOwUos+pq/GZt4Pp+EnUX+r8mRIeYu8foSVs8MNzP4ZzoBTzdYwYCX2xVYZwDPIolA
         dzGPKpscHVbdkOzCUDUMGPyRiAutaCEz8PfJ+BZ3H0SVHuMTuSoJLDEOo1Kgmd6ZEk+Y
         HE4vrWvqNPMNuR2Hk7gPqQx2o27O2UIKRjH8Gy1yxy8xEUYmeb9aX5qf4L36cl0CEwvc
         uxvC4m9xNsPCRD3EMPPCPxo7Ac3QPngcs1Gq2KxQ87rdyB+Y00IAd5LwQ/J/P9ZqFp22
         9rmYLoOyFmx5stKdywo+k1mEQepUa2REk5eugB2n30f9iKNRrNLP3WL8IAQEUWfA5DGS
         EbeA==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

I was too naive in just including <asm-generic/io.h> into
hexagon: one has to specify defines for every call that uses
a (static) inline or this will not work.

Fix it up by providing proper defines for all shorthands that
hexagon provides.

Compile-tested with hexagon LLVM which is the only working cross
compiler for hexagon ATM after commenting out the
-fno-inline-functions-called-once switch which isn't working
with LLVM.

Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: 81c0386c1376 ("regmap: mmio: Support accelerared noinc operations")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: please apply this to the regmap tree as a fix on
my sloppy commit so your tree compiles on hexagon. I hope the hexagon
folks will not mind.
---
 arch/hexagon/include/asm/io.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 8e938dc1ca4b..46a099de85b7 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -308,6 +308,29 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
 	}
 }
 
+/*
+ * These defines are necessary to use the generic io.h for filling in
+ * the missing parts of the API contract. This is because the platform
+ * uses (inline) functions rather than defines and the generic helper
+ * fills in the undefined.
+ */
+#define virt_to_phys virt_to_phys
+#define phys_to_virt phys_to_virt
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
+#define readb readb
+#define readw readw
+#define readl readl
+#define writeb writeb
+#define writew writew
+#define writel writel
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
 #include <asm-generic/io.h>
 
 #endif /* __KERNEL__ */
-- 
2.37.2

