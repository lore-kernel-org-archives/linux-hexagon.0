From: Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v5 4/7] irq_work: Trace self-IPIs sent via arch_irq_work_raise()
Date: Tue,  7 Mar 2023 14:35:55 +0000
Message-ID: <20230307143558.294354-5-vschneid@redhat.com>
References: <20230307143558.294354-1-vschneid@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678199818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6o4aDoMnOyw6oIKqxXD/63VXzreRgu7lohjEhFx0NNg=;
	b=Ao4QbwWbSktSybuDY39U+gpdGB++k5B8E30vf6RrJwkdeEKBYzoy6+gg4jrLkdpMblBsiE
	uHwumVbW0WXigKK/ZeSE0zaDbXcocEP5Im2JQxVe2i+Y+td5hthJsoyHTLu19mGuhGhGov
	xWgeNP05MEv5vxD7pj+CSFP/EFPg1/w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678199818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6o4aDoMnOyw6oIKqxXD/63VXzreRgu7lohjEhFx0NNg=;
	b=Ao4QbwWbSktSybuDY39U+gpdGB++k5B8E30vf6RrJwkdeEKBYzoy6+gg4jrLkdpMblBsiE
	uHwumVbW0WXigKK/ZeSE0zaDbXcocEP5Im2JQxVe2i+Y+td5hthJsoyHTLu19mGuhGhGov
	xWgeNP05MEv5vxD7pj+CSFP/EFPg1/w=
In-Reply-To: <20230307143558.294354-1-vschneid@redhat.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Frederic Weisbecker <frederic@kernel.org>

IPIs sent to remote CPUs via irq_work_queue_on() are now covered by
trace_ipi_send_cpumask(), add another instance of the tracepoint to cover
self-IPIs.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/irq_work.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc43..c33e88e32a67a 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -22,6 +22,8 @@
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
+#include <trace/events/ipi.h>
+
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
@@ -74,6 +76,16 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static __always_inline void irq_work_raise(struct irq_work *work)
+{
+	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt())
+		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
+				       _RET_IP_,
+				       work->func);
+
+	arch_irq_work_raise();
+}
+
 /* Enqueue on current CPU, work must already be claimed and preempt disabled */
 static void __irq_work_queue_local(struct irq_work *work)
 {
@@ -99,7 +111,7 @@ static void __irq_work_queue_local(struct irq_work *work)
 
 	/* If the work is "lazy", handle it from next tick if any */
 	if (!lazy_work || tick_nohz_tick_stopped())
-		arch_irq_work_raise();
+		irq_work_raise(work);
 }
 
 /* Enqueue the irq work @work on the current CPU */
-- 
2.31.1

