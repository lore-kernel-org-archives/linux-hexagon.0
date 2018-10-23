From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] arm64: Create asm/initrd.h
Date: Tue, 23 Oct 2018 16:40:43 -0700
Message-ID: <20181023234044.1138-3-f.fainelli@gmail.com>
References: <20181023234044.1138-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nEK12TwimGCujNUldIGwHId5Lafwq/X4Yeeo8waJe0Y=; b=XvpWVU3GaKopasRjOYAevt8ZXl
	bUlc/zfAjWmj5FAptuJQ7d7pKjVdwpSZTFw5WgP9jV7LEQQ0Y9ixVS6IszQFJuKuW2CcarfrgYkq9
	GZN0ZgNLePqnImUL0Xua7aklkdO72hDScLu4bmuHOj8LJ7uCfqQ/4cM0zlEXf4LhTXRkYVYuhCHSF
	2usBwAV5hF8uuvavFCs/k/0WdtGTn8nKwIz2PeSGuU8+EshQGZJC49R0sbIzNK6Co0RE5MWFILubo
	n5zXa825YxNlNhuQZ6aVIB6+x1Tg2sAKfb3SpWscEjaGNJt1eSuPwWoN/f2HEVr35Iq8fr8fW65FI
	zk3U5V9A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=R7GnanBC/dUP1yUUX1JKpyThiE0iCRjX5YFPvjRZfCc=;
 b=kr72YR3Z6fsjpNCQWKAq8biRV5Ky6WEsLzLAKNjvGEXzVo0OLzZj/axxUcLvMsJljv
 GAUecWqvxnSaid8cy+tamZPG6VAbzIplkizh2XlS5+LjIS+KIZ1qIL24fEwrjS9qrQUb
 EIrpmsjuQqewtt8fFJdBuF7YeJ4v/DEjRBMn+gRA3PAzMbtYHLpSYsorIdL2fqgRdb8C
 jErR59hy7OjxBnoL5lFmGHiO/fgShVOHMM1Opsl0Z0i099qHGHgcQjLIKmx57lbmB3GZ
 krgLeNTNlj6Hdsvo4Fwc2fmHtk++Ag4dtLCP4cPAzhB5giHxiZf/r9Wv8RZmhadPX5Ok
 Ab7w==
In-Reply-To: <20181023234044.1138-1-f.fainelli@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: "open list:MIPS" <linux-mips@linux-mips.org>, Alan Kao <alankao@andestech.com>, "open list:SUPERH" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Marc Zyngier <marc.zyngier@arm.com>, "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, Matt Redfearn <matt.redfearn@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf

ARM64 is the only architecture that requires a re-definition of
__early_init_dt_declare_initrd(). Now that we added the infrastructure
in asm-generic to provide an asm/initrd.h file, properly break up that
definition from asm/memory.h and make use of that header in
drivers/of/fdt.c where this is used.

This significantly cuts the number of objects that need to be rebuilt on
ARM64 due to the repercusions of including asm/memory.h in several
places.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/initrd.h | 13 +++++++++++++
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h

diff --git a/arch/arm64/include/asm/initrd.h b/arch/arm64/include/asm/initrd.h
new file mode 100644
index 000000000000..0c9572485810
--- /dev/null
+++ b/arch/arm64/include/asm/initrd.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_INITRD_H
+#define __ASM_INITRD_H
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#define __early_init_dt_declare_initrd(__start, __end)			\
+	do {								\
+		initrd_start = (__start);				\
+		initrd_end = (__end);					\
+	} while (0)
+#endif
+
+#endif /* __ASM_INITRD_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..4e4711af907b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -28,6 +28,7 @@
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
+#include <asm/initrd.h>
 
 #include "of_private.h"
 
-- 
2.17.1
