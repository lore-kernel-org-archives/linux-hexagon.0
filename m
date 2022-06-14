From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 16/36] rcu: Fix rcu_idle_exit()
Date: Tue, 14 Jun 2022 17:14:57 +0100
Message-ID: <Yqi0AVZmI5GyVpNa@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.935970247@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20220608144516.935970247@infradead.org>
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

On Wed, Jun 08, 2022 at 04:27:39PM +0200, Peter Zijlstra wrote:
> Current rcu_idle_exit() is terminally broken because it uses
> local_irq_{save,restore}(), which are traced which uses RCU.
> 
> However, now that all the callers are sure to have IRQs disabled, we
> can remove these calls.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/rcu/tree.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -659,7 +659,7 @@ static noinstr void rcu_eqs_enter(bool u
>   * If you add or remove a call to rcu_idle_enter(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_idle_enter(void)
> +void noinstr rcu_idle_enter(void)
>  {
>  	lockdep_assert_irqs_disabled();
>  	rcu_eqs_enter(false);
> @@ -896,13 +896,10 @@ static void noinstr rcu_eqs_exit(bool us
>   * If you add or remove a call to rcu_idle_exit(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_idle_exit(void)
> +void noinstr rcu_idle_exit(void)
>  {
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> +	lockdep_assert_irqs_disabled();
>  	rcu_eqs_exit(false);
> -	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(rcu_idle_exit);
>  
> 
> 
