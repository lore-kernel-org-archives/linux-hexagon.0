From: Christophe Leroy <christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org>
Subject: [RFC PATCH v6 1/1] cmdline: Add capability to both append and prepend at
 the same time
Date: Sun,  4 Apr 2021 17:20:48 +0000 (UTC)
Message-ID: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, danielwa-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel-R/FLGEdV95bo9U+Z1CfBt0SU0eOFXohjCypLqA8HKkk@public.gmane.org, arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, microblaze <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2 <ley.foon.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org

One user has expressed the need to both append and prepend some
built-in parameters to the command line provided by the bootloader.

Allthough it is a corner case, it is easy to implement so let's do it.

When the user chooses to prepend the bootloader provided command line
with the built-in command line, he is offered the possibility to enter
an additionnal built-in command line to be appended after the
bootloader provided command line.

It is a complementary feature which has no impact on the already
existing ones and/or the existing defconfig.

Suggested-by: Daniel Walker <danielwa-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Christophe Leroy <christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org>
---
Sending this out as an RFC, applies on top of the series
("Implement GENERIC_CMDLINE"). I will add it to the series next spin
unless someone is against it.
---
 include/linux/cmdline.h |  3 +++
 init/Kconfig            | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index 020028e2bdf0..fb274a4d5519 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -36,6 +36,9 @@ static __always_inline bool __cmdline_build(char *dst, const char *src)
 
 	len = cmdline_strlcat(dst, src, COMMAND_LINE_SIZE);
 
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
+		len = cmdline_strlcat(dst, " " CONFIG_CMDLINE_MORE, COMMAND_LINE_SIZE);
+
 	if (IS_ENABLED(CONFIG_CMDLINE_APPEND))
 		len = cmdline_strlcat(dst, " " CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 
diff --git a/init/Kconfig b/init/Kconfig
index fa002e3765ab..cd3087ff4f28 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -128,6 +128,14 @@ config CMDLINE
 	  If this string is not empty, additional choices are proposed
 	  below to determine how it will be used by the kernel.
 
+config CMDLINE_MORE
+	string "Additional default kernel command string" if GENERIC_CMDLINE && CMDLINE_PREPEND
+	default ""
+	help
+	  Defines an additional default kernel command string.
+	  If this string is not empty, it is appended to the
+	  command-line arguments provided by the bootloader
+
 choice
 	prompt "Kernel command line type" if CMDLINE != ""
 	default CMDLINE_PREPEND if ARCH_WANT_CMDLINE_PREPEND_BY_DEFAULT
@@ -154,7 +162,9 @@ config CMDLINE_PREPEND
 	bool "Prepend to the bootloader kernel arguments"
 	help
 	  The default kernel command string will be prepended to the
-	  command-line arguments provided by the bootloader.
+	  command-line arguments provided by the bootloader. When this
+	  option is selected, another string can be added which will
+	  be appended.
 
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
-- 
2.25.0

