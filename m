From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Thu, 1 Jun 2023 09:20:05 +0200
Message-ID: <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com> <20230531213032.25338-31-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20230531213032.25338-31-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On Wed, May 31, 2023 at 11:33=E2=80=AFPM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents. Also cleans up some spacing issues.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
