From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 13/17] sparc: Convert to GENERIC_CMDLINE
Date: Fri, 26 Mar 2021 13:45:00 +0000 (UTC)
Message-ID: <3a5407b76a256affa124902d9c2285a98d2516dc.1616765870.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: will@kernel.org, danielwa@cisco.com, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/sparc/Kconfig           | 18 +-----------------
 arch/sparc/prom/bootstr_64.c |  2 +-
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..2a197f3a2549 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -50,6 +50,7 @@ config SPARC
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select SET_FS
+	select GENERIC_CMDLINE if SPARC64
 
 config SPARC32
 	def_bool !64BIT
@@ -313,23 +314,6 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-	depends on SPARC64
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 root=/dev/sda1"
-	help
-	  Say Y here if you want to be able to pass default arguments to
-	  the kernel. This will be overridden by the bootloader, if you
-	  use one (such as SILO). This is most useful if you want to boot
-	  a kernel from TFTP, and want default options to be available
-	  with having them passed on the command line.
-
-	  NOTE: This option WILL override the PROM bootargs setting!
