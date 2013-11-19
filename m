From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: Kconfig: add HAVE_DMA_ATTR in Kconfig and
 remove "linux/dma-mapping.h" from "asm/dma-mapping.h"
Date: Tue, 19 Nov 2013 12:57:27 +0800
Message-ID: <528AEFB7.4060301@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=C7Rz6dGo8/tp4yyn/EehfPAo4kTu3IABWnRNhUFl92E=;
        b=cVWEoZ3sppo34r2PSLy5Y79MxAWGSO1yBth19qDyH5umEwIMoKJ9VX85oXM+cQbZyF
         Snb8sqp7gweZ0sZacSixiPPfirsHVocJOg/MV0M/aypkdHopCPadIKuwtcAz9W6BKdqI
         gDaKUVlX3C5EaTvRiqZlvqD/XARahLqNf3ZXp6wZrklqREeJqTQ1K7AAUg1N7cKHpMou
         IfYRto5e1ZpPIc2HchutCxyLxz2u04YDoMY7Na8SHzfKGjtc+hLm1OFseRK/Bfg/sxHP
         /X0hP3vR3mEh/KNInGqBpCx7C/6ftg5CORDUrchKMikGDd9jESbhfw4QHqWIW4Ordl4g
         SXEw==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

When HAS_DMA, and also need use generic implementation, HAVE_DMA_ATTR
must be enabled, or can not pass compiling with allmodconfig, the
related error:

    CC [M]  drivers/ata/libata-core.o
  drivers/ata/libata-core.c: In function 'ata_sg_clean':
  drivers/ata/libata-core.c:4598:3: error: implicit declaration of function 'dma_unmap_sg' [-Werror=implicit-function-declaration]
  drivers/ata/libata-core.c: In function 'ata_sg_setup':
  drivers/ata/libata-core.c:4708:2: error: implicit declaration of function 'dma_map_sg' [-Werror=implicit-function-declaration]

"linux/dma-mapping.h" will include "asm/dma-mapping.h", so need remove
"linux/dma-mapping.h" from "asm/dma-mapping.h",


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/Kconfig                   |    1 +
 arch/hexagon/include/asm/dma-mapping.h |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 09df260..fbc5c78 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,7 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select HAVE_DMA_ATTRS
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 85e9935..1696542 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -25,7 +25,6 @@
 #include <linux/cache.h>
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
 #include <linux/dma-debug.h>
 #include <linux/dma-attrs.h>
 #include <asm/io.h>
-- 
1.7.7.6
