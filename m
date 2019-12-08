From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Subject: [tip: sched/urgent] sched/rt, hexagon: Use CONFIG_PREEMPTION
Date: Sun, 08 Dec 2019 14:58:34 -0000
Message-ID: <157581711407.21853.6051212819041129601.tip-bot2@tip-bot2>
References: <20191015191821.11479-9-bigeasy@linutronix.de>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191015191821.11479-9-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Brian Cain <bcain@codeaurora.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     143cd41f50e0c074fbdb06c3ab75a45e3076b5a6
Gitweb:        https://git.kernel.org/tip/143cd41f50e0c074fbdb06c3ab75a45e3076b5a6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:17:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:33 +01:00

sched/rt, hexagon: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-hexagon@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-9-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/hexagon/kernel/vm_entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/vm_entry.S b/arch/hexagon/kernel/vm_entry.S
index 12242c2..65a1ea0 100644
--- a/arch/hexagon/kernel/vm_entry.S
+++ b/arch/hexagon/kernel/vm_entry.S
@@ -265,12 +265,12 @@ event_dispatch:
 	 * should be in the designated register (usually R19)
 	 *
 	 * If we were in kernel mode, we don't need to check scheduler
-	 * or signals if CONFIG_PREEMPT is not set.  If set, then it has
+	 * or signals if CONFIG_PREEMPTION is not set.  If set, then it has
 	 * to jump to a need_resched kind of block.
-	 * BTW, CONFIG_PREEMPT is not supported yet.
+	 * BTW, CONFIG_PREEMPTION is not supported yet.
 	 */
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	R0 = #VM_INT_DISABLE
 	trap1(#HVM_TRAP1_VMSETIE)
 #endif
