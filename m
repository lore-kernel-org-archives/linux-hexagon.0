From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 15:48:09 +0200
Message-ID: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
References: <87zg1u1h5t.fsf@oracle.com>
         <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
         <20230911150410.GC9098@noisy.programming.kicks-ass.net>
         <87h6o01w1a.fsf@oracle.com>
         <20230912082606.GB35261@noisy.programming.kicks-ass.net>
         <87cyyfxd4k.ffs@tglx>
         <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
         <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
         <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
         <20230919134218.GA39281@noisy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20230919134218.GA39281@noisy.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johan>

On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
> > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
> > that people are still working on! Can we please not do this?
> 
> If you're working on one of them, then surely it's a simple matter of
> working on adding CONFIG_PREEMPT support :-)

As Geert poined out, I'm not seeing anything particular problematic with the
architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
something about organizing KConfig files.

I find it a bit unfair that maintainers of architectures that have huge companies
behind them use their manpower to urge less popular architectures for removal just
because they don't have 150 people working on the port so they can keep up with
design changes quickly.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
