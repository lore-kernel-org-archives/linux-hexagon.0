From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 33/36] cpuidle,omap3: Use WFI for omap3_pm_idle()
Date: Thu, 9 Jun 2022 11:40:46 +0200
Message-ID: <YqHAHpGVe10I8O1z@worktop.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.010587032@infradead.org>
 <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-arm-msm-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jxhFyRA7gcpqWtRQyvyD3abswc2PbVc4FSoswUV5Ukc=; b=eTVis02Li1gUMyvYNvhtQOfPjM
        7jPK+tlnMQu8YlONdKYuGGzg5f4OtA6n+DLuvaVtWLmmwBKEcjK3gJJFZyuUsx9s+WrgcdXDtEGo5
        n/0BitYa/9Tv9a5PHDy4FBaJ0usEOIIGYMMcR/SAKx38GPSteGLT2qjJKdgzgVt9Wb+/EeSMk/GCj
        o7MIldwwpKDLAKlNGDE/FUzTM2RKPEJfDUWHFxb549VYWV718uWBpBWrwfwVc4Y51nI2XmOQdPNke
        dbtUv13RdN1xprVJqbJ/lLZKhjUqu4j3NGqJXLsSZjtm/Jap7nXVhvEByTNVwWiNq35HcNs4n5id9
        tqC7XoNQ==;
Content-Disposition: inline
In-Reply-To: <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Geert Uytterhoeven <gee>

On Wed, Jun 08, 2022 at 06:28:33PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 8, 2022 at 4:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > arch_cpu_idle() is a very simple idle interface and exposes only a
> > single idle state and is expected to not require RCU and not do any
> > tracing/instrumentation.
> >
> > As such, omap_sram_idle() is not a valid implementation. Replace it
> > with the simple (shallow) omap3_do_wfi() call. Leaving the more
> > complicated idle states for the cpuidle driver.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I see similar code in omap2:
> 
> omap2_pm_idle()
>  -> omap2_enter_full_retention()
>      -> omap2_sram_suspend()
> 
> Is that code path safe to use without RCU or does it need a similar change?

It needs a similar change, clearly I was running on fumes to not have
found that when grepping around the omap code :/
