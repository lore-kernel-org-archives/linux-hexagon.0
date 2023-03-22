From: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v5 1/7] trace: Add trace_ipi_send_cpumask()
Date: Wed, 22 Mar 2023 11:24:53 +0000
Message-ID: <xhsmhpm91c9kq.mognet@vschneid.remote.csb>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-2-vschneid@redhat.com>
 <20230322093955.GR2017917@hirez.programming.kicks-ass.net>
 <20230322103004.GA571242@hirez.programming.kicks-ass.net>
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
	List-Owner; bh=wmDgNMv9DxKQvBLwcoENUsqQKTp3ZqK1Y/MfhzUdTtI=; b=eynaQwrYyCsH7p
	zJCbi66IJQXhhWRiCQcbM5B0ptaiT2GkVIMg0hAjRmqvDBrIxYiwRjkY7jmMSDNy9/ct/ZsOzXQHs
	Mpx36jfVk5ttCdIVx8TjmUe5cMfAym8+2Bg6V3+s4zMYSyUvccSB/B/3YWO/LqfCKCaINMi4yaA0T
	DC4AT/pV1z/kB/jCZ71SjyOXgR6RcQp4FX0y94su2Zh8NnyVJGgij0hKd3RSz+QlMUFImRTkTA8eO
	qZgwqZFeEcU4gR8WmSFuYHOj6Y/HuftQUg0yZBHtRes8u72X7uoDih0tm+1Lfq+REq/sz6NvhoczV
	Hz8LqxBaaEcrkmcfqwzQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679484303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeeQx+I+dRtKj5nSnz4ngzuZMZMfDzExS1NioY8sNjE=;
	b=YiHCcEMklnPO1Nnsc6FZEFkoAjKCP+8zw8PmMOPG8ZtoPhd4DcKa40P5t1WvJCGLw1i9/Z
	xGOfqk5p/rol+DVvScIDktQyC1nlY7yLxxbrXh4UjvoDYSbqbtgY4jZ09TLgqTzFSTXShx
	tE5Bxrp6JhkLWOsiCe7J+lRfmR19q+U=
In-Reply-To: <20230322103004.GA571242@hirez.programming.kicks-ass.net>
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
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo>

On 22/03/23 11:30, Peter Zijlstra wrote:
> On Wed, Mar 22, 2023 at 10:39:55AM +0100, Peter Zijlstra wrote:
>> On Tue, Mar 07, 2023 at 02:35:52PM +0000, Valentin Schneider wrote:
>> > +TRACE_EVENT(ipi_send_cpumask,
>> > +
>> > +	TP_PROTO(const struct cpumask *cpumask, unsigned long callsite, void *callback),
>> > +
>> > +	TP_ARGS(cpumask, callsite, callback),
>> > +
>> > +	TP_STRUCT__entry(
>> > +		__cpumask(cpumask)
>> > +		__field(void *, callsite)
>> > +		__field(void *, callback)
>> > +	),
>> > +
>> > +	TP_fast_assign(
>> > +		__assign_cpumask(cpumask, cpumask_bits(cpumask));
>> > +		__entry->callsite = (void *)callsite;
>> > +		__entry->callback = callback;
>> > +	),
>> > +
>> > +	TP_printk("cpumask=%s callsite=%pS callback=%pS",
>> > +		  __get_cpumask(cpumask), __entry->callsite, __entry->callback)
>> > +);
>>
>> Would it make sense to add a variant like: ipi_send_cpu() that records a
>> single cpu instead of a cpumask. A lot of sites seems to do:
>> cpumask_of(cpu) for that first argument, and it seems to me it is quite
>> daft to have to memcpy a full multi-word cpumask in those cases.
>>
>> Remember, nr_possible_cpus > 64 is quite common these days.
>
> Something we litte bit like so...
>

I was wondering whether we could stick with a single trace event, but let
ftrace be aware of weight=1 vs weight>1 cpumasks.

For weight>1, it would memcpy() as usual, for weight=1, it could write a
pointer to a cpu_bit_bitmap[] equivalent embedded in the trace itself.

Unfortunately, Ftrace bitmasks are represented as a u32 made of two 16 bit
values: [offset in event record, size], so there isn't a straightforward
way to point to a "reusable" cpumask. AFAICT the only alternative would be
to do that via a different trace event, but then we should just go with a
plain old uint - i.e. do what you're doing here, so:

Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>

(with the tiny typo fix below)

> @@ -35,6 +35,28 @@ TRACE_EVENT(ipi_raise,
>       TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
>  );
>
> +TRACE_EVENT(ipi_send_cpu,
> +
> +	TP_PROTO(const unsigned int cpu, unsigned long callsite, void *callback),
> +
> +	TP_ARGS(cpu, callsite, callback),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(void *, callsite)
> +		__field(void *, callback)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->callsite = (void *)callsite;
> +		__entry->callback = callback;
> +	),
> +
> +	TP_printk("cpu=%s callsite=%pS callback=%pS",
                        ^
                      s/s/u/

> +		  __entry->cpu, __entry->callsite, __entry->callback)
> +);
> +
