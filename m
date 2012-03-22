From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 1/4] hexagon/CPU hotplug: Add missing call to
 notify_cpu_starting()
Date: Thu, 22 Mar 2012 16:58:25 +0530
Message-ID: <20120322112805.17063.19393.stgit@srivatsabhat.in.ibm.com>
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

 arch/hexagon/kernel/smp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0123c63..71ad6e9 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -178,7 +178,12 @@ void __cpuinit start_secondary(void)
 
 	printk(KERN_INFO "%s cpu %d\n", __func__, current_thread_info()->cpu);
 
+	notify_cpu_starting(cpu);
+
+	ipi_call_lock();
 	set_cpu_online(cpu, true);
+	ipi_call_unlock();
+
 	local_irq_enable();
 
 	cpu_idle();

