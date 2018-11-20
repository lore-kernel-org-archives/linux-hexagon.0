From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v2 10/15] hexagon: define syscall_get_arch()
Date: Tue, 20 Nov 2018 03:16:13 +0300
Message-ID: <20181120001612.GJ11387@altlinux.org>
References: <20181120001128.GA11300@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120001128.GA11300@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>, Richard Kuo <rkuo@codeaurora.org>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, linux-hexagon@vger.kernel.org, linux-audit@redhat.com, linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
v2: unchanged since v1

 arch/hexagon/include/asm/syscall.h | 8 ++++++++
 include/uapi/linux/audit.h         | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index 4af9c7b6f13a..de3917aad3fd 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -21,6 +21,8 @@
 #ifndef _ASM_HEXAGON_SYSCALL_H
 #define _ASM_HEXAGON_SYSCALL_H
 
+#include <uapi/linux/audit.h>
+
 typedef long (*syscall_fn)(unsigned long, unsigned long,
 	unsigned long, unsigned long,
 	unsigned long, unsigned long);
@@ -43,4 +45,10 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	BUG_ON(i + n > 6);
 	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
 }
+
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_HEXAGON;
+}
+
 #endif
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d7fa1ba8dc82..421953fc2f13 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -386,6 +386,7 @@ enum {
 #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_FRV		(EM_FRV)
 #define AUDIT_ARCH_H8300	(EM_H8_300)
+#define AUDIT_ARCH_HEXAGON	(EM_HEXAGON)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_M32R		(EM_M32R)
-- 
ldv
