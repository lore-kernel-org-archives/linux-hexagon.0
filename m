From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 03/20] usb: gadget: Use completion interface instead of
 open coding it
Date: Sat, 21 Mar 2020 12:25:47 +0100
Message-ID: <20200321113241.043380271@linutronix.de>
References: <20200321112544.878032781@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8-bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vg

From: Thomas Gleixner <tglx@linutronix.de>

ep_io() uses a completion on stack and open codes the waiting with:

  wait_event_interruptible (done.wait, done.done);
and
  wait_event (done.wait, done.done);

This waits in non-exclusive mode for complete(), but there is no reason to
do so because the completion can only be waited for by the task itself and
complete() wakes exactly one exlusive waiter.

Replace the open coded implementation with the corresponding
wait_for_completion*() functions.

No functional change.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
---
V2: New patch to avoid the conversion to swait interfaces later
---
 drivers/usb/gadget/legacy/inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -344,7 +344,7 @@ ep_io (struct ep_data *epdata, void *buf
 	spin_unlock_irq (&epdata->dev->lock);
 
 	if (likely (value == 0)) {
-		value = wait_event_interruptible (done.wait, done.done);
+		value = wait_for_completion_interruptible(&done);
 		if (value != 0) {
 			spin_lock_irq (&epdata->dev->lock);
 			if (likely (epdata->ep != NULL)) {
@@ -353,7 +353,7 @@ ep_io (struct ep_data *epdata, void *buf
 				usb_ep_dequeue (epdata->ep, epdata->req);
 				spin_unlock_irq (&epdata->dev->lock);
 
-				wait_event (done.wait, done.done);
+				wait_for_completion(&done);
 				if (epdata->status == -ECONNRESET)
 					epdata->status = -EINTR;
 			} else {


