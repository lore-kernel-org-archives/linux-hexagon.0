From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Arches that don't support PREEMPT
Date: Wed, 20 Sep 2023 09:32:38 +0200
Message-ID: <ZQqgFpA6l1eK1KKV@gmail.com>
References: <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
 <87pm2eui95.ffs@tglx>
 <20230919143816.1741760a@gandalf.local.home>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695195162; x=1695799962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWzgC+PpnfmZJpwJToZon+LX7cLfjuMVcroIeSc6zGs=;
        b=eHwbfk3T4K7FfIw/icgd0CVcXFEsLzlRgIqN0uUreBD9KJU7AFka1mgjM/mGzOSmEa
         /pSlhklTcaMYzcJRHYxZxw9n0uAV8lqQIQSETCaPhGjb/bi18Wsj2cZUjcs2/64WcenQ
         0rm48tz/qdo17WBeL5JWFBlZb2kaWovHcTBDilZqp8taMdcNS6UQOJFqYyPSkuccRKso
         XQEBu4Bj7LXMfUtwjmeAiMqqqKmEAtJtB1YsGxw/i4OTXQACG/OcPQtBQCgPIkwHezJk
         ge/S7RXs1GnhABwc0AnTmR+Tb7FO8fnyDjSYlYLSALClG0bjiighlYKrnFsBPHUApNZE
         BQ4A==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Content-Disposition: inline
In-Reply-To: <20230919143816.1741760a@gandalf.local.home>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@n>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 19 Sep 2023 20:31:50 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > The removal of cond_resched() might cause latencies, but then I doubt
> > that these museus pieces are used for real work :)
> 
> We could simply leave the cond_resched() around but defined as nops for
> everything but the "nostalgia club" to keep them from having any regressions.

That's not a good idea IMO, it's an invitation for accelerated rate bitrot 
turning cond_resched() meaningless very quickly.

We should remove cond_resched() - but probably not as the first step. They 
are conceptually independent of NEED_RESCHED_LAZY and we don't *have to* 
remove them straight away.

By removing cond_resched() separately there's an easily bisectable point to 
blame for any longer latencies on legacy platforms, should any of them 
still be used with recent kernels.

Thanks,

	Ingo
