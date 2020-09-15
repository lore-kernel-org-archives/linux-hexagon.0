From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/13] preempt: Make preempt count
 unconditional
Date: Tue, 15 Sep 2020 21:57:37 +0200
Message-ID: <87y2la4xu6.fsf@nanos.tec.linutronix.de>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600199857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WUf3cR8tRBv7eifn3bYRJqwOE06JyVH+YNcuAlhPEzY=;
 b=R4Zt8iBiRf9a+cl1bV87aTb7PzjrsY9fDXMhiBS8K2ot+081OXV43gzpJxoKPhJ+bG/r3d
 IZ+XMelmwH6I1/IeBzA0fsbvOLaK8KTaPACawTHUg6jjadOJqPR3b3oHieYk1VWz6/0oQm
 160PfMvRl4sOXnVT35YSXZOTlM61qgXSYzZSMF7oaVHQZW8+sX+YqTW5CPNn3M/4wDy6pz
 FqyKA3YK/qnHJa+/v8mb9TXFlw3YCbBIJGJZD6NGKFvRIxsCkXAfwQ3qqvw+SkHnN/x3SA
 Xr1GzKJIli+LvQNZjFraeH3J5TJIjCZBBRyHcln921IMOu/pI6tJi9qyOaIRUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600199857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WUf3cR8tRBv7eifn3bYRJqwOE06JyVH+YNcuAlhPEzY=;
 b=GHgvirbCN6gxc0oKsh65B0tX+BLegnUGJa5AhDfyLfEqCZ+BxU1R9tgqcRPDwCSIqCwX9J
 bXubW9jdXnVc0gCA==
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

On Tue, Sep 15 2020 at 10:35, Linus Torvalds wrote:
> On Tue, Sep 15, 2020 at 1:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> OTOH, having a working 'preemptible()' or maybe better named
>> 'can_schedule()' check makes tons of sense to make decisions about
>> allocation modes or other things.
>
> No. I think that those kinds of decisions about actual behavior are
> always simply fundamentally wrong.
>
> Note that this is very different from having warnings about invalid
> use. THAT is correct. It may not warn in all configurations, but that
> doesn't matter: what matters is that it warns in common enough
> configurations that developers will catch it.

You wish. I just found a 7 year old bug in a 10G network driver which
surely would have been found if people would enable debug configs and
not just run the crap on their PREEMPT_NONE, all debug off kernel. And
that driver is not subject to bitrot, it gets regular bug fixes from
people who seem to care (distro folks).

> So having a warning in "might_sleep()" that doesn't always trigger,
> because you have a limited configuration that can't even detect the
> situation, that's fine and dandy and intentional.

and lets people get away with their crap.

> But having code like
>
>        if (can_schedule())
>            .. do something different ..
>
> is fundamentally complete and utter garbage.
>
> It's one thing if you test for "am I in hardware interrupt context".
> Those tests aren't great either, but at least they make sense.

They make sense in limited situations like exception handlers and such
which really have to know from which context an exception was raised.

But with the above reasoning such checks do not make sense in any other
general code. 'in hard interrupt context' is just another context where
you can't do stuff which you can do when in preemptible task context.

Most tests are way broader than a single context. in_interrupt() is true
for hard interrupt, soft interrupt delivery and all BH disabled
contexts, which is completely ill defined.

> But a driver - or some library routine - making a difference based on
> some nebulous "can I schedule" is fundamentally and basically WRONG.
>
> If some code changes behavior, it needs to be explicit to the *caller*
> of that code.

I'm fine with that, but then we have to be consequent and ban _all_ of
these and not just declare can_schedule() to be a bad one.

Thanks,

        tglx
