From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Date: Thu, 9 Jun 2022 12:02:04 +0200
Message-ID: <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UbbDgBiwip0YBZOTZVQugfugvsZnYOECFEm/sChB2KE=; b=pk5LmI1A6aszGw6bJBfBOEp2aD
        U1h+ZFFSSnK8VqAlyB4JuyYAdX13KUgLZiqkzxfwMXZ9rLcXV72vPGCzoT5Nh/jWgfuAo9rvsnY2d
        uR5AV7hvfyPjralHm1TpJmT+OCcad3LiNA+fq5wN7wYCWN4JhRiwUwGBAslMEHFWQWn5ULi2Lub4P
        i+EEJRnbfwtH5eutwugIAwcmhtxvbG1a5W2y8SzA+C4Ts7dxbLHpQKmAmovezzT8tR42G7Z3XpfnO
        yc0zC9lSe7OtjlT7qvzvuP3LXJVZDKeRWF3xOE4FMAliLG0o07t6jIPvQ35THQypS5lZSRykYm4f6
        U90A/TjQ==;
Content-Disposition: inline
In-Reply-To: <YqG6URbihTNCk9YR@alley>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 

On Thu, Jun 09, 2022 at 11:16:46AM +0200, Petr Mladek wrote:
> On Wed 2022-06-08 16:27:47, Peter Zijlstra wrote:
> > The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
> > tracepoint"), was printk usage from the cpuidle path where RCU was
> > already disabled.
> > 
> > Per the patches earlier in this series, this is no longer the case.
> 
> My understanding is that this series reduces a lot the amount
> of code called with RCU disabled. As a result the particular printk()
> call mentioned by commit fc98c3c8c9dc ("printk: use rcuidle console
> tracepoint") is called with RCU enabled now. Hence this particular
> problem is fixed better way now.
> 
> But is this true in general?
> Does this "prevent" calling printk() a safe way in code with
> RCU disabled?

On x86_64, yes. Other architectures, less so.

Specifically, the objtool noinstr validation pass will warn at build
time (DEBUG_ENTRY=y) if any noinstr/cpuidle code does a call to
non-vetted code like printk().

At the same time; there's a few hacks that allow WARN to work, but
mostly if you hit WARN in entry/noinstr you get to keep the pieces in
any case.

On other architecture we'll need to rely on runtime coverage with
PROVE_RCU. That is, if a splat like in the above mentioned commit
happens again, we'll need to fix it by adjusting the callchain, not by
mucking about with RCU state.

> I am not sure if anyone cares. printk() is the best effort
> functionality because of the consoles code anyway. Also I wonder
> if anyone uses this trace_console().

This is the tracepoint used to spool all of printk into ftrace, I
suspect there's users, but I haven't used it myself.

> Therefore if this patch allows to remove some tricky tracing
> code then it might be worth it. But if trace_console_rcuidle()
> variant is still going to be available then I would keep using it.

My ultimate goal is to delete trace_.*_rcuidle() and RCU_NONIDLE()
entirely. We're close, but not quite there yet.
