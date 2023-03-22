From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
Date: Wed, 22 Mar 2023 10:53:29 +0100
Message-ID: <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
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
	List-Owner; bh=aSU9C6KQ3iLXqlvbNjNC/L9EyVC95mv2Uu2tuGqURBA=; b=GIsmBUV/XX2yhP
	5C/VlYOtkqwcdZXg7FNVeXOo5USChAqiAQNhsc22Q+QuVz7uFoMrhEV+/itiE3sHKQWQ1i5DZivu+
	9ViGdP7yiRZpq9V7R9Pe+afhvfAN2LWl6Ar1fHh6zymwF4tepzftJ5s65Jg1h4cqBMm8ewfrnKp7o
	foRkwdYjjmXLoyzExHCoMG/QNXJFRmp/Y2Dzgh+U2PXde8oF8MF3BWRF86Kz5JfVdf5HIXEu1mZY4
	lZS/B3boPYO9OH4gCOJo2rrwxmrDT9aGCBElxidYixWWsZqN/Eo/kU5MvF2j4+5cpysGGr64hE7uu
	1wTj5k7sOCYiBlwSYg8g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dfqJs0p1KTlCgT/AzQPPoQtSmUdmtzuztLmCgmrMzTI=; b=CzzNDRhr38Kip/OFg6dq3dQ4EV
	+GktrtbeR8GTSIKCXFNIi+R0Uog/v4u3G/O25UfC/mgZT3ndlGcMabgm6LrFN6fGis9ydvHcppxLT
	VwY3AmsL8HPpn5zrgxUXGj6CeuAuLVZoJ7UhzkhlIInAFBW3QLRk/B/v7JvwmMujV1bNxp++Hjosy
	wZt5vtgdBxpEoKGx18nO98pgqPhFFQBy0Pj+s5w9JmrOA97n6Bu/+USPMl8ce2eWJVbxbyQjTP6hs
	mqyM/HOaIsbNgCi2gGUWk2nA/SAiwaMSIlKMsEneUn3H6IgrNoG7/6DpUd9PIcenBZzlTeCjIrCVD
	xEhMpymQ==;
Content-Disposition: inline
In-Reply-To: <20230307143558.294354-8-vschneid@redhat.com>
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

On Tue, Mar 07, 2023 at 02:35:58PM +0000, Valentin Schneider wrote:

> @@ -477,6 +490,25 @@ static __always_inline void csd_unlock(struct __call_single_data *csd)
>  	smp_store_release(&csd->node.u_flags, 0);
>  }
>  
> +static __always_inline void
> +raw_smp_call_single_queue(int cpu, struct llist_node *node, smp_call_func_t func)
> +{
> +	/*
> +	 * The list addition should be visible to the target CPU when it pops
> +	 * the head of the list to pull the entry off it in the IPI handler
> +	 * because of normal cache coherency rules implied by the underlying
> +	 * llist ops.
> +	 *
> +	 * If IPIs can go out of order to the cache coherency protocol
> +	 * in an architecture, sufficient synchronisation should be added
> +	 * to arch code to make it appear to obey cache coherency WRT
> +	 * locking and barrier primitives. Generic code isn't really
> +	 * equipped to do the right thing...
> +	 */
> +	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
> +		send_call_function_single_ipi(cpu, func);
> +}
> +
>  static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
>  
>  void __smp_call_single_queue(int cpu, struct llist_node *node)
> @@ -493,21 +525,25 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
>  		}
>  	}
>  #endif
>  	/*
> +	 * We have to check the type of the CSD before queueing it, because
> +	 * once queued it can have its flags cleared by
> +	 *   flush_smp_call_function_queue()
> +	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
> +	 * executes migration_cpu_stop() on the remote CPU).
>  	 */
> +	if (trace_ipi_send_cpumask_enabled()) {
> +		call_single_data_t *csd;
> +		smp_call_func_t func;
> +
> +		csd = container_of(node, call_single_data_t, node.llist);
> +		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
> +			sched_ttwu_pending : csd->func;
> +
> +		raw_smp_call_single_queue(cpu, node, func);
> +	} else {
> +		raw_smp_call_single_queue(cpu, node, NULL);
> +	}
>  }

Hurmph... so we only really consume @func when we IPI. Would it not be
more useful to trace this thing for *every* csd enqeued?
