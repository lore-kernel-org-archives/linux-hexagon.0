From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 17/36] acpi_idle: Remove tracing
Date: Wed, 6 Jul 2022 15:59:21 +0200
Message-ID: <CAJZ5v0jSfvUoReFHjA5A+brExnnEKidak-GnjTbY0CKoaWpGVQ@mail.gmail.com>
References: <20220608142723.103523089@infradead.org> <20220608144516.998681585@infradead.org>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20220608144516.998681585@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, ulli.kroll@googlemail.com, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, kernel@xen0n.name, Geert Uytterhoeven <geert@linux-m68k.org>, sammy@sammy.net, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.fra>

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> All the idle routines are called with RCU disabled, as such there must
> not be any tracing inside.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This actually does some additional code duplication cleanup which
would be good to mention in the changelog.  Or even move to a separate
patch for that matter.

Otherwise LGTM.

> ---
>  drivers/acpi/processor_idle.c |   24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -108,8 +108,8 @@ static const struct dmi_system_id proces
>  static void __cpuidle acpi_safe_halt(void)
>  {
>         if (!tif_need_resched()) {
> -               safe_halt();
> -               local_irq_disable();
> +               raw_safe_halt();
> +               raw_local_irq_disable();
>         }
>  }
>
> @@ -524,16 +524,21 @@ static int acpi_idle_bm_check(void)
>         return bm_status;
>  }
>
> -static void wait_for_freeze(void)
> +static __cpuidle void io_idle(unsigned long addr)
>  {
> +       /* IO port based C-state */
> +       inb(addr);
> +
>  #ifdef CONFIG_X86
>         /* No delay is needed if we are in guest */
>         if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>                 return;
>  #endif
> -       /* Dummy wait op - must do something useless after P_LVL2 read
> -          because chipsets cannot guarantee that STPCLK# signal
> -          gets asserted in time to freeze execution properly. */
> +       /*
> +        * Dummy wait op - must do something useless after P_LVL2 read
> +        * because chipsets cannot guarantee that STPCLK# signal
> +        * gets asserted in time to freeze execution properly.
> +        */
>         inl(acpi_gbl_FADT.xpm_timer_block.address);
>  }
>
> @@ -553,9 +558,7 @@ static void __cpuidle acpi_idle_do_entry
>         } else if (cx->entry_method == ACPI_CSTATE_HALT) {
>                 acpi_safe_halt();
>         } else {
> -               /* IO port based C-state */
> -               inb(cx->address);
> -               wait_for_freeze();
> +               io_idle(cx->address);
>         }
>
>         perf_lopwr_cb(false);
> @@ -577,8 +580,7 @@ static int acpi_idle_play_dead(struct cp
>                 if (cx->entry_method == ACPI_CSTATE_HALT)
>                         safe_halt();
>                 else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
> -                       inb(cx->address);
> -                       wait_for_freeze();
> +                       io_idle(cx->address);
>                 } else
>                         return -ENODEV;
>
>
>
