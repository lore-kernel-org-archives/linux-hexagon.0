From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hexagon: io: Define ioremap_uc to fix build error
Date: Wed,  4 Dec 2019 05:33:28 -0800
Message-ID: <20191204133328.18668-1-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=A25GspOP/H1evlaxQOyjWW6KvcwnSro5rGpRXcQFYV4=;
        b=ew2kG1pASB0XkGMKDqb+FvwhANd2mlGEDByyjkzl5YIZQLVMXs8kACbWHjVSOM7pPe
         FGvKbFziox2Kz86DbfzEzEcmDZAHsZXiQnIiRz+5XJhFjdS4PmZfPyDseaOm6Kbnw9Op
         qpB88ECx1oRy20ZL/qmyznwusGqXvjdQANOIbUxZZ5U36/w9NxB52dVDCGbDAgRX4IRy
         cqvetN2NCLjdZBIn422CCXNkN4W08d8QeNjymZe6KHz4AILS9pXR5h5eQQO9PlP1Uast
         wV1dCL3rI++ql7jErS1Fm853+LJb/T1Yq1vUIVB28DwXcOATQEujbYjE+o1g9/7bQ5HS
         jcXw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Tuowen Zhao <ztuowen@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>, Lee Jones <lee.jones@linaro.org>

ioremap_uc is now mandatory.

lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'

Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
Cc: Tuowen Zhao <ztuowen@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/hexagon/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 539e3efcf39c..39e5605c5d42 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 
 void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
 #define ioremap_nocache ioremap
-
+#define ioremap_uc ioremap
 
 #define __raw_writel writel
 
-- 
2.17.1

