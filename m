From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 20/20] cmdline: Remove CONFIG_CMDLINE_EXTEND
Date: Fri,  2 Apr 2021 15:18:22 +0000 (UTC)
Message-ID: <349128c2baa37dfcafb61a10d4e6c62f93cfe881.1617375803.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: will@kernel.org, danielwa@cisco.com, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

All architectures providing CONFIG_CMDLINE_EXTEND
are now converted to GENERIC_CMDLINE.

This configuration item is not used anymore, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/cmdline.h | 2 +-
 init/Kconfig            | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index a0773dc365c7..020028e2bdf0 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -36,7 +36,7 @@ static __always_inline bool __cmdline_build(char *dst, const char *src)
 
 	len = cmdline_strlcat(dst, src, COMMAND_LINE_SIZE);
 
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+	if (IS_ENABLED(CONFIG_CMDLINE_APPEND))
 		len = cmdline_strlcat(dst, " " CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 
 	if (len < COMMAND_LINE_SIZE - 1)
diff --git a/init/Kconfig b/init/Kconfig
index af0d84662cc2..fa002e3765ab 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -163,12 +163,6 @@ config CMDLINE_FORCE
 	  arguments provided by the bootloader.
 endchoice
 
-config CMDLINE_EXTEND
-	bool
-	default CMDLINE_APPEND
-	help
-	  To be removed once all architectures are converted to generic CMDLINE
-
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on HAS_IOMEM
-- 
2.25.0

