From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH linux-next v9 2/7] hexagon: define syscall_get_error() and
 syscall_get_return_value()
Date: Mon, 8 Apr 2019 20:41:39 +0300
Message-ID: <20190408174139.GC11889@altlinux.org>
References: <20190408174036.GA11889@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408174036.GA11889@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

syscall_get_* functions are required to be implemented on all
architectures in order to extend the generic ptrace API with
PTRACE_GET_SYSCALL_INFO request.

This adds remaining 2 syscall_get_* functions as documented in
asm-generic/syscall.h: syscall_get_error and syscall_get_return_value.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Richard, this patch is waiting for ACK since November.

Notes:
    v9: unchanged
    v8: moved syscall_get_arch to separate audit patchset
    v7: unchanged
    v6: added missing includes
    v5: added syscall_get_error and syscall_get_return_value
    v4: unchanged
    v3: unchanged
    v2: unchanged

 arch/hexagon/include/asm/syscall.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index dab26a71f577..0f28a6a39c3a 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -22,6 +22,8 @@
 #define _ASM_HEXAGON_SYSCALL_H
 
 #include <uapi/linux/audit.h>
+#include <linux/err.h>
+#include <asm/ptrace.h>
 
 typedef long (*syscall_fn)(unsigned long, unsigned long,
 	unsigned long, unsigned long,
@@ -44,6 +46,18 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &(&regs->r00)[0], 6 * sizeof(args[0]));
 }
 
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	return IS_ERR_VALUE(regs->r00) ? regs->r00 : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->r00;
+}
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_HEXAGON;
-- 
ldv
