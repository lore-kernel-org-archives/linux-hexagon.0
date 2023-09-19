From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 14:38:16 -0400
Message-ID: <20230919143816.1741760a@gandalf.local.home>
References: <87zg1u1h5t.fsf@oracle.com>
        <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
        <20230911150410.GC9098@noisy.programming.kicks-ass.net>
        <87h6o01w1a.fsf@oracle.com>
        <20230912082606.GB35261@noisy.programming.kicks-ass.net>
        <87cyyfxd4k.ffs@tglx>
        <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
        <87led2wdj0.ffs@tglx>
        <ZQmbhoQIINs8rLHp@casper.infradead.org>
        <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
        <20230919134218.GA39281@noisy.programming.kicks-ass.net>
        <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
        <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
        <87pm2eui95.ffs@tglx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <87pm2eui95.ffs@tglx>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cam>

On Tue, 19 Sep 2023 20:31:50 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> The removal of cond_resched() might cause latencies, but then I doubt
> that these museus pieces are used for real work :)

We could simply leave the cond_resched() around but defined as nops for
everything but the "nostalgia club" to keep them from having any regressions.

-- Steve
