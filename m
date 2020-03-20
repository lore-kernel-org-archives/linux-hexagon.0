From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] hexagon: Remove mm.h from asm/uaccess.h
Date: Fri, 20 Mar 2020 10:48:54 +0100
Message-ID: <20200320094856.3453859-4-bigeasy@linutronix.de>
References: <20200318204408.010461877@linutronix.de>
 <20200320094856.3453859-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200320094856.3453859-1-bigeasy@linutronix.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tglx@linutronix.de
Cc: arnd@arndb.de, balbi@kernel.org, bhelgaas@google.com, bigeasy@linutronix.de, dave@stgolabs.net, davem@davemloft.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, kurt.schwemmer@microsemi.com, kvalo@codeaurora.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, logang@deltatee.com, mingo@kernel.org, mpe@ellerman.id.au, netdev@vger.kernel.org, oleg@redhat.com, paulmck@kernel.org, peterz@infradead.org, rdunlap@infradead.org, rostedt@goodmis.org, torvalds@linux-foundation.org, will@kernel.org, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, kbuild test robot <lkp@intel.com>

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
| include/linux/fs.h:1422:29: error: array type has incomplete element type=
 'struct percpu_rw_semaphore'
|  1422 |  struct percpu_rw_semaphore rw_sem[SB_FREEZE_LEVELS];

once rcuwait.h includes linux/sched/signal.h.

Remove the linux/mm.h include.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/hexagon/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/=
uaccess.h
index 00cb38faad0c4..c1019a736ff13 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -10,7 +10,6 @@
 /*
  * User space memory access functions
  */
-#include <linux/mm.h>
 #include <asm/sections.h>
=20
 /*
--=20
2.26.0.rc2

