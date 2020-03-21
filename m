From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 20/20] lockdep: Add posixtimer context tracing bits
Date: Sat, 21 Mar 2020 12:26:04 +0100
Message-ID: <20200321113242.751182723@linutronix.de>
References: <20200321112544.878032781@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8-bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-drive

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Splitting run_posix_cpu_timers() into two parts is work in progress which
is stuck on other entry code related problems. The heavy lifting which
involves locking of sighand lock will be moved into task context so the
necessary execution time is burdened on the task and not on interrupt
context.

Until this work completes lockdep with the spinlock nesting rules enabled
would emit warnings for this known context.

Prevent it by setting "->irq_config = 1" for the invocation of
run_posix_cpu_timers() so lockdep does not complain when sighand lock is
acquried. This will be removed once the split is completed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqflags.h       |   12 ++++++++++++
 kernel/time/posix-cpu-timers.c |    6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -69,6 +69,16 @@ do {						\
 			current->irq_config = 0;	\
 	  } while (0)
 
+# define lockdep_posixtimer_enter()				\
+	  do {							\
+		  current->irq_config = 1;			\
+	  } while (0)
+
+# define lockdep_posixtimer_exit()				\
+	  do {							\
+		  current->irq_config = 0;			\
+	  } while (0)
+
 # define lockdep_irq_work_enter(__work)					\
 	  do {								\
 		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
@@ -94,6 +104,8 @@ do {						\
 # define lockdep_softirq_exit()		do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
 # define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
+# define lockdep_posixtimer_enter()		do { } while (0)
+# define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
 # define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1126,8 +1126,11 @@ void run_posix_cpu_timers(void)
 	if (!fastpath_timer_check(tsk))
 		return;
 
-	if (!lock_task_sighand(tsk, &flags))
+	lockdep_posixtimer_enter();
+	if (!lock_task_sighand(tsk, &flags)) {
+		lockdep_posixtimer_exit();
 		return;
+	}
 	/*
 	 * Here we take off tsk->signal->cpu_timers[N] and
 	 * tsk->cpu_timers[N] all the timers that are firing, and
@@ -1169,6 +1172,7 @@ void run_posix_cpu_timers(void)
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
+	lockdep_posixtimer_exit();
 }
 
 /*

