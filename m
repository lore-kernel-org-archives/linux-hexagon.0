From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 5/8] irq_work: Trace self-IPIs sent via
 arch_irq_work_raise()
Date: Thu, 17 Nov 2022 10:10:57 +0100
Message-ID: <Y3X6oQdySdXBh7v8@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-4-vschneid@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x6khUQIilWa+57z52ezUFxnqVas3b5vxIahVKh/sup8=; b=H29UQz/DyA2P7L
	mX+QCsf/kBZwoNeGXBQ1YRGQLnxzcnNoMywMZxCnd1kJCP0bl6fYNIjqamFe0G6mLg8mKHVIXMy+g
	AQwcvm9tVmsSc3eYTLlTHXj1sN0A2n/LxB5kan7+ngl6/rfoplW9jPlqYFZoJIyOx4hU4tNfFkQdp
	UuFZ+qHiNzW/oPTD5pUbXpsu0BGYro6o+tL4K0VRhKbP/wKoQLheKo4YtAqmvmhetfCpPq5pXJNUA
	qW6Q4XzYO6e8fCbbBqQa2BIcEU/N1RXIAsmH7zW9zwZlQSM3jEn7NZKrySrys1Uk3o30QQeopL5KL
	VlDJiue6bcNrDqByUYvQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rs9mPbZMWkmGpFMwZXAxzgJsIHnGFVekqWq8NHBYPaE=; b=R1R3c0H1DMOPHL2EgzaQiKmWc6
	4g7vKNmWUZA3OnVQZ/791nS7MV15HGuXYR4LWct/zjRRgTK+dNnL85b46VmpoobJ+EHG/3iX5n7IA
	+equo9lBjaJUg3gTG+mevrb7K9jv6FfkkHfl2p47Rs0cy6NoLBkr9vyQZjccWCdTguIbSq3W8L+M+
	g5vZQ/0UzVMiD70Ih/xvhFHjAJMHV/ca+Xik2nReUKV0TeWwkr909DO60dbGyjqIg2jCR8xKkeWGW
	uwTyKLOnFvLCxPonjQNLfIhyogu3+VVn7IZf6T5ilF6RWcC9C3xOpf/z/mpnIIqLWzT4qucfdy49N
	D47XaqmA==;
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-4-vschneid@redhat.com>
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
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mi>

On Wed, Nov 02, 2022 at 06:33:33PM +0000, Valentin Schneider wrote:
> IPIs sent to remove CPUs via irq_work_queue_on() are now covered by
> trace_ipi_send_cpumask(), add another instance of the tracepoint to cover
> self-IPIs.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/irq_work.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 7afa40fe5cc43..aec38c294ce68 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -22,6 +22,8 @@
>  #include <asm/processor.h>
>  #include <linux/kasan.h>
>  
> +#include <trace/events/ipi.h>
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>  static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> @@ -74,6 +76,16 @@ void __weak arch_irq_work_raise(void)
>  	 */
>  }
>  
> +static inline void irq_work_raise(struct irq_work *work)

__always_inline, unless you want to occasionally only see it point to
__irq_work_queue_local().

> +{
> +	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt()) {
> +		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
> +				       _RET_IP_,
> +				       work->func);
	}
> +
> +	arch_irq_work_raise();
> +}
> +
>  /* Enqueue on current CPU, work must already be claimed and preempt disabled */
>  static void __irq_work_queue_local(struct irq_work *work)
>  {
> @@ -99,7 +111,7 @@ static void __irq_work_queue_local(struct irq_work *work)
>  
>  	/* If the work is "lazy", handle it from next tick if any */
>  	if (!lazy_work || tick_nohz_tick_stopped())
> -		arch_irq_work_raise();
> +		irq_work_raise(work);
>  }
>  
>  /* Enqueue the irq work @work on the current CPU */
> -- 
> 2.31.1
> 
