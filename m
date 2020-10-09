From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Date: Fri, 9 Oct 2020 13:42:16 +0200
Message-ID: <20201009114216.GM2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009091218.GF4967@dhcp22.suse.cz>
 <20201009094245.GG2628@hirez.programming.kicks-ass.net>
 <20201009101044.GH4967@dhcp22.suse.cz>
 <20201009101431.GJ2628@hirez.programming.kicks-ass.net>
 <20201009103730.GJ4967@dhcp22.suse.cz>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RcamcxMM04cAFejMyuerox9iFyryVbfUvRjDUF6K+9E=; b=rV/73fj+p5/T3eYZYDymfCt5SP
        EGKltICU3UJgzJot3PlAdj3AbR+gk5Fu9ALysyRXUjXz1Zz9lkn1oy67SKaaUgwwoVb88K0SV7Bsh
        FqvpyAsddMNfO/uaOg5us46reQYdxoaw4V+Z56lK4XPhIyX56i/ukTdBdBh7EvlM1NHScvtTABqpo
        znLocfz8vCn//mXjXUAto9jooaYcx8KnZYLrEJUFEaEecZwQ67rFlXOnv+PAUplGmjypRkBw6zEJZ
        e0yFWzBMPGuSmWRNegKe32QuMxAhYnEeqk1p16v+xTaCE9aMZ0ypzDv+kqeYOcTeyxLPICzHhq0Jp
        54eNIb9Q==;
Content-Disposition: inline
In-Reply-To: <20201009103730.GJ4967@dhcp22.suse.cz>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbecker@suse.de>, LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

On Fri, Oct 09, 2020 at 12:37:30PM +0200, Michal Hocko wrote:
> On Fri 09-10-20 12:14:31, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 12:10:44PM +0200, Michal Hocko wrote:
> > > On Fri 09-10-20 11:42:45, Peter Zijlstra wrote:
> > > > On Fri, Oct 09, 2020 at 11:12:18AM +0200, Michal Hocko wrote:
> > > > > Is there any additional feedback? Should I split up the patch and repost
> > > > > for inclusion?
> > > > 
> > > > Maybe remove PREEMPT_NONE after that?  Since that's then equivalent to
> > > > building with VOLUNTARY and booting with preempt=none.
> > > 
> > > So do you mean that I should post an additional patch which does this on
> > > top? With a justification that there is one option less to chose from?
> > 
> > Exactly!
> 
> It seems we have to get rid of CONFIG_NO_PREEMPT first
> $ git grep ARCH_NO_PREEMPT
> arch/Kconfig:config ARCH_NO_PREEMPT
> arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> arch/um/Kconfig:        select ARCH_NO_PREEMPT
> kernel/Kconfig.preempt: depends on !ARCH_NO_PREEMPT
> kernel/Kconfig.preempt: depends on !ARCH_NO_PREEMPT
> lib/Kconfig.debug:      select PREEMPT_COUNT if !ARCH_NO_PREEMPT
> lib/Kconfig.debug:      depends on !ARCH_NO_PREEMPT
> 
> Is there anybody working on that. Is this even possible? I can see it
> has been added by 87a4c375995e ("kconfig: include kernel/Kconfig.preempt
> from init/Kconfig") but this looks more like a mechanical change and it
> has defined ARCH_NO_PREEMPT all arches which haven't included
> Kconfig.preempt. But is there any reason why those cannot support
> preemption for some reason? Cc respective maintainer (the email thread
> starts http://lkml.kernel.org/r/20201007120401.11200-1-mhocko@kernel.org

I suspect we can drop ARCH_NO_PREEMPT from VOLUNTARY, IIRC there's no
arch dependency there. PREEMPT itself obviously needs arch help.
