From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 12/20] powerpc/ps3: Convert half completion to rcuwait
Date: Sat, 21 Mar 2020 12:25:56 +0100
Message-ID: <20200321113241.930037873@linutronix.de>
References: <20200321112544.878032781@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8-bit
Return-path: <linux-ia64-owner@vger.kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>

From: Thomas Gleixner <tglx@linutronix.de>

The PS3 notification interrupt and kthread use a hacked up completion to
communicate. Since we're wanting to change the completion implementation and
this is abuse anyway, replace it with a simple rcuwait since there is only ever
the one waiter.

AFAICT the kthread uses TASK_INTERRUPTIBLE to not increase loadavg, kthreads
cannot receive signals by default and this one doesn't look different. Use
TASK_IDLE instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
V3: Folded the init fix from bigeasy
V2: New patch to avoid the magic completion wait variant
---
 arch/powerpc/platforms/ps3/device-init.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/reboot.h>
+#include <linux/rcuwait.h>
 
 #include <asm/firmware.h>
 #include <asm/lv1call.h>
@@ -670,7 +671,8 @@ struct ps3_notification_device {
 	spinlock_t lock;
 	u64 tag;
 	u64 lv1_status;
-	struct completion done;
+	struct rcuwait wait;
+	bool done;
 };
 
 enum ps3_notify_type {
@@ -712,7 +714,8 @@ static irqreturn_t ps3_notification_inte
 		pr_debug("%s:%u: completed, status 0x%llx\n", __func__,
 			 __LINE__, status);
 		dev->lv1_status = status;
-		complete(&dev->done);
+		dev->done = true;
+		rcuwait_wake_up(&dev->wait);
 	}
 	spin_unlock(&dev->lock);
 	return IRQ_HANDLED;
@@ -725,12 +728,12 @@ static int ps3_notification_read_write(s
 	unsigned long flags;
 	int res;
 
-	init_completion(&dev->done);
 	spin_lock_irqsave(&dev->lock, flags);
 	res = write ? lv1_storage_write(dev->sbd.dev_id, 0, 0, 1, 0, lpar,
 					&dev->tag)
 		    : lv1_storage_read(dev->sbd.dev_id, 0, 0, 1, 0, lpar,
 				       &dev->tag);
+	dev->done = false;
 	spin_unlock_irqrestore(&dev->lock, flags);
 	if (res) {
 		pr_err("%s:%u: %s failed %d\n", __func__, __LINE__, op, res);
@@ -738,14 +741,10 @@ static int ps3_notification_read_write(s
 	}
 	pr_debug("%s:%u: notification %s issued\n", __func__, __LINE__, op);
 
-	res = wait_event_interruptible(dev->done.wait,
-				       dev->done.done || kthread_should_stop());
+	rcuwait_wait_event(&dev->wait, dev->done || kthread_should_stop(), TASK_IDLE);
+
 	if (kthread_should_stop())
 		res = -EINTR;
-	if (res) {
-		pr_debug("%s:%u: interrupted %s\n", __func__, __LINE__, op);
-		return res;
-	}
 
 	if (dev->lv1_status) {
 		pr_err("%s:%u: %s not completed, status 0x%llx\n", __func__,
@@ -810,6 +809,7 @@ static int ps3_probe_thread(void *data)
 	}
 
 	spin_lock_init(&dev.lock);
+	rcuwait_init(&dev.wait);
 
 	res = request_irq(irq, ps3_notification_interrupt, 0,
 			  "ps3_notification", &dev);

