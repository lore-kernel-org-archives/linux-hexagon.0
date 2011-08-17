From: Richard Kuo <rkuo@codeaurora.org>
Subject: [patch 28/36] Hexagon: Add ioremap support
Date: Wed, 17 Aug 2011 11:35:25 -0500
Message-ID: <20110817163522.477085366@codeaurora.org>
References: <20110817163457.878854582@codeaurora.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline; filename=ioremap.diff
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

---
 arch/hexagon/mm/ioremap.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

Index: linux-hexagon-kernel/arch/hexagon/mm/ioremap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-hexagon-kernel/arch/hexagon/mm/ioremap.c	2011-07-20 15:19:43.695151542 -0500
@@ -0,0 +1,57 @@
+/*
+ * I/O remap functions for Hexagon
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
+#include <linux/io.h>
+#include <linux/vmalloc.h>
+
+void __iomem *ioremap_nocache(unsigned long phys_addr, unsigned long size)
+{
+	unsigned long last_addr, addr;
+	unsigned long offset = phys_addr & ~PAGE_MASK;
+	struct vm_struct *area;
+
+	pgprot_t prot = __pgprot(_PAGE_PRESENT|_PAGE_READ|_PAGE_WRITE
+					|(__HEXAGON_C_DEV << 6));
+
+	last_addr = phys_addr + size - 1;
+
+	/*  Wrapping not allowed  */
+	if (!size || (last_addr < phys_addr))
+		return NULL;
+
+	/*  Rounds up to next page size, including whole-page offset */
+	size = PAGE_ALIGN(offset + size);
+
+	area = get_vm_area(size, VM_IOREMAP);
+	addr = (unsigned long)area->addr;
+
+	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
+		vunmap((void *)addr);
+		return NULL;
+	}
+
+	flush_cache_vmap(addr, addr+size);
+	return (void __iomem *) (offset + addr);
+}
+
+void __iounmap(const volatile void __iomem *addr)
+{
+	vunmap((void *) ((unsigned long) addr & PAGE_MASK));
+}

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

