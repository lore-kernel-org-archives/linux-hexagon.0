From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 25/36] time/tick-broadcast: Remove RCU_NONIDLE usage
Date: Tue, 14 Jun 2022 17:28:02 +0100
Message-ID: <Yqi3EmHbuvf3ItMI@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.507286638@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20220608144517.507286638@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, paul

On Wed, Jun 08, 2022 at 04:27:48PM +0200, Peter Zijlstra wrote:
> No callers left that have already disabled RCU.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/time/tick-broadcast-hrtimer.c |   29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> --- a/kernel/time/tick-broadcast-hrtimer.c
> +++ b/kernel/time/tick-broadcast-hrtimer.c
> @@ -56,25 +56,20 @@ static int bc_set_next(ktime_t expires,
>  	 * hrtimer callback function is currently running, then
>  	 * hrtimer_start() cannot move it and the timer stays on the CPU on
>  	 * which it is assigned at the moment.
> +	 */
> +	hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
> +	/*
> +	 * The core tick broadcast mode expects bc->bound_on to be set
> +	 * correctly to prevent a CPU which has the broadcast hrtimer
> +	 * armed from going deep idle.
>  	 *
> -	 * As this can be called from idle code, the hrtimer_start()
> -	 * invocation has to be wrapped with RCU_NONIDLE() as
> -	 * hrtimer_start() can call into tracing.
> +	 * As tick_broadcast_lock is held, nothing can change the cpu
> +	 * base which was just established in hrtimer_start() above. So
> +	 * the below access is safe even without holding the hrtimer
> +	 * base lock.
>  	 */
> -	RCU_NONIDLE( {
> -		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
> -		/*
> -		 * The core tick broadcast mode expects bc->bound_on to be set
> -		 * correctly to prevent a CPU which has the broadcast hrtimer
> -		 * armed from going deep idle.
> -		 *
> -		 * As tick_broadcast_lock is held, nothing can change the cpu
> -		 * base which was just established in hrtimer_start() above. So
> -		 * the below access is safe even without holding the hrtimer
> -		 * base lock.
> -		 */
> -		bc->bound_on = bctimer.base->cpu_base->cpu;
> -	} );
> +	bc->bound_on = bctimer.base->cpu_base->cpu;
> +
>  	return 0;
>  }
>  
> 
> 
