From: Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] hexagon: Remove unusable symbols from the ptrace.h uapi
Date: Fri,  7 Jul 2023 11:48:33 +0200
Message-ID: <20230707094833.821578-1-thuth@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688723320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3Hqt3DW+XoE9Brru6PZKgda5Zq5ahlIuj+xsQHjzxKI=;
        b=UxRm+7j/YsX7E3JgYBtwkhpXf70hZl2DSby6CmsZYWIXVyM6ceyKCYgvNMAdvN/tA0pSq0
        ydyqEzoZP69x7xm9Cgux6kRJpPjSB6uSj0TNORZTe69JiR2aAphFJesI4FG/jV0Pkjs9Eb
        EjB1e/xwJHYgbCT8mlmAASMOejCqxN4=
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>

Kernel-internal prototypes, references to current_thread_info()
and code hidden behind a CONFIG_HEXAGON_ARCH_VERSION switch are
certainly not usable in userspace, so this should not reside
in a uapi header. Move the code into an internal version of
ptrace.h instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: It's completely untested, that's why I marked it as RFC

 arch/hexagon/include/asm/ptrace.h      | 25 +++++++++++++++++++++++++
 arch/hexagon/include/uapi/asm/ptrace.h | 13 -------------
 scripts/headers_install.sh             |  1 -
 3 files changed, 25 insertions(+), 14 deletions(-)
 create mode 100644 arch/hexagon/include/asm/ptrace.h

diff --git a/arch/hexagon/include/asm/ptrace.h b/arch/hexagon/include/asm/ptrace.h
new file mode 100644
index 0000000000000..ed35da1ee685a
--- /dev/null
+++ b/arch/hexagon/include/asm/ptrace.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ptrace definitions for the Hexagon architecture
+ *
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _ASM_HEXAGON_PTRACE_H
+#define _ASM_HEXAGON_PTRACE_H
+
+#include <uapi/asm/ptrace.h>
+
+/* kprobe-based event tracer support */
+extern int regs_query_register_offset(const char *name);
+extern const char *regs_query_register_name(unsigned int offset);
+
+#define current_pt_regs() \
+	((struct pt_regs *) \
+	 ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
+
+#if CONFIG_HEXAGON_ARCH_VERSION >= 4
+#define arch_has_single_step()	(1)
+#endif
+
+#endif
diff --git a/arch/hexagon/include/uapi/asm/ptrace.h b/arch/hexagon/include/uapi/asm/ptrace.h
index f79de05b8689b..2a3ea14ad9b9e 100644
--- a/arch/hexagon/include/uapi/asm/ptrace.h
+++ b/arch/hexagon/include/uapi/asm/ptrace.h
@@ -29,17 +29,4 @@
 
 #define profile_pc(regs) instruction_pointer(regs)
 
-/* kprobe-based event tracer support */
-extern int regs_query_register_offset(const char *name);
-extern const char *regs_query_register_name(unsigned int offset);
-
-#define current_pt_regs() \
-	((struct pt_regs *) \
-	 ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
-
-#if CONFIG_HEXAGON_ARCH_VERSION >= 4
-#define arch_has_single_step()	(1)
-#endif
-
-
 #endif
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 56d3c338d91d7..c3064ac310030 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
 arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
 arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
 arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
-arch/hexagon/include/uapi/asm/ptrace.h:CONFIG_HEXAGON_ARCH_VERSION
 arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
 arch/ia64/include/uapi/asm/cmpxchg.h:CONFIG_IA64_DEBUG_CMPXCHG
 arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
-- 
2.39.3

