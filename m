From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 08/44] cpuidle,imx6: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 16:49:41 +0200
Message-ID: <20220919144941.GA62211@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.869531945@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663598985;
        bh=L+UDv5mvX4qY9Lj3t+UbJ+Tw18xN3dy1wuBzIzgEsiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gguXnCN7R4mesgt80Rz1q6+nMltiCh9YFLbLacD9XX8i9153zAMu/C9J6wrlypmHV
         C4O9/qad5/YnQHvxjMyAN1Xipx5RZeehydBte2IQ7IAgdOnvuph5RzwpWx9gT397CC
         3XfNp+JBSCdgKQhvk4OORlssabEFBx1hzL8bQQnUxL7VKxJlF+BxEn4pc6GlZy8Ifh
         1FPiwurZd8pb6cerOXJc5zrW3lkNSSADMghj6TUHyvQmunBRfq7eu+Okq1vapEVrsS
         fiALbj72WkMAGlX2gGJsjQ17QfFOCStzMhTFJhfkANMdrWO19f7Yl0T7ppwQ8kBeZH
         yiSmIlHS8YsmA==
Content-Disposition: inline
In-Reply-To: <20220919101520.869531945@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:47AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm/mach-imx/cpuidle-imx6sx.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -47,7 +47,9 @@ static int imx6sx_enter_wait(struct cpui
>  		cpu_pm_enter();
>  		cpu_cluster_pm_enter();
>  
> +		ct_idle_enter();
>  		cpu_suspend(0, imx6sx_idle_finish);
> +		ct_idle_exit();
>  
>  		cpu_cluster_pm_exit();
>  		cpu_pm_exit();
> @@ -87,7 +89,8 @@ static struct cpuidle_driver imx6sx_cpui
>  			 */
>  			.exit_latency = 300,
>  			.target_residency = 500,
> -			.flags = CPUIDLE_FLAG_TIMER_STOP,
> +			.flags = CPUIDLE_FLAG_TIMER_STOP |
> +				 CPUIDLE_FLAG_RCU_IDLE,
>  			.enter = imx6sx_enter_wait,

There is a second one below that also uses imx6sx_enter_wait.

Thanks.

>  			.name = "LOW-POWER-IDLE",
>  			.desc = "ARM power off",
> 
> 
