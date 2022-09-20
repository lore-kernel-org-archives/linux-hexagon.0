From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 00/44] cpuidle,rcu: Clean up the mess
Date: Tue, 20 Sep 2022 14:31:45 +0200
Message-ID: <20220920123145.GC72346@lothringen>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663677108;
        bh=i2971qM7wlevODiVHlQWVkeQKCoULSDtCivyYa6BY3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q359WuuE7X8iHPUglRgZ6umBriKE4r+Hq60s0D7bZenVvQZ4nI53Q/0IHEDWUvL08
         uO1lUj+/+gsUuHABZ0IUgFE9VpucvwIQJdQ0+o+qLceGFQWOjTx274Wv0QgoQwQqDB
         Bq6B/yj6zX6+ne9r87JfQG1DqPPHAUwk/5wBhBEUUm5zmwQcKDqLTClYTCw1gL+EWj
         y+co7RjqxrjwqgzVQOyvkrVOgNfaKYqf/Dnk/7RydhOFfw29XBhF+VqBugULRYy6nW
         kGdHmx4EM6/oydyvS6EAGcuvFJCcs2df/Ji6kGzIJMqPXxrjzmWTkMGZJXBpD98pEC
         ZvljhnwREUPvw==
Content-Disposition: inline
In-Reply-To: <20220919095939.761690562@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:39AM +0200, Peter Zijlstra wrote:
> Hi All!
> 
> At long last, a respin of the cpuidle vs rcu cleanup patches.
> 
> v1: https://lkml.kernel.org/r/20220608142723.103523089@infradead.org
> 
> These here patches clean up the mess that is cpuidle vs rcuidle.
> 
> At the end of the ride there's only on RCU_NONIDLE user left:
> 
>   arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());
> 
> and 'one' trace_*_rcuidle() user:
> 
>   kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>   kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>   kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
>   kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
>   kernel/trace/trace_preemptirq.c:                trace_preempt_enable_rcuidle(a0, a1);
>   kernel/trace/trace_preemptirq.c:                trace_preempt_disable_rcuidle(a0, a1);
> 
> However this last is all in deprecated code that should be unused for GENERIC_ENTRY.
> 
> I've touched a lot of code that I can't test and I might've broken something by
> accident. In particular the whole ARM cpuidle stuff was quite involved.
> 
> Please all; have a look where you haven't already.
> 
> 
> New since v1:
> 
>  - rebase on top of Frederic's rcu-context-tracking rename fest
>  - more omap goodness as per the last discusion (thanks Tony!)
>  - removed one more RCU_NONIDLE() from arm64/risc-v perf code
>  - ubsan/kasan fixes
>  - intel_idle module-param for testing
>  - a bunch of extra __always_inline, because compilers are silly.

Except for those I have already tagged as Reviewed:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks for the hard work!
