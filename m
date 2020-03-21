From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 01/20] PCI/switchtec: Fix init_completion race condition
 with poll_wait()
Date: Sat, 21 Mar 2020 12:25:45 +0100
Message-ID: <20200321113240.841963112@linutronix.de>
References: <20200321112544.878032781@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8-bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-drive

From: Logan Gunthorpe <logang@deltatee.com>

The call to init_completion() in mrpc_queue_cmd() can theoretically
race with the call to poll_wait() in switchtec_dev_poll().

  poll()			write()
    switchtec_dev_poll()   	  switchtec_dev_write()
      poll_wait(&s->comp.wait);      mrpc_queue_cmd()
			               init_completion(&s->comp)
				         init_waitqueue_head(&s->comp.wait)

To my knowledge, no one has hit this bug.

Fix this by using reinit_completion() instead of init_completion() in
mrpc_queue_cmd().

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc: linux-pci@vger.kernel.org
Link: https://lkml.kernel.org/r/20200313183608.2646-1-logang@deltatee.com

---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index a823b4b8ef8a..81dc7ac01381 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -175,7 +175,7 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len = sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
+	reinit_completion(&stuser->comp);
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
 
 	mrpc_cmd_submit(stdev);
-- 
2.20.1



