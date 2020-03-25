From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH v2] Documentation/locking/locktypes: minor copy editor fixes
Date: Wed, 25 Mar 2020 09:58:14 -0700
Message-ID: <ac615f36-0b44-408d-aeab-d76e4241add4@infradead.org>
References: <20200323025501.GE3199@paulmck-ThinkPad-P72>
 <87r1xhz6qp.fsf@nanos.tec.linutronix.de>
 <20200325002811.GO19865@paulmck-ThinkPad-P72>
 <87wo78y5yy.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=nzNtddxyHToIfzwzcRpU+rkJvFePaVcVMvDxhJ0zIm8=; b=Ny0TO9lEhbmvUL2PtdSbl/e3Gm
        dLHrOkD5v8ewIwjLPXGarl7V5+K4iXFzHb2IblMXtRLy0e1xYPfEYd/TNMgeQMms4qdMS3GnsSBzh
        MG4FkMj0CmZIJdF594Ere7tUatW2cpHFY1FN56RNDDvW3fQmt0gVnStPqemN2Xr9H/2N8GLHIr5Wg
        jCmOaOYFpQoZFzr/LNFj0CHFygyAwaMnjmIJLMM/2ZdRTd590pAvjPj/dIFmu4oG/94o0FTc9L0qs
        q8JUj6IqIVy73yedpWdJ2Myuil5rim24S7yVdJXA5SxDwBhAKySclpEAQs+h4mmF+uJG1N1o3ZfNM
        CTBQSfOQ==;
In-Reply-To: <87wo78y5yy.fsf-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, paulmck-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joel Fernandes <joel-QYYGw3jwrUn5owFQY34kdNi2O/JbrIOy@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Kurt Schwemmer <kurt.schwemmer-dzo6w/eZyo2tG0bUXCXiUA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Hart <dvha>

From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Minor editorial fixes:
- add some hyphens in multi-word adjectives
- add some periods for consistency
- add "'" for possessive CPU's
- capitalize IRQ when it's an acronym and not part of a function name

Signed-off-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Paul McKenney <paulmck-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Sebastian Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Joel Fernandes <joel-QYYGw3jwrUn5owFQY34kdNi2O/JbrIOy@public.gmane.org>
Cc: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
 Documentation/locking/locktypes.rst |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20200325.orig/Documentation/locking/locktypes.rst
+++ linux-next-20200325/Documentation/locking/locktypes.rst
@@ -84,7 +84,7 @@ rtmutex
 
 RT-mutexes are mutexes with support for priority inheritance (PI).
 
-PI has limitations on non PREEMPT_RT enabled kernels due to preemption and
+PI has limitations on non-PREEMPT_RT-enabled kernels due to preemption and
 interrupt disabled sections.
 
 PI clearly cannot preempt preemption-disabled or interrupt-disabled
@@ -150,7 +150,7 @@ kernel configuration including PREEMPT_R
 
 raw_spinlock_t is a strict spinning lock implementation in all kernels,
 including PREEMPT_RT kernels.  Use raw_spinlock_t only in real critical
-core code, low level interrupt handling and places where disabling
+core code, low-level interrupt handling and places where disabling
 preemption or interrupts is required, for example, to safely access
 hardware state.  raw_spinlock_t can sometimes also be used when the
 critical section is tiny, thus avoiding RT-mutex overhead.
@@ -160,20 +160,20 @@ spinlock_t
 
 The semantics of spinlock_t change with the state of PREEMPT_RT.
 
-On a non PREEMPT_RT enabled kernel spinlock_t is mapped to raw_spinlock_t
+On a non-PREEMPT_RT-enabled kernel spinlock_t is mapped to raw_spinlock_t
 and has exactly the same semantics.
 
 spinlock_t and PREEMPT_RT
 -------------------------
 
-On a PREEMPT_RT enabled kernel spinlock_t is mapped to a separate
+On a PREEMPT_RT-enabled kernel spinlock_t is mapped to a separate
 implementation based on rt_mutex which changes the semantics:
 
- - Preemption is not disabled
+ - Preemption is not disabled.
 
  - The hard interrupt related suffixes for spin_lock / spin_unlock
-   operations (_irq, _irqsave / _irqrestore) do not affect the CPUs
-   interrupt disabled state
+   operations (_irq, _irqsave / _irqrestore) do not affect the CPU's
+   interrupt disabled state.
 
  - The soft interrupt related suffix (_bh()) still disables softirq
    handlers.
@@ -279,7 +279,7 @@ fully preemptible context.  Instead, use
 spin_lock_irqsave() and their unlock counterparts.  In cases where the
 interrupt disabling and locking must remain separate, PREEMPT_RT offers a
 local_lock mechanism.  Acquiring the local_lock pins the task to a CPU,
-allowing things like per-CPU irq-disabled locks to be acquired.  However,
+allowing things like per-CPU IRQ-disabled locks to be acquired.  However,
 this approach should be used only where absolutely necessary.
 
 

