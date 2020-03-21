From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 15/20] sched/swait: Prepare usage in completions
Date: Sat, 21 Mar 2020 12:25:59 +0100
Message-ID: <20200321113242.228481202@linutronix.de>
References: <20200321112544.878032781@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8-bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-drive

From: Thomas Gleixner <tglx@linutronix.de>

As a preparation to use simple wait queues for completions:

  - Provide swake_up_all_locked() to support complete_all()
  - Make __prepare_to_swait() public available

This is done to enable the usage of complete() within truly atomic contexts
on a PREEMPT_RT enabled kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
V2: Add comment to swake_up_all_locked()
---
 kernel/sched/sched.h |    3 +++
 kernel/sched/swait.c |   15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2492,3 +2492,6 @@ static inline bool is_per_cpu_kthread(st
 	return true;
 }
 #endif
+
+void swake_up_all_locked(struct swait_queue_head *q);
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -32,6 +32,19 @@ void swake_up_locked(struct swait_queue_
 }
 EXPORT_SYMBOL(swake_up_locked);
 
+/*
+ * Wake up all waiters. This is an interface which is solely exposed for
+ * completions and not for general usage.
+ *
+ * It is intentionally different from swake_up_all() to allow usage from
+ * hard interrupt context and interrupt disabled regions.
+ */
+void swake_up_all_locked(struct swait_queue_head *q)
+{
+	while (!list_empty(&q->task_list))
+		swake_up_locked(q);
+}
+
 void swake_up_one(struct swait_queue_head *q)
 {
 	unsigned long flags;
@@ -69,7 +82,7 @@ void swake_up_all(struct swait_queue_hea
 }
 EXPORT_SYMBOL(swake_up_all);
 
-static void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
 	if (list_empty(&wait->task_list))


