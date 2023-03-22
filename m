From: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
Date: Wed, 22 Mar 2023 17:01:13 +0000
Message-ID: <xhsmhjzz8d8km.mognet@vschneid.remote.csb>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
 <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
 <xhsmhmt45c703.mognet@vschneid.remote.csb>
 <20230322140434.GC2357380@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Aa0z2qPnUIfo/tyR5PFPxgQ2Vu0g3bQ3Yuq5j/hvBGk=; b=IQ4bmvvmVXwsGY
	Bc/PRTCKkxdpdO8NzFIBUd2kZtWyIccXMlfntWTOv2ujQAGwUGs5cvp7U6diX0+MFH3XDrmsMbib6
	jgMttAOKuTDuNOGCESkgHzsO7vGNdp8qMjjL82BTwetd4kDlzu42sfd7HVAzHE8nedr95yyWjMHLQ
	hGr6iLJYyPHHypRzkBH4VBGYoCnjvTLJNLYX0hRehYE3H0q8Gjq78XhZXV8eL0KWkVn0SYHQwKnoE
	HwGGH0h1Pxo6xGCjgP9/JDOTSb85kvsetvvjMAojFAPI3ZI12pXwg89Tegmn5n7mDt8ktW2isJyw8
	1eUomQ3ZRIaBdNDmdABA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679504484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZS63eR35hQQpuztlWGnGcv/jaBVlYMjTvbdWWfPWAY=;
	b=R3wXvEy72H8DcVvRWZo9a//6v+b5En0EzBxfc4xHkMLClw1tc78evZr3GgYrWXhBrKPOXg
	PEwV9S3IIQ+BoQp1ZiT51WCfYq0YSGMMCv6TBC3xop+CgRumdNECwRpYwXSVkF+1+n4K0G
	+R5bCoOdVHpe8s7wie3+uVSMT3ivBYQ=
In-Reply-To: <20230322140434.GC2357380@hirez.programming.kicks-ass.net>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo>

On 22/03/23 15:04, Peter Zijlstra wrote:
> On Wed, Mar 22, 2023 at 12:20:28PM +0000, Valentin Schneider wrote:
>> On 22/03/23 10:53, Peter Zijlstra wrote:
>
>> > Hurmph... so we only really consume @func when we IPI. Would it not be
>> > more useful to trace this thing for *every* csd enqeued?
>>
>> It's true that any CSD enqueued on that CPU's call_single_queue in the
>> [first CSD llist_add()'ed, IPI IRQ hits] timeframe is a potential source of
>> interference.
>>
>> However, can we be sure that first CSD isn't an indirect cause for the
>> following ones? say the target CPU exits RCU EQS due to the IPI, there's a
>> bit of time before it gets to flush_smp_call_function_queue() where some other CSD
>> could be enqueued *because* of that change in state.
>>
>> I couldn't find a easy example of that, I might be biased as this is where
>> I'd like to go wrt IPI'ing isolated CPUs in usermode. But regardless, when
>> correlating an IPI IRQ with its source, we'd always have to look at the
>> first CSD in that CSD stack.
>
> So I was thinking something like this:
>
> ---
> Subject: trace,smp: Trace all smp_function_call*() invocations
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Mar 22 14:58:36 CET 2023
>
> (Ab)use the trace_ipi_send_cpu*() family to trace all
> smp_function_call*() invocations, not only those that result in an
> actual IPI.
>
> The queued entries log their callback function while the actual IPIs
> are traced on generic_smp_call_function_single_interrupt().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/smp.c |   58 ++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
>
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -106,18 +106,20 @@ void __init call_function_init(void)
>  }
>
>  static __always_inline void
> -send_call_function_single_ipi(int cpu, smp_call_func_t func)
> +send_call_function_single_ipi(int cpu)
>  {
>       if (call_function_single_prep_ipi(cpu)) {
> -		trace_ipi_send_cpu(cpu, _RET_IP_, func);
> +		trace_ipi_send_cpu(cpu, _RET_IP_,
> +				   generic_smp_call_function_single_interrupt);

Hm, this does get rid of the func being passed down the helpers, but this
means the trace events are now stateful, i.e. I need the first and last
events in a CSD stack to figure out which one actually caused the IPI.

It also requires whoever is looking at the trace to be aware of which IPIs
are attached to a CSD, and which ones aren't. ATM that's only the resched
IPI, but per the cover letter there's more to come (e.g. tick_broadcast()
for arm64/riscv and a few others). For instance:

       hackbench-157   [001]    10.894320: ipi_send_cpu:         cpu=3 callsite=check_preempt_curr+0x37 callback=0x0
       hackbench-157   [001]    10.895068: ipi_send_cpu:         cpu=3 callsite=try_to_wake_up+0x29e callback=sched_ttwu_pending+0x0
       hackbench-157   [001]    10.895068: ipi_send_cpu:         cpu=3 callsite=try_to_wake_up+0x29e callback=generic_smp_call_function_single_interrupt+0x0

That first one sent a RESCHEDULE IPI, the second one a CALL_FUNCTION one,
but you really have to know what you're looking at...

Are you worried about the @func being pushed down? Staring at x86 asm is
not good for the soul, but AFAICT this does cause an extra register to be
popped in the prologue because all of the helpers are __always_inline, so
both paths of the static key(s) are in the same stackframe.

I can "improve" this with:

---
diff --git a/kernel/smp.c b/kernel/smp.c
index 5cd680a7e78ef..55f120dae1713 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -511,6 +511,26 @@ raw_smp_call_single_queue(int cpu, struct llist_node *node, smp_call_func_t func
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
+static noinline void __smp_call_single_queue_trace(int cpu, struct llist_node *node)
+{
+	call_single_data_t *csd;
+	smp_call_func_t func;
+
+
+	/*
+	 * We have to check the type of the CSD before queueing it, because
+	 * once queued it can have its flags cleared by
+	 *   flush_smp_call_function_queue()
+	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
+	 * executes migration_cpu_stop() on the remote CPU).
+	 */
+	csd = container_of(node, call_single_data_t, node.llist);
+	func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
+		sched_ttwu_pending : csd->func;
+
+	raw_smp_call_single_queue(cpu, node, func);
+}
+
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
@@ -525,25 +545,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		}
 	}
 #endif
-	/*
-	 * We have to check the type of the CSD before queueing it, because
-	 * once queued it can have its flags cleared by
-	 *   flush_smp_call_function_queue()
-	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
-	 * executes migration_cpu_stop() on the remote CPU).
-	 */
-	if (trace_ipi_send_cpumask_enabled()) {
-		call_single_data_t *csd;
-		smp_call_func_t func;
-
-		csd = container_of(node, call_single_data_t, node.llist);
-		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
-			sched_ttwu_pending : csd->func;
-
-		raw_smp_call_single_queue(cpu, node, func);
-	} else {
+	if (trace_ipi_send_cpumask_enabled())
+		__smp_call_single_queue_trace(cpu, node);
+	else
 		raw_smp_call_single_queue(cpu, node, NULL);
-	}
 }
 
 /*
