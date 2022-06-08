From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Wed, 8 Jun 2022 17:48:16 +0200
Message-ID: <YqDEwMDSL1YXdHFH@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <CAJZ5v0gW-zD8Mgghy70f3rFz0QoozCwZ9idyrqtFgA6SWHK5XQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wkrvwwo/ehTnPQ2GyODy/ZpUUMe6HOjJCITHLe45W7c=; b=PhHp+PJmr+2T6rnBijz+YHTCqo
        Q3sRs0kB+1HF2TzaTXkAa8+nJlCba8qwWkYHuYUvJIz6d+sUwN3QATDRrp6HkFJtxuDUGlK2esQFG
        B6FqhNDw4mzKWIndiKngqO5+uVumTrnZhLB4eRFSER0mlLEnLKmACyt/N0zRX6B8QnMdEd1jF93Qv
        +F3wXq8WpQgBGoI9TYubNiobTj3byuz+cOLmJDoCRAcPPkDwjHQiqUYBc/eVlZdt6y9xI16C13ivT
        9RycLHrYGa8XbNQes8S9gNmrNcQe8ImgWY0Ct9y735wKSNGr9BXQRTA4U6CQXwwbi/h2tLQ2WHupK
        g4TPoOhQ==;
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gW-zD8Mgghy70f3rFz0QoozCwZ9idyrqtFgA6SWHK5XQ@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, ulli.kroll@googlemail.com, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, kernel@xen0n.name, Geert Uytterhoeven <geert@linux-m68k.org>, sammy@sammy.net, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.fra>

On Wed, Jun 08, 2022 at 05:01:05PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> > Xeons") wrecked intel_idle in two ways:
> >
> >  - must not have tracing in idle functions
> >  - must return with IRQs disabled
> >
> > Additionally, it added a branch for no good reason.
> >
> > Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> And do I think correctly that this can be applied without the rest of
> the series?

Yeah, I don't think this relies on any of the preceding patches. If you
want to route this through the pm/fixes tree that's fine.

Thanks!
