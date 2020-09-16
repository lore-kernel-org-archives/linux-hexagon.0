From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Date: Wed, 16 Sep 2020 13:43:59 -0700
Message-ID: <20200916204359.GB29330@paulmck-ThinkPad-P72>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600289039;
        bh=MM/OYkhIqW+q1jlzGplM7TRGk23CKIsPg/gtHCbpw/s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ePzv3fwWqslNC9hLhuqpPOyt/s8elqT4skklSXCKPyGt5+DSX45Mij1jR0UQAfYSu
         rlP0OmdNpXpvof5fQPOx2SpQZrxcPIGOMObx61mSVBfXvuGrzip0wCyXdOZekUurt/
         goh6RQLFx9+QF+bnlf7qV2Wg9jJz35j9g42ob9HA=
Content-Disposition: inline
In-Reply-To: <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, l

On Wed, Sep 16, 2020 at 11:32:00AM -0700, Linus Torvalds wrote:
> On Wed, Sep 16, 2020 at 8:29 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > All fair, but some of us need to write code that must handle being
> > invoked from a wide variety of contexts.
> 
> Note that I think that core functionality is different from random drivers.
> 
> Of course core code can (and will) look at things like
> 
>         if (in_interrupt())
>             .. schedule work asynchronously ..
> 
> because core code ends up being called from odd places, and code like
> that is expected to have understanding of the rules it plays with.
> 
> But something like RCU is a very different beast from some "walk the
> scatter-gather list" code.
> 
> RCU does its work in the background, and works with lots of different
> things. And it's so core and used everywhere that it knows about these
> things. I mean, we literally have special code explicitly to let RCU
> know "we entered kernel context now".
> 
> But something like a driver list walking thing should not be doing
> different things behind peoples back depending on whether they hold
> spinlocks or not. It should either just work regardless, or there
> should be a flag (or special interface) for the "you're being called
> in a crtitical region".
> 
> Because dynamically changing behavior really is very confusing.

Whew!  I feel much better now.  ;-)

							Thanx, Paul
