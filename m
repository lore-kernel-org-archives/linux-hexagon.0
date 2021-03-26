From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 01/17] cmdline: Add generic function to build command line.
Date: Fri, 26 Mar 2021 13:44:48 +0000 (UTC)
Message-ID: <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Date:Cc:To:Subject:From:References:In-Reply-To:
	Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j+r5WXQBeq/PDSQqSd2ZjRIBC1M1uKBjBaJPKusm0vw=; b=ZMJ7Q4HHO2XfKYBdH8g5f46EBg
	pYf3rxMyXskeAAI1sgnbyAfXf7IZiGGpmkm5iuoNM4E3TdW0sSwaYTXMlFec6H/v6K8N8B9wx+vzR
	xt1sGUfU4YgYCSdxWppuWflGjyvDwR7sTkA0vSreXzLQKHHVaC6wCfWGE445Rq0stiZpxTSrhh1Eh
	ky1dl0UTMiM6FqbX3QhY+LGGQtL2gYyxrTZkUOCE3jgjza+DyY2UUi7Fxpj9M8lgrrK70i5bPOpBg
	+UAFSpTGqkFChkA/i1jBI/PvXK9Ms3o7Teey8OhMJxvycSvkIfYpuWqOrRwmpGrR9fNtB5ek/uA3B
	IMX65o/g==;
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: will@kernel.org, danielwa@cisco.com, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

This code provides architectures with a way to build command line
based on what is built in the kernel and what is handed over by the
bootloader, based on selected compile-time options.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3:
- Addressed comments from Will
- Added capability to have src == dst
---
 include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..dea87edd41be
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+#include <linux/string.h>
+
+/* Allow architectures to override strlcat, powerpc can't use strings so early */
+#ifndef cmdline_strlcat
+#define cmdline_strlcat strlcat
+#endif
+
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dst: The destination of the final appended/prepended string.
+ * @src: The starting string or NULL if there isn't one.
+ * @len: the length of dest buffer.
+ */
+static __always_inline void __cmdline_build(char *dst, const char *src, size_t len)
+{
+	if (!len || src == dst)
+		return;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src) {
+		dst[0] = 0;
+		cmdline_strlcat(dst, CONFIG_CMDLINE, len);
+		return;
+	}
+
+	if (dst != src)
+		dst[0] = 0;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
+		cmdline_strlcat(dst, CONFIG_CMDLINE " ", len);
+
+	cmdline_strlcat(dst, src, len);
+
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+		cmdline_strlcat(dst, " " CONFIG_CMDLINE, len);
+}
+
+#define cmdline_build(dst, src, len) do {				\
+	char *__c_dst = (dst);						\
+	const char *__c_src = (src);					\
+									\
+	if (__c_src == __c_dst) {					\
+		static char __c_tmp[COMMAND_LINE_SIZE] __initdata = "";	\
+									\
+		cmdline_strlcat(__c_tmp, __c_src, COMMAND_LINE_SIZE);	\
+		__cmdline_build(__c_dst, __c_tmp, (len));		\
+	} else {							\
+		__cmdline_build(__c_dst, __c_src, (len));		\
+	}								\
+} while (0)
+
+#endif /* _LINUX_CMDLINE_H */
-- 
2.25.0
