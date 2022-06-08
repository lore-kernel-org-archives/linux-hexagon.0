From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 34/36] cpuidle,omap3: Push RCU-idle into omap_sram_idle()
Date: Wed, 8 Jun 2022 17:04:40 +0200
Message-ID: <YqC6iJx4ygSmry0G__49418.7670455844$1654701255$gmane$org@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.073801916@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ukp02Ivtbnt/qfD+Hr8nM4W5X9OZTZ1VV5qELeaRbZ8=; b=FdbZDiHXxrw9R5zBFDpdZ4bCmw
        5EqLEtrQA4GAVtuQ4l7BXUjKrV0kbnuMXyTU0mKTl97PPyywe9dKH6V1TaR7+s04jt3vgRI5mst7b
        MvEdRR4E7DMNS+4fdoyozYSMS3CHHYGRsbjSFC/FX969Mb3h5fENFOU77m6PPad0SmQklQKh0IO7h
        IYy8ICeQDWkRRib9aqgM2U3yBaV/wh14vGpv4jtvEIXl8fZxQ7fVbucEOetEIOGb+PV/8PBB6Vpkx
        USv7ghtiy/ArNAWwKGQZiEeZRhk2g1lrtCnBLBi4x8H1pqA+N9vGsS/o8HP+yXb0C4r8mRSmFSQx5
        Ih95USug==;
Content-Disposition: inline
In-Reply-To: <20220608144518.073801916@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

On Wed, Jun 08, 2022 at 04:27:57PM +0200, Peter Zijlstra wrote:
> @@ -254,11 +255,18 @@ void omap_sram_idle(void)
>  	 */
>  	if (save_state)
>  		omap34xx_save_context(omap3_arm_context);
> +
> +	if (rcuidle)
> +		cpuidle_rcu_enter();
> +
>  	if (save_state == 1 || save_state == 3)
>  		cpu_suspend(save_state, omap34xx_do_sram_idle);
>  	else
>  		omap34xx_do_sram_idle(save_state);
>  
> +	if (rcuidle)
> +		rcuidle_rcu_exit();

*sigh* so much for this having been exposed to the robots for >2 days :/
