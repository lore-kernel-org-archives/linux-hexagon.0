From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 6/8] treewide: Trace IPIs sent via
 smp_send_reschedule()
Date: Thu, 17 Nov 2022 10:12:42 +0100
Message-ID: <Y3X7CijMXpqQIHhk@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-5-vschneid@redhat.com>
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
	List-Owner; bh=WoKDgG5gY/9IrgwkG2aYHMRtwAZd0jOyuQmBS8aN+4w=; b=rZHVFkyMeVQn5D
	sRe6hOQYuTZNAoVWO7pFtYdH8Y2w0a3WgfXSFPcHQ6uhCFEjfVWA/mlxoEPGztgQCC53b2k1CWtV7
	IgY4LUykBsI1TnQFXadlNahov2cIWYqK3lof+cWDQqfCYC9HFZezwvVMsR4ylXaIglUqD23FrHLCW
	kmbFz+0NeGFtPIoyg5d/IeXftcLPBNCXZNt7APzDyNmWBWFzNfEmAa3NbGcPlZ6WWJjMhg+JKXuux
	AUTQiC0H9Kj/a2/yWyvwpp5hPP5iQkzlFez01FgnOihm6e6vLuHwuIZZHzJQNMA6UoMO/5qewxlvO
	rzoMD6HV4sAKEyV+ybsA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nUeE98iw6CYI9P0UZFByNwbWM7T2dlFSVRfygox+oVI=; b=MgJlSA98izh3Lsqm003kpG/mL+
	EevnyLvSFZGX2upk5Jm3WoFC0zvMiO9eBcctfFuhCt0XhehaHroYVKWnLvTx2YsjGIrzuGTlhwGvs
	ycCoIWu5IDrMhT6T0Vi9JKGscYUfbfB21Xy6W0jd+DCfony3PxwWRKrtPSdJZrzWtEqZEBCvPcFMg
	OLvECk1Ph+NKITycPx1vBHQR0FuPmuJhwXJ21vaX9wcNqYWS8QSTCsgQr4GqwF5v3RYfO9wdSx7gz
	c1jMwXTl1i9DvI2bX3n8bA3RjH0bLkkRWvGkx0zXza/d9lP8P7CcehYOSzaseZ7O8CZ8vSGUJmsXd
	ZRL7zqAw==;
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-5-vschneid@redhat.com>
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
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, Guo Ren <guoren@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Frederic Weisbecker <frederic>

On Wed, Nov 02, 2022 at 06:33:34PM +0000, Valentin Schneider wrote:

> diff --git a/kernel/smp.c b/kernel/smp.c
> index c4d561cf50d45..44fa4b9b1f46b 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -167,6 +167,14 @@ send_call_function_ipi_mask(const struct cpumask *mask)
>  	arch_send_call_function_ipi_mask(mask);
>  }
>  
> +void smp_send_reschedule(int cpu)
> +{
> +	/* XXX scheduler_ipi is inline :/ */
> +	trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
> +	arch_smp_send_reschedule(cpu);
> +}
> +EXPORT_SYMBOL_GPL(smp_send_reschedule);

Yeah, no.. I see some crazy archs do this, but no we're not exporting
this in generic.
