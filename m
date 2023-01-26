From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] m68k: use asm-generic/memory_model.h for both MMU and !MMU
Date: Thu, 26 Jan 2023 09:20:33 +0100
Message-ID: <CAMuHMdUeuPgkWVjpZ=OM4ofnoYyv2nY1_FGo0JUZCFXYX=K2vw@mail.gmail.com>
References: <20230125190757.22555-1-rppt@kernel.org> <20230125190757.22555-2-rppt@kernel.org>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20230125190757.22555-2-rppt@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourceforge.j>

On Wed, Jan 25, 2023 at 8:08 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> The MMU variant uses generic definitions of page_to_pfn() and
> pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
> good reason.
>
> Include asm-generic/memory_model.h in the common include/asm/page.h and
> drop redundant definitions.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
