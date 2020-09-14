From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/13] preempt: Make preempt count
 unconditional
Date: Mon, 14 Sep 2020 15:37:49 -0700
Message-ID: <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HByVscULZ1aCzKEsNJOaDk74v0AyftSy1pTwuoj93qw=;
 b=Cd9Si1L6gfURzpvvo99txBSmG4fycZzpI1K602Rqdgokf4YjHKM5bshv0gBeRPoKoq
 S07+pMee3ja0pLLEif7+5dTcJ55cbbmX1a0rjsvg02GjZzwr0ekBVDISdAQ1ceTpPczJ
 7r3vx/CHsgdJU8GacJiTsbr8oX1ECzkK1quPE=
In-Reply-To: <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
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

On Mon, Sep 14, 2020 at 3:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ard and Herbert added to participants: see
> chacha20poly1305_crypt_sg_inplace(), which does
>
>         flags = SG_MITER_TO_SG;
>         if (!preemptible())
>                 flags |= SG_MITER_ATOMIC;
>
> introduced in commit d95312a3ccc0 ("crypto: lib/chacha20poly1305 -
> reimplement crypt_from_sg() routine").

As far as I can tell, the only reason for this all is to try to use
"kmap()" rather than "kmap_atomic()".

And kmap() actually has the much more complex "might_sleep()" tests,
and apparently the "preemptible()" check wasn't even the proper full
debug check, it was just a complete hack to catch the one that
triggered.

From a quick look, that code should probably just get rid of
SG_MITER_ATOMIC entirely, and alwayse use kmap_atomic().

kmap_atomic() is actually the faster and proper interface to use
anyway (never mind that any of this matters on any sane hardware). The
old kmap() and kunmap() interfaces should generally be avoided like
the plague - yes, they allow sleeping in the middle and that is
sometimes required, but if you don't need that, you should never ever
use them.

We used to have a very nasty kmap_atomic() that required people to be
very careful and know exactly which atomic entry to use, and that was
admitedly quite nasty.

So it _looks_ like this code started using kmap() - probably back when
kmap_atomic() was so cumbersome to use - and was then converted
(conditionally) to kmap_atomic() rather than just changed whole-sale.
Is there actually something that wants to use those sg_miter functions
and sleep?

Because if there is, that choice should come from the outside, not
from inside lib/scatterlist.c trying to make some bad guess based on
the wrong thing entirely.

                 Linus
