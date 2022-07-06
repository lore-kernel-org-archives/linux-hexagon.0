From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 05/36] cpuidle: Move IRQ state validation
Date: Wed, 6 Jul 2022 15:54:32 +0200
Message-ID: <CAJZ5v0g0fCNxsc1mg9aL+ieQ1uMVS+RWqesHKoZ_zeL7cx655A@mail.gmail.com>
References: <20220608142723.103523089@infradead.org> <20220608144516.235041924@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20220608144516.235041924@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, ulli.kroll@googlemail.com, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, kernel@xen0n.name, Geert Uytterhoeven <geert@linux-m68k.org>, sammy@sammy.net, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.fra>

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Make cpuidle_enter_state() consistent with the s2idle variant and
> verify ->enter() always returns with interrupts disabled.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/cpuidle/cpuidle.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -234,7 +234,11 @@ int cpuidle_enter_state(struct cpuidle_d
>         stop_critical_timings();
>         if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>                 rcu_idle_enter();
> +
>         entered_state = target_state->enter(dev, drv, index);
> +       if (WARN_ONCE(!irqs_disabled(), "%ps leaked IRQ state", target_state->enter))

I'm not sure if dumping a call trace here is really useful and
WARN_ON() often gets converted to panic().

I would print an error message with pr_warn_once().

Otherwise LGTM.

> +               raw_local_irq_disable();
> +
>         if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>                 rcu_idle_exit();
>         start_critical_timings();
> @@ -246,12 +250,8 @@ int cpuidle_enter_state(struct cpuidle_d
>         /* The cpu is no longer idle or about to enter idle. */
>         sched_idle_set_state(NULL);
>
> -       if (broadcast) {
> -               if (WARN_ON_ONCE(!irqs_disabled()))
> -                       local_irq_disable();
> -
> +       if (broadcast)
>                 tick_broadcast_exit();
> -       }
>
>         if (!cpuidle_state_is_coupled(drv, index))
>                 local_irq_enable();
>
>
