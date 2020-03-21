From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 08/20] hexagon: Remove mm.h from asm/uaccess.h
Date: Sat, 21 Mar 2020 12:25:52 +0100
Message-ID: <20200321113241.531525286@linutronix.de>
References: <20200321112544.878032781@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8-bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, kbuild test robot <lkp@intel.com>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The defconfig compiles without linux/mm.h. With mm.h included the
include chain leands to:
|   CC      kernel/locking/percpu-rwsem.o
| In file included from include/linux/huge_mm.h:8,
|                  from include/linux/mm.h:567,
|                  from arch/hexagon/include/asm/uaccess.h:,
|                  from include/linux/uaccess.h:11,
|                  from include/linux/sched/task.h:11,
|                  from include/linux/sched/signal.h:9,
|                  from include/linux/rcuwait.h:6,
|                  from include/linux/percpu-rwsem.h:8,
|                  from kernel/locking/percpu-rwsem.c:6:
| include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'
|  1422 |  struct percpu_rw_semaphore rw_sem[SB_FREEZE_LEVELS];

once rcuwait.h includes linux/sched/signal.h.

Remove the linux/mm.h include.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
---
V3: New patch
---
 arch/hexagon/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index 00cb38faad0c4..c1019a736ff13 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -10,7 +10,6 @@
 /*
  * User space memory access functions
  */
-#include <linux/mm.h>
 #include <asm/sections.h>
 
 /*
-- 
2.26.0.rc2


