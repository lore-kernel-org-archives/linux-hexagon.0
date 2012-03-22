From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 3/4] parisc/CPU hotplug: Add missing call to
 notify_cpu_starting()
Date: Thu, 22 Mar 2012 16:58:59 +0530
Message-ID: <20120322112852.17063.4629.stgit@srivatsabhat.in.ibm.com>
References: <20120322112735.17063.21791.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20120322112735.17063.21791.stgit@srivatsabhat.in.ibm.com>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo@codeaurora.org, tglx@linutronix.de, linas@codeaurora.org, mingo@elte.hu, a.p.zijlstra@chello.nl, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, akpm@linux-foundation.org, benh@kernel.crashing.org, jesper.nilsson@axis.com, cmetcalf@tilera.com, linux@arm.linux.org.uk, jejb@parisc-linux.org, deller@gmx.de, vapier@gentoo.org
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org

The scheduler depends on receiving the CPU_STARTING notification, without
which we end up into a lot of trouble. So add the missing call to
notify_cpu_starting() in the bringup code.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/parisc/kernel/smp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 32d5884..50a4581 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -297,8 +297,13 @@ smp_cpu_init(int cpunum)
 
 		printk(KERN_CRIT "CPU#%d already initialized!\n", cpunum);
 		machine_halt();
-	}  
+	}
+
+	notify_cpu_starting(cpunum);
+
+	ipi_call_lock();
 	set_cpu_online(cpunum, true);
+	ipi_call_unlock();
 
 	/* Initialise the idle task for this CPU */
 	atomic_inc(&init_mm.mm_count);

