From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Arches that don't support PREEMPT
Date: Wed, 20 Sep 2023 09:29:21 +0200
Message-ID: <ZQqfURDGaXQdTzZS@gmail.com>
References: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
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
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695194965; x=1695799765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9FUmFWGdaoCCAX+yBYd9oidTjhPdRU5Hczc1k2R6GM=;
        b=lYBYsrmhPNW96ohxoysYDSqqE8OzwYp7oyFXge92IlJPIpKW1IObFR39gYATLEJLJX
         Th+IT73wJWAjUv7ZbGdbbmmq1qASbBQP4S0asJhUxSb6LdP6ON7nEZkvBiKWb27/lG7m
         t9cZg24pxlXfeKgxTykpJQjKV/Rl+lBB65wf3/JryRaymRpOEUYdjy8OXfNdH16HP0qX
         k4aJg8gca3ZgCWzqlGeSqqKa/z9MXHYn/WZpQtG3n1jr1A1xPuMsDehMohuYm8/xtbk/
         o8jvN32SvCd1BN72fs5a4hTfqkZQU1bi1nW1+k+eH22Wb4Z0s2goyEQUVsfvB2WN7z+Y
         QzSA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Content-Disposition: inline
In-Reply-To: <87pm2eui95.ffs@tglx>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Sep 19 2023 at 10:25, Linus Torvalds wrote:
> > On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >>
> >> As Geert poined out, I'm not seeing anything particular problematic with the
> >> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> >> something about organizing KConfig files.
> >
> > It can definitely be problematic.
> >
> > Not the Kconfig file part, and not the preempt count part itself.
> >
> > But the fact that it has never been used and tested means that there
> > might be tons of "this architecture code knows it's not preemptible,
> > because this architecture doesn't support preemption".
> >
> > So you may have basic architecture code that simply doesn't have the
> > "preempt_disable()/enable()" pairs that it needs.
> >
> > PeterZ mentioned the generic entry code, which does this for the entry
> > path. But it actually goes much deeper: just do a
> >
> >     git grep preempt_disable arch/x86/kernel
> >
> > and then do the same for some other architectures.
> >
> > Looking at alpha, for example, there *are* hits for it, so at least
> > some of the code there clearly *tries* to do it. But does it cover all
> > the required parts? If it's never been tested, I'd be surprised if
> > it's all just ready to go.
> >
> > I do think we'd need to basically continue to support ARCH_NO_PREEMPT
> > - and such architectures migth end up with the worst-cast latencies of
> > only scheduling at return to user space.
> 
> The only thing these architectures should gain is the preempt counter 
> itself, [...]

And if any of these machines are still used, there's the small benefit of 
preempt_count increasing debuggability of scheduling in supposedly 
preempt-off sections that were ignored silently previously, as most of 
these architectures do not even enable CONFIG_DEBUG_ATOMIC_SLEEP=y in their 
defconfigs:

  $ for ARCH in alpha hexagon m68k um; do git grep DEBUG_ATOMIC_SLEEP arch/$ARCH; done
  $

Plus the efficiency of CONFIG_DEBUG_ATOMIC_SLEEP=y is much reduced on 
non-PREEMPT kernels to begin with: it will basically only detect scheduling 
in hardirqs-off critical sections.

So IMHO there's a distinct debuggability & robustness plus in enabling the 
preemption count on all architectures, even if they don't or cannot use the 
rescheduling points.

> [...] but yes the extra preemption points are not mandatory to have, i.e. 
> we simply do not enable them for the nostalgia club.
> 
> The removal of cond_resched() might cause latencies, but then I doubt 
> that these museus pieces are used for real work :)

I'm not sure we should initially remove *explicit* legacy cond_resched() 
points, except from high-freq paths where they hurt - and of course remove 
them from might_sleep().

Thanks,

	Ingo
