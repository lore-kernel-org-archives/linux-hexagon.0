From: Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Sat, 30 Jul 2022 16:45:29 -0700
Message-ID: <20220730234529.GC1587@lespinasse.org>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
 <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org>
 <CAJZ5v0gyPtX=ksCibo2ZN_BztCqUn9KRtRu+gsJ5KetB_1MwEQ@mail.gmail.com>
 <20220730094800.GB1587@lespinasse.org>
 <CAJZ5v0hXVjsWab=qYZfXBTqcjkpWV0CFT9_oQBKQ28rFG3_VLw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-79-ed;
 t=1659224730; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=nAVqtDkPyoGTnjQOsobKhENqaeU5rNiWFfP8mKVev5k=;
 b=HFFhCK7R4iKO9dp7xadnNvlJ3TFgnIFCD+mWF8YiQOWKhEk/dwPTWNRYWGC9XfN1WRDf2
 g306xaRkvMw+dqoAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-79-rsa; t=1659224730; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=nAVqtDkPyoGTnjQOsobKhENqaeU5rNiWFfP8mKVev5k=;
 b=xEm4vrS+nhrfg16KlTSOz6xKHVgl2anxivbQOaQ8iyITrSIXx3k7S+7DNm3/9PE3/hP5/
 weBfs5WCmns8PrJOUh5+LyucC170rSw2K/NgNrAjDpputAJGflo+dG36LsXYxD+GZSSZKbP
 Pj/N5DYITgz/J3aBedmEOjvEEcNa6ityOyI32KA+gNj6htWosOb+QOsIsRx/2q9SXnXOMQE
 CoO7nRU+J2kcBx1HiMTnfjr/eN+QixQZGT0tRp8own4vN9hl237pUBRGLyuycFtncUUh4v4
 MsO6ge1ke2qwlIabxdvLZxjhahuiQC5BaBfCoCYkudJkUo4tS5HM55MrUsVw==
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXVjsWab=qYZfXBTqcjkpWV0CFT9_oQBKQ28rFG3_VLw@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michel Lespinasse <michel@lespinasse.org>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, vgupta@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, ulli.kroll@googlemail.com, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, bcain@quicinc.com, Huaca

On Sat, Jul 30, 2022 at 09:52:34PM +0200, Rafael J. Wysocki wrote:
> On Sat, Jul 30, 2022 at 11:48 AM Michel Lespinasse
> <michel@lespinasse.org> wrote:
> > I'm not sure if that was the patch you meant to send though, as it
> > seems it's only adding a tracepoint so shouldn't make any difference
> > if I'm not actually using the tracepoint ?
> 
> You are right, it looks like I pasted a link to a different patch by
> mistake.  Sorry about that.
> 
> I meant this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm&id=d295ad34f236c3518634fb6403d4c0160456e470
> 
> which will appear in the final 5.19.

Thanks. I can confirm that this patch fixes the boot time debug
warnings for me. And I see that linus already merged it, nice!
