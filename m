From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 1/7] trace: Add trace_ipi_send_cpumask()
Date: Wed, 22 Mar 2023 10:39:55 +0100
Message-ID: <20230322093955.GR2017917@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-2-vschneid@redhat.com>
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
	List-Owner; bh=2VpewIFpm7v9QVnhtW+13uFGN5b6XLasQX9AOe5LpsM=; b=2Df6i1Kuk4ISSW
	4plzR6RQXDKCUDyImtmkFzwfNFIrQJHB/oJc7hVT5CUdoTL1rqvBT4MK4jLz7wDEDJErXy2+z8C3U
	fJmKIsRpAgciu6vV8YbxP0szkOa9N5evVpMGdpVfAOsIE4XMBXFSEgTpJPr2XoT2aR/kWgrD1Pl+C
	xiGJIXaXiqvGS8+ww3cFfawIdmHrjCcjBG5RarnwxJNlZKD4o3UY/9P4HG37earUAX/fIqeXG36oQ
	ivzJBUHgBNtvcNzxdgh0DKiI8iVxXN2JQwt3xQFae4XxirkHzF58Ck823oZpXVXfgrPVwE48qLhLs
	11foFBkVB0+27qEeVULA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NIAHg4If27BetC+4UZobAV0PxBnmTt3z+fWts2bKQWA=; b=rgS/CEWAlsTurPe5ucKBiXaDhr
	ew26BoXauCH9lin/sWfYKxjLJe0WysSt1P4iOSDXV1qfu4JSoUQNAlogwxNIDbcZw5jKIurC6wBP0
	+/+Z8kdUTp/ZyyNP9QPql3dhW8rHV0QqkfTXWuMoE0vryMGgt+T+aOFFPTKbmbiRK5T84YLaG6C4t
	iRHD6M2ZFvI2kES3RCcIFI7D2yWW07o0ZjcKw1qqr5MTJddfTUE9AHHetindb2rqkUVxpV/GEVyQu
	B4Z/fkelloNxIIEvBXXKz9pvL88Uc5JVf1N0nCKJVM3jEC4cK78BNevAeHHN3c0k/dy9sGC9ChrU5
	42+coITw==;
Content-Disposition: inline
In-Reply-To: <20230307143558.294354-2-vschneid@redhat.com>
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
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mi>

On Tue, Mar 07, 2023 at 02:35:52PM +0000, Valentin Schneider wrote:
> trace_ipi_raise() is unsuitable for generically tracing IPI sources due to
> its "reason" argument being an uninformative string (on arm64 all you get
> is "Function call interrupts" for SMP calls).
> 
> Add a variant of it that exports a target cpumask, a callsite and a callback.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/events/ipi.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
> index 0be71dad6ec03..b1125dc27682c 100644
> --- a/include/trace/events/ipi.h
> +++ b/include/trace/events/ipi.h
> @@ -35,6 +35,28 @@ TRACE_EVENT(ipi_raise,
>  	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
>  );
>  
> +TRACE_EVENT(ipi_send_cpumask,
> +
> +	TP_PROTO(const struct cpumask *cpumask, unsigned long callsite, void *callback),
> +
> +	TP_ARGS(cpumask, callsite, callback),
> +
> +	TP_STRUCT__entry(
> +		__cpumask(cpumask)
> +		__field(void *, callsite)
> +		__field(void *, callback)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_cpumask(cpumask, cpumask_bits(cpumask));
> +		__entry->callsite = (void *)callsite;
> +		__entry->callback = callback;
> +	),
> +
> +	TP_printk("cpumask=%s callsite=%pS callback=%pS",
> +		  __get_cpumask(cpumask), __entry->callsite, __entry->callback)
> +);

Would it make sense to add a variant like: ipi_send_cpu() that records a
single cpu instead of a cpumask. A lot of sites seems to do:
cpumask_of(cpu) for that first argument, and it seems to me it is quite
daft to have to memcpy a full multi-word cpumask in those cases.

Remember, nr_possible_cpus > 64 is quite common these days.
