From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/13] preempt: Make preempt count
 unconditional
Date: Mon, 14 Sep 2020 15:24:52 -0700
Message-ID: <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FYq5Ck3jxQlGA/9U/OgNyRBwFyvhqjGeOq2xChwQGbM=;
 b=XFttBOpQLvqvIRVeSi6uJbTlvU6SlD5mRsF0dJOTawed/ahybFXu96kFFWmQERfAs5
 uWk/oLz9DrNGHszMiHMxoNqcLliSwLYwqi8cuttKuqm5YKsnPsoT05HyVh7UvUs3bSkf
 Wa6vYuwCrOJ+5ggzCPNzgdilcNNnHeeOAvJeA=
In-Reply-To: <871rj4owfn.fsf@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx <intel-gfx@lists.freedesktop.org>, Matt Turner <mattst88@gmail.com>, Valentin Schneider <valen>

On Mon, Sep 14, 2020 at 2:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Yes it does generate better code, but I tried hard to spot a difference
> in various metrics exposed by perf. It's all in the noise and I only
> can spot a difference when the actual preemption check after the
> decrement

I'm somewhat more worried about the small-device case.

That said, the diffstat certainly has its very clear charm, and I do
agree that it makes things simpler.

I'm just not convinced people should ever EVER do things like that "if
(preemptible())" garbage. It sounds like somebody is doing seriously
bad things.

The chacha20poly1305 code does look fundamentally broken. But no, the
fix is not to make "preemptible" work with spinlocks, the fix is to
not *do* that kind of broken things.

Those things would be broken even if you changed the semantics of
preemptible. There's no way that it's valid to say "use this debug
flag to decide if we should do atomic allocations or not".

It smells like "I got a debug failure, so I'm papering it over by
checking the thing the debug code checks for".

The debug check is to catch the obvious bad cases. It's not the _only_
bad cases, so copying the debug check test is just completely wrong.

Ard and Herbert added to participants: see
chacha20poly1305_crypt_sg_inplace(), which does

        flags = SG_MITER_TO_SG;
        if (!preemptible())
                flags |= SG_MITER_ATOMIC;

introduced in commit d95312a3ccc0 ("crypto: lib/chacha20poly1305 -
reimplement crypt_from_sg() routine").

You *fundamentally* cannot do that. Seriously. It's completely wrong.
Pick one or the other, or have the caller *tell* you what the context
is.

                Linus
