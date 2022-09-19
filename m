From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 08/44] cpuidle,imx6: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 17:03:04 +0200
Message-ID: <YyiEqDSJVOZrQYg8@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.869531945@infradead.org>
 <20220919144941.GA62211@lothringen>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8W4ANpZZg81bkZotlJvZ4fg4qiAvSnY5PZyc1BTsWP4=; b=U5nJ9bmbrG96XYoLlWJMVIlBU2
        Pac30dBaWX60m+XV25ZBrYpXHzco5Q4NvTRE6aqkUuxUPn4JqSO1GodAj6psxS/Sp6GkOCStGlY4M
        8BPQdAM8NMp6pZmjrzXDYhoVN0Nr9gBqgJ5fq4StVhTIHRcrv28THIsVzKd1rTfCOQ3w8HGN1n0Uw
        lG/m8FHJAXyE1D7Z149RX3YBrqwoqT0JLs3qsqzAdv6yyW8A86Z0atiWKYeezmVR2nk0iC8HoYA62
        F2nkXj4OJNNIj6lZA++w5ieVdxb6fkUT9Y7e4iDEgPe3TS4PMshOdvmBCNLaFz4JSqJjIGbHECwb8
        O+RP33Rg==;
Content-Disposition: inline
In-Reply-To: <20220919144941.GA62211@lothringen>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frederic Weisbecker <frederic@kernel.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 04:49:41PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 11:59:47AM +0200, Peter Zijlstra wrote:
> > Doing RCU-idle outside the driver, only to then temporarily enable it
> > again, at least twice, before going idle is daft.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/arm/mach-imx/cpuidle-imx6sx.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > @@ -47,7 +47,9 @@ static int imx6sx_enter_wait(struct cpui
> >  		cpu_pm_enter();
> >  		cpu_cluster_pm_enter();
> >  
> > +		ct_idle_enter();
> >  		cpu_suspend(0, imx6sx_idle_finish);
> > +		ct_idle_exit();
> >  
> >  		cpu_cluster_pm_exit();
> >  		cpu_pm_exit();
> > @@ -87,7 +89,8 @@ static struct cpuidle_driver imx6sx_cpui
> >  			 */
> >  			.exit_latency = 300,
> >  			.target_residency = 500,
> > -			.flags = CPUIDLE_FLAG_TIMER_STOP,
> > +			.flags = CPUIDLE_FLAG_TIMER_STOP |
> > +				 CPUIDLE_FLAG_RCU_IDLE,
> >  			.enter = imx6sx_enter_wait,
> 
> There is a second one below that also uses imx6sx_enter_wait.

Oh, above you mean; but only @index==2 gets us into the whole PM crud.
@index==1 is fine afaict.
