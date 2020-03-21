From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 07/20] csky: Remove mm.h from asm/uaccess.h
Date: Sat, 21 Mar 2020 12:25:51 +0100
Message-ID: <20200321113241.434999165@linutronix.de>
References: <20200321112544.878032781@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8-bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, kbuild test robot <lkp@intel.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The defconfig compiles without linux/mm.h. With mm.h included the
include chain leands to:
|   CC      kernel/locking/percpu-rwsem.o
| In file included from include/linux/huge_mm.h:8,
|                  from include/linux/mm.h:567,
|                  from arch/csky/include/asm/uaccess.h:,
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
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
V3: New patch
---
 arch/csky/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index eaa1c3403a424..abefa125b93cf 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -11,7 +11,6 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/version.h>
 #include <asm/segment.h>
-- 
2.26.0.rc2


