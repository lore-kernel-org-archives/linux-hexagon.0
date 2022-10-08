From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 4/5] irq_work: Trace calls to arch_irq_work_raise()
Date: Sat, 8 Oct 2022 15:34:42 -0400
Message-ID: <20221008153442.159b2f2d@rorschach.local.home>
References: <20221007154145.1877054-1-vschneid@redhat.com>
        <20221007154533.1878285-4-vschneid@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20221007154533.1878285-4-vschneid@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>

On Fri,  7 Oct 2022 16:45:32 +0100
Valentin Schneider <vschneid@redhat.com> wrote:
>  }
>  
> +static inline void irq_work_raise(void)
> +{
> +	if (arch_irq_work_has_interrupt())
> +		trace_ipi_send_cpu(_RET_IP_, smp_processor_id());

To save on the branch, let's make the above:

	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())

As the "trace_*_enabled()" is a static branch that will make it a nop
when the tracepoint is not enabled.

-- Steve


> +
> +	arch_irq_work_raise();
> +}
> +
>  /* Enqueue on current CPU, work must already be claimed and preempt disabled */
