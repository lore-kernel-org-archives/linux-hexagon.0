From: David Long <dave.long@linaro.org>
Subject: [PATCH 1/2] Move the pt_regs_offset struct definition from arch to common include file
Date: Mon, 15 Jun 2015 12:42:58 -0400
Message-ID: <1434386579-6045-2-git-send-email-dave.long@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, 

From: "David A. Long" <dave.long@linaro.org>

The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
 feature and has identical definitions in four different arch ptrace.h
include files. It seems unlikely that definition would ever need to be
changed regardless of architecture so lets move it into
include/linux/ptrace.h.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/ptrace.c     | 5 -----
 arch/powerpc/kernel/ptrace.c | 5 -----
 arch/sh/include/asm/ptrace.h | 5 -----
 arch/x86/kernel/ptrace.c     | 5 -----
 include/linux/ptrace.h       | 9 +++++++++
 5 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ef9119f..fb45cf1 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -59,11 +59,6 @@
 #define BREAKINST_THUMB	0xde01
 #endif
 
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
 #define REG_OFFSET_NAME(r) \
 	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
 #define REG_OFFSET_END {.name = NULL, .offset = 0}
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f21897b..ab81733 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -52,11 +52,6 @@
 #define PARAMETER_SAVE_AREA_OFFSET	48  /* bytes */
 #endif
 
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
 #define STR(s)	#s			/* convert to string */
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
 #define GPR_OFFSET_NAME(num)	\
diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 2506c7d..677c72b 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -23,11 +23,6 @@
 /*
  * kprobe-based event tracer support
  */
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
 #define REGS_OFFSET_NAME(num)	\
 	{.name = __stringify(r##num), .offset = offsetof(struct pt_regs, regs[num])}
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index a7bc794..f135d35 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -53,11 +53,6 @@ enum x86_regset {
 	REGSET_IOPERM32,
 };
 
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
 #define REG_OFFSET_END {.name = NULL, .offset = 0}
 
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 987a73a..b0b1ee6 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -383,4 +383,13 @@ extern int task_current_syscall(struct task_struct *target, long *callno,
 				unsigned long args[6], unsigned int maxargs,
 				unsigned long *sp, unsigned long *pc);
 
+#ifdef	CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
+
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#endif	/* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
+
 #endif
-- 
1.8.1.2

