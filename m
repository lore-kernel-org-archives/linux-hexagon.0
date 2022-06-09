From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 33/36] cpuidle,omap3: Use WFI for omap3_pm_idle()
Date: Thu, 9 Jun 2022 11:47:57 +0200
Message-ID: <YqHBzbAiqaZeoipw@worktop.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.010587032@infradead.org>
 <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
 <YqGjqgSrTRseJW6M@atomide.com>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9jA4mchnYQoJ5XaXo73/qgoc6iaW5C3P1k7XaYKsS1U=; b=cB9XFjQVxWqfDyzeN0qaxTZuLD
        YLcvVXkDGRGNOtMLtEgH+zL1QwGa+jRQrKiDu6o+KwcqUIios781clMIKdQSQtEcXojjpXyjmvj46
        euyjd4m+n/z+pXAWpiww5AHKVJISuO8dbwfn2kdK+vnbm4iQMh9u58KvobfYp6DKnGfTofnM78Yt0
        Jz76LJDB6p5dvl91aPCez/Dj+sFAkswEne+HjI0PWGc0G7Uh6QasF9s0y9AlvQ8RjyVaUQ4ilXQ62
        Z4qivKfe5pGVxrpCjV/g6X6ndctS6ICj5/6oYIabFd8D02kUsNuFDdK3DNDO+pifvTslSQOhwvIep
        NfI5oq7A==;
Content-Disposition: inline
In-Reply-To: <YqGjqgSrTRseJW6M@atomide.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m6>

On Thu, Jun 09, 2022 at 10:39:22AM +0300, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [220608 18:18]:
> > On Wed, Jun 8, 2022 at 4:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > arch_cpu_idle() is a very simple idle interface and exposes only a
> > > single idle state and is expected to not require RCU and not do any
> > > tracing/instrumentation.
> > >
> > > As such, omap_sram_idle() is not a valid implementation. Replace it
> > > with the simple (shallow) omap3_do_wfi() call. Leaving the more
> > > complicated idle states for the cpuidle driver.
> 
> Agreed it makes sense to limit deeper idle states to cpuidle. Hopefully
> there is some informative splat for attempting to use arch_cpu_ide()
> for deeper idle states :)

The arch_cpu_idle() interface doesn't allow one to express a desire for
deeper states. I'm not sure how anyone could even attempt this.

But given what OMAP needs to go deeper, this would involve things that
require RCU, combine that with the follow up patches that rip out all
the trace_.*_rcuidle() hackery from the power and clock domain code,
PROVE_RCU should scream if anybody were to attempt it.
