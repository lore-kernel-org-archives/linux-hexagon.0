From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 03/44] cpuidle/poll: Ensure IRQ state is invariant
Date: Tue, 20 Sep 2022 12:43:25 +0200
Message-ID: <20220920104325.GA72346@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.534233547@infradead.org>
 <20220919131927.GA58444@lothringen>
 <YymAXPkZkyFIEjXM@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663670608;
        bh=6GsQ3yhKLr/MxdSlXebBHOnZZwkqV+Km5n+FdtLELFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5dAVjAuYVAf/ldcpMwVOIccr93eh+i/PPqe86bcTTpe9rquyYiwNXWsEYN6MEgtC
         4dkSGP8Y6MjqZepb+9gQ6s3zfFi8AQZlWHaT9YE94OBgT652ETiHQ4+oyg1H9cMKe0
         W4ejHxERjCdEHRyFhCMtozUTXVDZIa2H0g10CJTUgcjhZqBq48hlTCa71o1rmNMJUn
         UuRNJ769Ea2tTmdOKpPB1SWcTi7Afm+dzY4ofsUzOPWyR3eaWqkGsJ5+yZC/8xtTFB
         fdtVAvZE4UfiE+hEXckkBlXeuH+b1N2KqaqSOzsoRx2yLdTrKi9779585hh4U8ohjY
         b1TN7NMPsPyxQ==
Content-Disposition: inline
In-Reply-To: <YymAXPkZkyFIEjXM@hirez.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Tue, Sep 20, 2022 at 10:57:00AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 19, 2022 at 03:19:27PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 19, 2022 at 11:59:42AM +0200, Peter Zijlstra wrote:
> > > cpuidle_state::enter() methods should be IRQ invariant
> > 
> > Got a bit confused with the invariant thing since the first chunck I
> > see in this patch is a conversion to an non-traceable local_irq_enable().
> > 
> > Maybe just add a short mention about that and why?
> 
> Changelog now reads:
> 
> ---
> Subject: cpuidle/poll: Ensure IRQ state is invariant
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue May 31 15:43:32 CEST 2022
> 
> cpuidle_state::enter() methods should be IRQ invariant.
> 
> Additionally make sure to use raw_local_irq_*() methods since this
> cpuidle callback will be called with RCU already disabled.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

