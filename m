From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/36] cpuidle/poll: Ensure IRQ state is invariant
Date: Wed, 6 Jul 2022 15:51:09 +0200
Message-ID: <CAJZ5v0jO9+jRSm3d58K15JaO3=kgM2Ueo7W+Smi3WCBPR_VM5Q@mail.gmail.com>
References: <20220608142723.103523089@infradead.org> <20220608144516.109792837@infradead.org>
Mime-Version: 1.0
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20220608144516.109792837-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org, ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org, mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vgupta-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guo Ren <guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcain-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, Huacai Chen <chenhuacai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-f95k8chpbVdBDLzU/O5InQ@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Thomas Bogendoerfer <tsbogend-I1c7kopa9pz3fQ9qLvQP4Q@public.gmane.org>

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
> cpuidle_state::enter() methods should be IRQ invariant
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/cpuidle/poll_state.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -17,7 +17,7 @@ static int __cpuidle poll_idle(struct cp
>
>         dev->poll_time_limit = false;
>
> -       local_irq_enable();
> +       raw_local_irq_enable();
>         if (!current_set_polling_and_test()) {
>                 unsigned int loop_count = 0;
>                 u64 limit;
> @@ -36,6 +36,8 @@ static int __cpuidle poll_idle(struct cp
>                         }
>                 }
>         }
> +       raw_local_irq_disable();
> +
>         current_clr_polling();
>
>         return index;
>
>
