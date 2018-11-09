From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 01/13] Move EM_HEXAGON to uapi/linux/elf-em.h
Date: Fri, 9 Nov 2018 06:15:07 +0300
Message-ID: <20181109031507.GA21511@altlinux.org>
References: <20181109031303.GA20906@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181109031303.GA20906@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>, Richard Kuo <rkuo@codeaurora.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

This should never have been defined in the arch tree to begin with,
and now uapi/linux/audit.h header is going to use EM_HEXAGON
in order to define AUDIT_ARCH_HEXAGON which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/hexagon/include/asm/elf.h | 6 +-----
 include/uapi/linux/elf-em.h    | 1 +
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/include/asm/elf.h b/arch/hexagon/include/asm/elf.h
index 80311e7b8ca6..d10fbd54ae51 100644
--- a/arch/hexagon/include/asm/elf.h
+++ b/arch/hexagon/include/asm/elf.h
@@ -23,11 +23,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
-
-/*
- * This should really be in linux/elf-em.h.
- */
-#define EM_HEXAGON	164   /* QUALCOMM Hexagon */
+#include <linux/elf-em.h>
 
 struct elf32_hdr;
 
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 93722e60204c..ba3696e3d694 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -37,6 +37,7 @@
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
+#define EM_HEXAGON	164	/* QUALCOMM Hexagon */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
-- 
ldv
