From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2 07/44] cpuidle,psci: Push RCU-idle into driver
Date: Thu, 22 Sep 2022 08:45:37 +0800
Message-ID: <CAJF2gTQxxRQZLV+uJThCZSByUQ0oSoASgwsUggbsR3wHTqrqzg@mail.gmail.com>
References: <20220919095939.761690562@infradead.org> <20220919101520.802976773@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663807562;
        bh=2bH5aOcexI7rmLPjoykcAnkew/OWwytHkYzPwWB/jQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qaUYBCa8ZYQI7GFr3vNdl7b4/PNzeOP9Pl2wTB/4OC6mUC/FIDhddHDVnhJyCLZDw
         YQge6B5Td0P7VO9PjXCnxo31fcUlfOUeOzuNgueaOnxtVyoeE+Kw885ZbDXxjh+Kxz
         nG8xhYs4MfH8znO0LxccUTvFyIcklL8qxJgHgHzEwD28BpML95SM926I5BVMpBRfGy
         EClfn8JhrAFiO2xWjdeYnkuQSHDKC+N7GbQ87Gnwaucrl4yjzE6eDQWXlwcBRoA5Iv
         jLegSRu7TSsZLQytF1F6DuVm9kAdHW2MlxTQNgWpbKQ1zMRvmGVdyaWmNwNcIB2j62
         KBXRDapx3EsAg==
In-Reply-To: <20220919101520.802976773@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.ber

Reviewed-by: Guo Ren <guoren@kernel.org>

On Mon, Sep 19, 2022 at 6:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -69,12 +69,12 @@ static int __psci_enter_domain_idle_stat
>                 return -1;
>
>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
> -       ct_irq_enter_irqson();
>         if (s2idle)
>                 dev_pm_genpd_suspend(pd_dev);
>         else
>                 pm_runtime_put_sync_suspend(pd_dev);
> -       ct_irq_exit_irqson();
> +
> +       ct_idle_enter();
>
>         state = psci_get_domain_state();
>         if (!state)
> @@ -82,12 +82,12 @@ static int __psci_enter_domain_idle_stat
>
>         ret = psci_cpu_suspend_enter(state) ? -1 : idx;
>
> -       ct_irq_enter_irqson();
> +       ct_idle_exit();
> +
>         if (s2idle)
>                 dev_pm_genpd_resume(pd_dev);
>         else
>                 pm_runtime_get_sync(pd_dev);
> -       ct_irq_exit_irqson();
>
>         cpu_pm_exit();
>
> @@ -240,6 +240,7 @@ static int psci_dt_cpu_init_topology(str
>          * of a shared state for the domain, assumes the domain states are all
>          * deeper states.
>          */
> +       drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
>         drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
>         drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
>         psci_cpuidle_use_cpuhp = true;
>
>


-- 
Best Regards
 Guo Ren
