From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 31/36] cpuidle,acpi: Make noinstr clean
Date: Wed, 6 Jul 2022 16:04:42 +0200
Message-ID: <CAJZ5v0j6=x-u3dorwQNd6Sihaa1rx1-uaFXbL1Kc37Hu-fcH3A@mail.gmail.com>
References: <20220608142723.103523089@infradead.org> <20220608144517.885263942@infradead.org>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20220608144517.885263942@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, ulli.kroll@googlemail.com, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, kernel@xen0n.name, Geert Uytterhoeven <geert@linux-m68k.org>, sammy@sammy.net, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.fra>

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> vmlinux.o: warning: objtool: io_idle+0xc: call to __inb.isra.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_enter+0xfe: call to num_online_cpus() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_enter+0x115: call to acpi_idle_fallback_to_c1.isra.0() leaves .noinstr.text section
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/include/asm/shared/io.h |    4 ++--
>  drivers/acpi/processor_idle.c    |    2 +-
>  include/linux/cpumask.h          |    4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/arch/x86/include/asm/shared/io.h
> +++ b/arch/x86/include/asm/shared/io.h
> @@ -5,13 +5,13 @@
>  #include <linux/types.h>
>
>  #define BUILDIO(bwl, bw, type)                                         \
> -static inline void __out##bwl(type value, u16 port)                    \
> +static __always_inline void __out##bwl(type value, u16 port)           \
>  {                                                                      \
>         asm volatile("out" #bwl " %" #bw "0, %w1"                       \
>                      : : "a"(value), "Nd"(port));                       \
>  }                                                                      \
>                                                                         \
> -static inline type __in##bwl(u16 port)                                 \
> +static __always_inline type __in##bwl(u16 port)                                \
>  {                                                                      \
>         type value;                                                     \
>         asm volatile("in" #bwl " %w1, %" #bw "0"                        \
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -593,7 +593,7 @@ static int acpi_idle_play_dead(struct cp
>         return 0;
>  }
>
> -static bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
> +static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
>  {
>         return IS_ENABLED(CONFIG_HOTPLUG_CPU) && !pr->flags.has_cst &&
>                 !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED);
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -908,9 +908,9 @@ static inline const struct cpumask *get_
>   * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
>   * region.
>   */
> -static inline unsigned int num_online_cpus(void)
> +static __always_inline unsigned int num_online_cpus(void)
>  {
> -       return atomic_read(&__num_online_cpus);
> +       return arch_atomic_read(&__num_online_cpus);
>  }
>  #define num_possible_cpus()    cpumask_weight(cpu_possible_mask)
>  #define num_present_cpus()     cpumask_weight(cpu_present_mask)
>
>
