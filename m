From: Joe Perches <joe@perches.com>
Subject: Re: [patch v2 21/35] Hexagon: Add SMP support
Date: Tue, 30 Aug 2011 12:30:36 -0700
Message-ID: <1314732636.14422.8.camel@Joe-Laptop>
References: <20110830190729.923334292@codeaurora.org>
	 <20110830190801.707601780@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190801.707601780@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, 2011-08-30 at 14:07 -0500, Richard Kuo wrote:
> plain text document attachment (smp.diff)
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
[]
> +static inline void __handle_ipi(unsigned long *ops, struct ipi_data *ipi,
> +				int cpu)
> +{
> +	do {
> +		unsigned long msg = msg = ffz(~*ops);

Really?  That's unlikely to be the right code.
Maybe just one msg?

> +
> +		*ops &= ~(1 << msg);
> +
> +		switch (msg) {
> +		case IPI_TIMER:
> +			ipi_timer();
> +			break;
> +		case IPI_CALL_FUNC:
> +		{

> +			struct smp_call_struct *data =
> +				smp_call_function_data;
> +			void (*func) (void *info) =
> +				data->func;

No need to wrap either of these.

> +			void *info = data->info;
> +			int wait = data->wait;
> +
> +			smp_mb();
> +			cpumask_clear_cpu(cpu, &data->pending);
> +
> +			(*func)(info);
> +
> +			smp_mb();
> +			if (wait)
> +				cpumask_clear_cpu(cpu,
> +					&data->unfinished);

or here.


