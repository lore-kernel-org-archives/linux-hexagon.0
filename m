From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 11:31:08 -0400
Message-ID: <20230919113108.1c988906@gandalf.local.home>
References: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
        <87cyyfxd4k.ffs@tglx>
        <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
        <87led2wdj0.ffs@tglx>
        <ZQmbhoQIINs8rLHp@casper.infradead.org>
        <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
        <20230919134218.GA39281@noisy.programming.kicks-ass.net>
        <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
        <20230919141627.GB39281@noisy.programming.kicks-ass.net>
        <a428516ebeae71e33635edc83052c972ce40c85d.camel@physik.fu-berlin.de>
        <ZQmw5dUzcFOWjHdB@casper.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <ZQmw5dUzcFOWjHdB@casper.infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Matthew Wilcox <willy@infradead.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cam>

On Tue, 19 Sep 2023 15:32:05 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Sep 19, 2023 at 04:24:48PM +0200, John Paul Adrian Glaubitz wrote:
> > If the conversion isn't hard, why is the first reflex the urge to remove an architecture
> > instead of offering advise how to get the conversion done?  
> 
> Because PREEMPT has been around since before 2005 (cc19ca86a023 created
> Kconfig.preempt and I don't need to go back further than that to make my
> point), and you haven't done the work yet.  Clearly it takes the threat
> of removal to get some kind of motion.

Or the use case of a preempt kernel on said arch has never been a request.
Just because it was available doesn't necessarily mean it's required.

Please, let's not jump to threats of removal just to get a feature in.
Simply ask first. I didn't see anyone reaching out to the maintainers
asking for this as it will be needed for a new feature that will likely
make maintaining said arch easier.

Everything is still in brainstorming mode.

-- Steve
