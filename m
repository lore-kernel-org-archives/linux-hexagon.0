From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some architectures
Date: Sun, 5 Mar 2023 10:29:52 +0100
Message-ID: <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
References: <20230303102817.212148-1-bhe@redhat.com> <20230303102817.212148-3-bhe@redhat.com>
 <87sfej1rie.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <87sfej1rie.fsf@mpe.ellerman.id.au>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de, mcgrof@kernel.org, hch@infradead.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

Hi Michael,

On Sun, Mar 5, 2023 at 10:23=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> Baoquan He <bhe@redhat.com> writes:
> > ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> > extension, and on ia64 with its slightly unconventional ioremap()
> > behavior, everywhere else this is the same as ioremap() anyway.
> >
> > Here, remove the ioremap_uc() definition in architecutures other
> > than x86 and ia64. These architectures all have asm-generic/io.h
> > included and will have the default ioremap_uc() definition which
> > returns NULL.
> >
> > Note: This changes the existing behaviour and could break code
> > calling ioremap_uc(). If any ARCH meets this breakage and really
> > needs a specific ioremap_uc() for its own usage, one ioremap_uc()
> > can be added in the ARCH.
>
> I see one use in:
>
> drivers/video/fbdev/aty/atyfb_base.c:        par->ati_regbase =3D ioremap=
_uc(info->fix.mmio_start, 0x1000);
>
>
> Which isn't obviously x86/ia64 specific.
>
> I'm pretty sure some powermacs (powerpc) use that driver.

I originally wrote that driver for CHRP, so yes.

> Maybe that exact code path is only reachable on x86/ia64? But if so
> please explain why.
>
> Otherwise it looks like this series could break that driver on powerpc
> at least.

Indeed.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
