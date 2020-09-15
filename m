From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Date: Tue, 15 Sep 2020 09:20:59 +0300
Message-ID: <CAMj1kXHrDU50D08TwLfzz2hCK+8+C7KGPF99PphXtsOYZ-ff1g@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600150871;
        bh=yHPOwHAJMf2CyGYn5iaGApE31+NbMN1jtYRrQr3OqtY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TmmxknEGZyvx8vlGW5CGW73+O4uXGgraFnOf4HjrP8W3fP+hO00OxomgQPDZMrWul
         TTPtnmKpuFwwNrUFpHPuMsrGwVxISsxidGAMi4sBmKygdDvEVG1y6hO3MT19lxjr8u
         N8b5Mw4ZsilvmmxhDCjXlk2EUymtxsG5fkzIFbZw=
In-Reply-To: <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kernel.org>

On Tue, 15 Sep 2020 at 01:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 14, 2020 at 3:24 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ard and Herbert added to participants: see
> > chacha20poly1305_crypt_sg_inplace(), which does
> >
> >         flags = SG_MITER_TO_SG;
> >         if (!preemptible())
> >                 flags |= SG_MITER_ATOMIC;
> >
> > introduced in commit d95312a3ccc0 ("crypto: lib/chacha20poly1305 -
> > reimplement crypt_from_sg() routine").
>
> As far as I can tell, the only reason for this all is to try to use
> "kmap()" rather than "kmap_atomic()".
>
> And kmap() actually has the much more complex "might_sleep()" tests,
> and apparently the "preemptible()" check wasn't even the proper full
> debug check, it was just a complete hack to catch the one that
> triggered.
>

This was not driven by a failing check.

The documentation of kmap_atomic() states the following:

 * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
 * gives a more generic (and caching) interface. But kmap_atomic can
 * be used in IRQ contexts, so in some (very limited) cases we need
 * it.

so if this is no longer accurate, perhaps we should fix it?

But another reason I tried to avoid kmap_atomic() is that it disables
preemption unconditionally, even on 64-bit architectures where HIGHMEM
is irrelevant. So using kmap_atomic() here means that the bulk of
WireGuard packet encryption runs with preemption disabled, essentially
for legacy reasons.


> From a quick look, that code should probably just get rid of
> SG_MITER_ATOMIC entirely, and alwayse use kmap_atomic().
>
> kmap_atomic() is actually the faster and proper interface to use
> anyway (never mind that any of this matters on any sane hardware). The
> old kmap() and kunmap() interfaces should generally be avoided like
> the plague - yes, they allow sleeping in the middle and that is
> sometimes required, but if you don't need that, you should never ever
> use them.
>
> We used to have a very nasty kmap_atomic() that required people to be
> very careful and know exactly which atomic entry to use, and that was
> admitedly quite nasty.
>
> So it _looks_ like this code started using kmap() - probably back when
> kmap_atomic() was so cumbersome to use - and was then converted
> (conditionally) to kmap_atomic() rather than just changed whole-sale.
> Is there actually something that wants to use those sg_miter functions
> and sleep?
>
> Because if there is, that choice should come from the outside, not
> from inside lib/scatterlist.c trying to make some bad guess based on
> the wrong thing entirely.
>
>                  Linus
