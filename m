From: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
Date: Thu, 23 Mar 2023 18:31:37 +0000
Message-ID: <xhsmh8rfncoae.mognet@vschneid.remote.csb>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
 <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
 <xhsmhmt45c703.mognet@vschneid.remote.csb>
 <20230322140434.GC2357380@hirez.programming.kicks-ass.net>
 <xhsmhbkkjcu4q.mognet@vschneid.remote.csb>
 <20230323174129.GA2753619@hirez.programming.kicks-ass.net>
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
	List-Owner; bh=elzNdtolzgNLcUPJz4OGmM3OabslhaFlP8v2hRoNFCE=; b=iWvx6ssFB3pcVl
	nnplUDpWpMt5WncQ8rSmX08NMi7juuwTfBnWjGcdAirUS7K7yYnZBfDMcPPsfC159DJdo+4RxRNPQ
	6r+UU3RUi4CpTVFpOvu/v+W5jUI1Gg0sl2fMmBOshKbq2ARsICMEXWl0MGVK1ksj4CHMXz7XsPMkP
	r+yYORMv36jv3GEIf1iH7ZdbiG4V1a1qIF9oA7zHRTUMAo13/hKkrbuem0PXZZRmx3NRgD88R2L5o
	yMq6aCvCI/IBhb/+/e7SlXw394Fb4w/081aJE2xvmGwgKCiXSB9x0GtSnnbcdM3kL7geZGjzStt5X
	Nw7wdSHx11b0YxaErU/w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679596303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQhuytQNa//R38jUclcb8GrjXYgITp5dQj88746r1Bo=;
	b=hzzGJfyMtg4+UYZoLvcYhCd5Zk005nkpFZgR0cdlzrx/hOqAQ2LUYi85ah3jZCHs+und4z
	d/RRANXxSfkwckr2w3euoDn84gzckfO/k3WOBsHaZo2dGyyNjJVzMuKPbxFep4+VqsheOd
	JbyoMkzpBilWzvfKoxlJQy7I04aZ1Ok=
In-Reply-To: <20230323174129.GA2753619@hirez.programming.kicks-ass.net>
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

On 23/03/23 18:41, Peter Zijlstra wrote:
> On Thu, Mar 23, 2023 at 04:25:25PM +0000, Valentin Schneider wrote:
>> On 22/03/23 15:04, Peter Zijlstra wrote:
>> > @@ -798,14 +794,20 @@ static void smp_call_function_many_cond(
>> >  		}
>> >  
>> >  		/*
>> > +		 * Trace each smp_function_call_*() as an IPI, actual IPIs
>> > +		 * will be traced with func==generic_smp_call_function_single_ipi().
>> > +		 */
>> > +		trace_ipi_send_cpumask(cfd->cpumask_ipi, _RET_IP_, func);
>> 
>> I just got a trace pointing out this can emit an event even though no IPI
>> is sent if e.g. the cond_func predicate filters all CPUs in the argument
>> mask:
>> 
>>   ipi_send_cpumask:     cpumask= callsite=on_each_cpu_cond_mask+0x3c callback=flush_tlb_func+0x0
>> 
>> Maybe something like so on top?
>> 
>> ---
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index ba5478814e677..1dc452017d000 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -791,6 +791,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>>  			}
>>  		}
>>  
>> +		if (!nr_cpus)
>> +			goto local;
>
> Hmm, this isn't right. You can get nr_cpus==0 even though it did add
> some to various lists but never was first.
>

Duh, glanced over that.

> But urgh, even if we were to say count nr_queued we'd never get the mask
> right, because we don't track which CPUs have the predicate matched,
> only those we need to actually send an IPI to :/
>
> Ooh, I think we can clear those bits from cfd->cpumask, arguably that's
> a correctness fix too, because the 'run_remote && wait' case shouldn't
> wait on things we didn't queue.
>

Yeah, that makes sense to me. Just one tiny suggestion below.

> Hmm?
>
>
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -728,9 +728,9 @@ static void smp_call_function_many_cond(
>  	int cpu, last_cpu, this_cpu = smp_processor_id();
>  	struct call_function_data *cfd;
>  	bool wait = scf_flags & SCF_WAIT;
> +	int nr_cpus = 0, nr_queued = 0;
>  	bool run_remote = false;
>  	bool run_local = false;
> -	int nr_cpus = 0;
>  
>  	lockdep_assert_preemption_disabled();
>  
> @@ -772,8 +772,10 @@ static void smp_call_function_many_cond(
>  		for_each_cpu(cpu, cfd->cpumask) {
>  			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
>  
> -			if (cond_func && !cond_func(cpu, info))
> +			if (cond_func && !cond_func(cpu, info)) {
> +				__cpumask_clear_cpu(cpu, cfd->cpumask);
>  				continue;
> +			}
>  
>  			csd_lock(csd);
>  			if (wait)
> @@ -789,13 +791,15 @@ static void smp_call_function_many_cond(
>  				nr_cpus++;
>  				last_cpu = cpu;
>  			}
> +			nr_queued++;
>  		}
>  
>  		/*
>  		 * Trace each smp_function_call_*() as an IPI, actual IPIs
>  		 * will be traced with func==generic_smp_call_function_single_ipi().
>  		 */
> -		trace_ipi_send_cpumask(cfd->cpumask_ipi, _RET_IP_, func);
> +		if (nr_queued)

With your change to cfd->cpumask, we could ditch nr_queued and make this

                if (!cpumask_empty(cfd->cpumask))

since cfd->cpumask now only contains CPUs that have had a CSD queued.

> +			trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, func);
>  
>  		/*
>  		 * Choose the most efficient way to send an IPI. Note that the
