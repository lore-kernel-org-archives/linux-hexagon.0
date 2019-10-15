From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/34] hexagon: Use CONFIG_PREEMPTION
Date: Tue, 15 Oct 2019 21:17:55 +0200
Message-ID: <20191015191821.11479-9-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/hexagon/kernel/vm_entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/vm_entry.S b/arch/hexagon/kernel/vm_entry.S
index 12242c27e2df5..65a1ea0eed2fa 100644
--- a/arch/hexagon/kernel/vm_entry.S
+++ b/arch/hexagon/kernel/vm_entry.S
@@ -265,12 +265,12 @@
 	 * should be in the designated register (usually R19)
 	 *
 	 * If we were in kernel mode, we don't need to check scheduler
-	 * or signals if CONFIG_PREEMPT is not set.  If set, then it has
+	 * or signals if CONFIG_PREEMPTION is not set.  If set, then it has
 	 * to jump to a need_resched kind of block.
-	 * BTW, CONFIG_PREEMPT is not supported yet.
+	 * BTW, CONFIG_PREEMPTION is not supported yet.
 	 */
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	R0 =3D #VM_INT_DISABLE
 	trap1(#HVM_TRAP1_VMSETIE)
 #endif
--=20
2.23.0

