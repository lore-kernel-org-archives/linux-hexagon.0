From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH v2] arch: hexagon: kernel: hexagon_ksyms.c: export related
 symbols which various modules need
Date: Fri, 29 Nov 2013 12:01:50 +0800
Message-ID: <529811AE.8050502@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=rKUBlBlsG1JImOfBquQDz4P4j3rfzphlpcAYTZtEgtE=;
        b=YbxyVrr8f3LPpfA5PAyUabhfFfHzArvy8rzrJ29eL2/U7OrMQkh8CekbXTlvNrhcMu
         UrSoQq2Z46mqUZxKYid5ANB1zORAcZa9GxN0O52z5f/VyNEbSzezL71boSDsoiLM/5vU
         UlmB7wzjxPT9oU0Ap6pRacP3THTd30xlawV6MQUZ1uC/0Fh+6G8bDjSvMxgbgy+9ss4B
         jK49rQPgTPAN5ah5CPlol5qazh75VuSssx8xzEZR8k14eAH+xVDVZ89JC+4lywBMz/5s
         sJLO1K0oVhx9tyFEgBzm/EasSWgQnXRl9mOXuokyJBw++aPi0OspfG3F5M9sS/tp+c3d
         Bsjw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Need export all related functions and symbols for various modules with
allmodconfig. The related errors:

    MODPOST 2879 modules
  ERROR: "__vmyield" [sound/sound_firmware.ko] undefined!
  ERROR: "__phys_offset" [sound/drivers/snd-dummy.ko] undefined!
  ERROR: "ioremap_nocache" [drivers/char/ipmi/ipmi_si.ko] undefined!
  ERROR: "__iounmap" [drivers/char/ipmi/ipmi_si.ko] undefined!
  ...

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/kernel/hexagon_ksyms.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
index 32b1379..3188de4 100644
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -20,6 +20,9 @@
 
 #include <asm/hexagon_vm.h>
 #include <asm/uaccess.h>
+#include <asm/io.h>
+#include <linux/dma-mapping.h>
+#include <asm/dma-mapping.h>
 
 EXPORT_SYMBOL(__copy_from_user_hexagon);
 EXPORT_SYMBOL(__copy_to_user_hexagon);
@@ -28,13 +31,29 @@ EXPORT_SYMBOL(__vmsetie);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 
+/* Additional functions */
+EXPORT_SYMBOL(__strnlen_user);
+EXPORT_SYMBOL(__vmyield);
+EXPORT_SYMBOL(__iounmap);
+EXPORT_SYMBOL(__clear_user_hexagon);
+EXPORT_SYMBOL(ioremap_nocache);
+EXPORT_SYMBOL(empty_zero_page);
+
+/* Additional variables */
+EXPORT_SYMBOL(_dflt_cache_att);
+EXPORT_SYMBOL(__phys_offset);
+EXPORT_SYMBOL(bad_dma_address);
+
 #define DECLARE_EXPORT(name)     \
 	extern void name(void); EXPORT_SYMBOL(name)
 
 /* Symbols found in libgcc that assorted kernel modules need */
 DECLARE_EXPORT(__hexagon_memcpy_likely_aligned_min32bytes_mult8bytes);
 
-DECLARE_EXPORT(__hexagon_divsi3);
-DECLARE_EXPORT(__hexagon_modsi3);
-DECLARE_EXPORT(__hexagon_udivsi3);
-DECLARE_EXPORT(__hexagon_umodsi3);
+DECLARE_EXPORT(__divsi3);
+DECLARE_EXPORT(__modsi3);
+DECLARE_EXPORT(__udivsi3);
+DECLARE_EXPORT(__umodsi3);
+
+/* Additional functions */
+DECLARE_EXPORT(csum_tcpudp_magic);
-- 
1.7.7.6
