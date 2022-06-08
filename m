From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Wed, 8 Jun 2022 17:01:05 +0200
Message-ID: <CAJZ5v0gW-zD8Mgghy70f3rFz0QoozCwZ9idyrqtFgA6SWHK5XQ@mail.gmail.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20220608144516.172460444@infradead.org>
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
Cc: Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Huacai Chen <chenhuacai@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Gross <agross@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, dl-linux-imx <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, xen-devel@lists.xenproject.org, mattst88@gmail.com, Michael Turquette <mturquette@baylibre.com>, sammy@sammy.net, Petr Mladek <pmladek@suse.com>, Linux PM <linux-pm@vger.kernel.org>, Lai Jiangshan <jiangs>

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> Xeons") wrecked intel_idle in two ways:
>
>  - must not have tracing in idle functions
>  - must return with IRQs disabled
>
> Additionally, it added a branch for no good reason.
>
> Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And do I think correctly that this can be applied without the rest of
the series?

> ---
>  drivers/idle/intel_idle.c |   48 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -129,21 +137,37 @@ static unsigned int mwait_substates __in
>   *
>   * Must be called under local_irq_disable().
>   */
> +
> -static __cpuidle int intel_idle(struct cpuidle_device *dev,
> -                               struct cpuidle_driver *drv, int index)
> +static __always_inline int __intel_idle(struct cpuidle_device *dev,
> +                                       struct cpuidle_driver *drv, int index)
>  {
>         struct cpuidle_state *state = &drv->states[index];
>         unsigned long eax = flg2MWAIT(state->flags);
>         unsigned long ecx = 1; /* break on interrupt flag */
>
> -       if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
> -               local_irq_enable();
> -
>         mwait_idle_with_hints(eax, ecx);
>
>         return index;
>  }
>
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int index)
> +{
> +       return __intel_idle(dev, drv, index);
> +}
> +
> +static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
> +                                   struct cpuidle_driver *drv, int index)
> +{
> +       int ret;
> +
> +       raw_local_irq_enable();
> +       ret = __intel_idle(dev, drv, index);
> +       raw_local_irq_disable();
> +
> +       return ret;
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> @@ -1801,6 +1824,9 @@ static void __init intel_idle_init_cstat
>                 /* Structure copy. */
>                 drv->states[drv->state_count] = cpuidle_state_table[cstate];
>
> +               if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
> +                       drv->states[drv->state_count].enter = intel_idle_irq;
> +
>                 if ((disabled_states_mask & BIT(drv->state_count)) ||
>                     ((icpu->use_acpi || force_use_acpi) &&
>                      intel_idle_off_by_default(mwait_hint) &&
>
>
