From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 06/14] hexagon: define syscall_get_arch()
Date: Wed, 9 Jan 2019 15:43:04 +0300
Message-ID: <20190109124303.GF11981@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Moore <paul@paul-moore.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>, linux-hexagon@vger.kernel.org, linux-audit@redhat.com, linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_error(), and
syscall_get_return_value() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
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
index c6a6e3a9ec9a..b1602dcc13bc 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -387,6 +387,7 @@ enum {
 #define AUDIT_ARCH_CSKY		(EM_CSKY|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_FRV		(EM_FRV)
 #define AUDIT_ARCH_H8300	(EM_H8_300)
+#define AUDIT_ARCH_HEXAGON	(EM_HEXAGON)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_M32R		(EM_M32R)
-- 
ldv
