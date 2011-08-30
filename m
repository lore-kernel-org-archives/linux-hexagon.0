From: Richard Kuo <rkuo@codeaurora.org>
Subject: [patch v2 08/35] Hexagon: Add delay functions
Date: Tue, 30 Aug 2011 14:07:37 -0500
Message-ID: <20110830190800.478027955@codeaurora.org>
References: <20110830190729.923334292@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=delay.diff
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Added read_current_timer elsewhere, so __delay isn't really used.

udelay is based off of __vmgettime() which returns processor ticks.

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

---
 arch/hexagon/include/asm/delay.h |   34 ++++++++++++++++++++++++++++++++++
 arch/hexagon/kernel/delay.S      |   30 ++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

Index: linux-hexagon-kernel/arch/hexagon/include/asm/delay.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-hexagon-kernel/arch/hexagon/include/asm/delay.h	2011-08-24 18:45:48.123877096 -0500
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#ifndef _ASM_DELAY_H
+#define _ASM_DELAY_H
+
+#include <asm/param.h>
+
+extern void __udelay(unsigned long usecs);
+
+#define udelay(usecs) __udelay((usecs))
+
+/*
+ * This isn't really used on our arch; __udelay is based on a
+ * vmgettime() call.
+ */
+extern void __delay(unsigned long loops);
+
+#endif /* _ASM_DELAY_H */
Index: linux-hexagon-kernel/arch/hexagon/kernel/delay.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-hexagon-kernel/arch/hexagon/kernel/delay.S	2011-08-24 18:45:48.133877105 -0500
@@ -0,0 +1,30 @@
+/*
+ * __delay loop implementation for Hexagon
+ *
+ * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#include <linux/linkage.h>
+#include <asm/hexagon_vm.h>
+
+ENTRY(__delay)
+	loop0(1f,r0)
+1:
+	{
+		nop
+	}:endloop0
+	jumpr	R31

--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
