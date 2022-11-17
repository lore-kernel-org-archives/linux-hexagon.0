From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 4/8] smp: Trace IPIs sent via
 arch_send_call_function_ipi_mask()
Date: Thu, 17 Nov 2022 10:08:15 +0100
Message-ID: <Y3X5/65o8127DgZl@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-3-vschneid@redhat.com>
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
	List-Owner; bh=aN6mr1GNrY9WUzbVk3ckix2c511Wsm4fMm0iE5raUCg=; b=xiLKWBHG81y00N
	P4tuQi8gLQIKrFBWwpsntrS5HmwWUcpypWZnmL0lSOp1rJskiWWcuqqBSrF6wWv79Bxub/+QS1K3y
	QhgJ7OSaMzZ1BeGwcY8/wJth8e/jk5ku8Cf+EMmNYvfLjet5vY7kCAtDhU/dPWKsMhjo++6BtwMfb
	a8jGH/tylOAXRnt9gxS6MYonXkgMQeFQKlXmxn7sBfPM5kYX8yC5ex4Rzy5GHGGLV7Q4ukVsLueaW
	SEKco2t+r+Pn6TXBLml95Ff567TVe0sKxxLxPdaRw1CYCFFNQjcsjshdLwSox74JW8FV2j6U+4MYQ
	VmATFeibNo8HcR7fOTMg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aQk2rEVdOyLC8MBnXpxdsdOtZKvioHnImfV1oOS2Xtg=; b=I3xClU65IacOMLf2bWeSauP7FF
	FV50Hi48EBk2WK6Yehcm6XtdcO6hf4dsN2DMpSf1Q8J+ZcUcJOT8oIO1945EQRsvfdc4JvICopd0l
	Ui4r6qLsEQxO7P9sxXUeh9gS9sZqkCJSKZK2ctS17TuNst0NjO4G5IjBK7pt6TA2UoyWMLe7JrlZ4
	3rVanZNI9MF1KBvk8SzTNZKx8hjhh1qDV56hj7OC6Wv8JNJ6ypUqg8KZLLfwkKn7jGczcYvLbevRx
	fdi5hL+kowpdqhlUAfa1HbfNoACRcwrRe8SG0NXXobWd3RkjDM5DSjIiSED2Yxip/fi/HuoFKOMRj
	0mZtwn6g==;
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-3-vschneid@redhat.com>
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

On Wed, Nov 02, 2022 at 06:33:32PM +0000, Valentin Schneider wrote:
> This simply wraps around the arch function and prepends it with a
> tracepoint, similar to send_call_function_single_ipi().
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/smp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index e2ca1e2f31274..c4d561cf50d45 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -160,6 +160,13 @@ void __init call_function_init(void)
>  	smpcfd_prepare_cpu(smp_processor_id());
>  }
>  
> +static inline void

Given the use of _RET_IP_, I would strongly recommend you use
__always_inline.

> +send_call_function_ipi_mask(const struct cpumask *mask)
> +{
> +	trace_ipi_send_cpumask(mask, _RET_IP_, func);

What's func?

> +	arch_send_call_function_ipi_mask(mask);
> +}
