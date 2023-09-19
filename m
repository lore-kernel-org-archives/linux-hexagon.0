From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 15:34:08 +0200
Message-ID: <CAMuHMdXd=jtggL3H4XuBuuNY3QtLDK7Ny=AaSWEjhmRyLwjAGQ@mail.gmail.com>
References: <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <ZQmbhoQIINs8rLHp@casper.infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Matthew Wilcox <willy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infr

Hi Willy,

On Tue, Sep 19, 2023 at 3:01=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
> > Though it just occured to me that there are dragons lurking:
> >
> > arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> > arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> > arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> > arch/um/Kconfig:        select ARCH_NO_PREEMPT
>
> Sounds like three-and-a-half architectures which could be queued up for
> removal right behind ia64 ...
>
> I suspect none of these architecture maintainers have any idea there's a
> problem.  Look at commit 87a4c375995e and the discussion in
> https://lore.kernel.org/lkml/20180724175646.3621-1-hch@lst.de/

These links don't really point out there is a grave problem?

> Let's cc those maintainers so they can remove this and fix whatever
> breaks.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
