From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 11/17] hexagon: switch to copy_thread_tls()
Date: Tue, 23 Jun 2020 01:43:20 +0200
Message-ID: <20200622234326.906346-12-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <christian.brauner@ubuntu.com>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

Use the copy_thread_tls() calling convention which passes tls through a
register. This is required so we can remove the copy_thread{_tls}() split
and remove the HAVE_COPY_THREAD_TLS macro.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/hexagon/Kconfig          | 1 +
 arch/hexagon/kernel/process.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 667cfc511cf9..19bc2f2ee331 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -31,6 +31,7 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select HAVE_COPY_THREAD_TLS
 	help
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index ac07f5f4b76b..d756f9556dd7 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -50,8 +50,8 @@ void arch_cpu_idle(void)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		    unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct hexagon_switch_stack *ss;
@@ -100,7 +100,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	 * ugp is used to provide TLS support.
 	 */
 	if (clone_flags & CLONE_SETTLS)
-		childregs->ugp = childregs->r04;
+		childregs->ugp = tls;
 
 	/*
 	 * Parent sees new pid -- not necessary, not even possible at
-- 
2.27.0

