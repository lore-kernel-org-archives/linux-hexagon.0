From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Date: Thu, 9 Jun 2022 15:06:00 +0200
Message-ID: <YqHwOFg/WlMqe8/Z@alley>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley>
 <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654779989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQ7/fX+AXX7RSe4KqEkRum0uc4vC19BTUP6nq2wTOec=;
        b=o28ZaXYpRsbDNeH7DdY3dJH3Fnc3dlxZT8L+x/2aFmo5tE4BAEDzQGW4+i3DDhNGrDHekt
        G23+f/oOyTepRO03yIh1gixSASehX2C07pg1fm0i3R3KDgn22PhYw8V9jvCq8nE2YIN+/O
        p3FQSqV1HR0kVCZZzDry3RvUltYRjYI=
Content-Disposition: inline
In-Reply-To: <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 

On Thu 2022-06-09 12:02:04, Peter Zijlstra wrote:
> On Thu, Jun 09, 2022 at 11:16:46AM +0200, Petr Mladek wrote:
> > On Wed 2022-06-08 16:27:47, Peter Zijlstra wrote:
> > > The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
> > > tracepoint"), was printk usage from the cpuidle path where RCU was
> > > already disabled.
> > > 
> > Does this "prevent" calling printk() a safe way in code with
> > RCU disabled?
> 
> On x86_64, yes. Other architectures, less so.
> 
> Specifically, the objtool noinstr validation pass will warn at build
> time (DEBUG_ENTRY=y) if any noinstr/cpuidle code does a call to
> non-vetted code like printk().
> 
> At the same time; there's a few hacks that allow WARN to work, but
> mostly if you hit WARN in entry/noinstr you get to keep the pieces in
> any case.
> 
> On other architecture we'll need to rely on runtime coverage with
> PROVE_RCU. That is, if a splat like in the above mentioned commit
> happens again, we'll need to fix it by adjusting the callchain, not by
> mucking about with RCU state.

Makes sense. Feel free to use for this patch:

Acked-by: Petr Mladek <pmladek@suse.com>

> > Therefore if this patch allows to remove some tricky tracing
> > code then it might be worth it. But if trace_console_rcuidle()
> > variant is still going to be available then I would keep using it.
> 
> My ultimate goal is to delete trace_.*_rcuidle() and RCU_NONIDLE()
> entirely. We're close, but not quite there yet.

I keep my fingers crossed.

Best Regards,
Petr
