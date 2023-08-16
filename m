From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Wed, 16 Aug 2023 09:41:15 +0200
Message-ID: <CAMuHMdWF0LseSGK6=aodXaoK9D16mxok4DDRs=gKoGox8k6zjg@mail.gmail.com>
References: <20230816055010.31534-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>

Hi Randy,

On Wed, Aug 16, 2023 at 7:50=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Makes perfect sense to me.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
