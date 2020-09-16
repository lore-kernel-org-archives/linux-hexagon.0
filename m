From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [patch 00/13] preempt: Make preempt count
 unconditional
Date: Wed, 16 Sep 2020 09:37:17 +0200
Message-ID: <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ir83kA7yZmatKHQpy7nyYwdfudWOyhH141WksSrpLpI=;
 b=Wbmy2wm4Y3Z7IHj2WQgnSxJHvWaqiIYxvJrRLzN5yosJdstiBZVZo9gvc44pSE/nA1
 P9hDpmjXczq2zLOkqvx/WHir/QasP1J2aBD5X+7FKjnP91s5nxsyqJv2jhU8PZzNRGRF
 pjrrhaFUmLe21mq1kggp9iTxwlhfZdVWViCcQ=
In-Reply-To: <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx <intel-gfx@lists.f>

On Tue, Sep 15, 2020 at 7:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Sep 15, 2020 at 1:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > OTOH, having a working 'preemptible()' or maybe better named
> > 'can_schedule()' check makes tons of sense to make decisions about
> > allocation modes or other things.
>
> No. I think that those kinds of decisions about actual behavior are
> always simply fundamentally wrong.
>
> Note that this is very different from having warnings about invalid
> use. THAT is correct. It may not warn in all configurations, but that
> doesn't matter: what matters is that it warns in common enough
> configurations that developers will catch it.
>
> So having a warning in "might_sleep()" that doesn't always trigger,
> because you have a limited configuration that can't even detect the
> situation, that's fine and dandy and intentional.
>
> But having code like
>
>        if (can_schedule())
>            .. do something different ..
>
> is fundamentally complete and utter garbage.
>
> It's one thing if you test for "am I in hardware interrupt context".
> Those tests aren't great either, but at least they make sense.
>
> But a driver - or some library routine - making a difference based on
> some nebulous "can I schedule" is fundamentally and basically WRONG.
>
> If some code changes behavior, it needs to be explicit to the *caller*
> of that code.
>
> So this is why GFP_ATOMIC is fine, but "if (!can_schedule())
> do_something_atomic()" is pure shite.
>
> And I am not IN THE LEAST interested in trying to help people doing
> pure shite. We need to fix them. Like the crypto code is getting
> fixed.

Just figured I'll throw my +1 in from reading too many (gpu) drivers.
Code that tries to cleverly adjust its behaviour depending upon the
context it's running in is harder to understand and blows up in more
interesting ways. We still have drm_can_sleep() and it's mostly just
used for debug code, and I've largely ended up just deleting
everything that used it because when you're driver is blowing up the
last thing you want is to realize your debug code and output can't be
relied upon. Or worse, that the only Oops you have is the one in the
debug code, because the real one scrolled away - the original idea
behind drm_can_sleep was to make all the modeset code work
automagically both in normal ioctl/kworker context and in the panic
handlers or kgdb callbacks. Wishful thinking at best.

Also at least for me that extends to everything, e.g. I much prefer
explicit spin_lock and spin_lock_irq vs magic spin_lock_irqsave for
locks shared with interrupt handlers, since the former two gives me
clear information from which contexts such function can be called.
Other end is the memalloc_no*_save/restore functions, where I recently
made a real big fool of myself because I didn't realize how much that
impacts everything that's run within - suddenly "GFP_KERNEL for small
stuff never fails" is wrong everywhere.

It's all great for debugging and sanity checks (and we run with all
that stuff enabled in our CI), but really semantic changes depending
upon magic context checks freak my out :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
