From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 10/44] cpuidle,armada: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 16:39:07 +0200
Message-ID: <20220919143907.GB61009@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101521.004425686@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663598350;
        bh=EYlJ8II0nMQUwIjH0JUADdeT52M2bVXh8wZ8I7YWDZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3+f9C0KTVjmYUPiubcRMi8XIY5SJMP0244Vb1fXbwXdFHK2Bm2BwTTQiaCHZh9e8
         gk+RkXTCbQvo+kjvjvWXHkL/k/NseZ0cbkyw2yDh2rZtKAxwlQOJfRciHvpbPx0lTm
         fDHS2etEOvPkeXqxMZO/oK5HOJhYIwkHmqYibhK+OB+2c+J+ST7lgkwPFAFcYkZbFW
         MXfD5dFjyN8rnPvB9qABtdA2rx/c5tMG/PNclmQth0MoJSBvpOxArLP6yCDHF7fpUw
         gdJXH8PHYrPCe2KnzR/yv4vNUQpksjg/NG4m1Xvw5PY6ek342QURnNGyGExrAr8OtZ
         QX22S+N/3elJw==
Content-Disposition: inline
In-Reply-To: <20220919101521.004425686@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:49AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again before going idle is daft.

Ah wait, now I see, that's cpu_pm_enter()/cpu_pm_exit() -> cpu_pm_notify*() the culprits.
Might be worth adding a short note about that on your changelogs.

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/cpuidle/cpuidle-mvebu-v7.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -36,7 +36,10 @@ static int mvebu_v7_enter_idle(struct cp
>  	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
>  		deepidle = true;
>  
> +	ct_idle_enter();
>  	ret = mvebu_v7_cpu_suspend(deepidle);
> +	ct_idle_exit();

And then yes of course:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
