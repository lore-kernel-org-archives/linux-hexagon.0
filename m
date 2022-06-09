From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 33/36] cpuidle,omap3: Use WFI for omap3_pm_idle()
Date: Thu, 9 Jun 2022 10:39:22 +0300
Message-ID: <YqGjqgSrTRseJW6M@atomide.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.010587032@infradead.org>
 <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Geert

* Arnd Bergmann <arnd@arndb.de> [220608 18:18]:
> On Wed, Jun 8, 2022 at 4:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > arch_cpu_idle() is a very simple idle interface and exposes only a
> > single idle state and is expected to not require RCU and not do any
> > tracing/instrumentation.
> >
> > As such, omap_sram_idle() is not a valid implementation. Replace it
> > with the simple (shallow) omap3_do_wfi() call. Leaving the more
> > complicated idle states for the cpuidle driver.

Agreed it makes sense to limit deeper idle states to cpuidle. Hopefully
there is some informative splat for attempting to use arch_cpu_ide()
for deeper idle states :)

> I see similar code in omap2:
> 
> omap2_pm_idle()
>  -> omap2_enter_full_retention()
>      -> omap2_sram_suspend()
> 
> Is that code path safe to use without RCU or does it need a similar change?

Seems like a similar change should be done for omap2. Then anybody who
cares to implement a minimal cpuidle support can do so.

Regards,

Tony
