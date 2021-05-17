From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
Date: Mon, 17 May 2021 09:42:02 +0200
Message-ID: <CAMuHMdXr6gxbJu+otHV=PhoXvM7aoshs_A-SVpTmYw1iDdiqsg@mail.gmail.com>
References: <20210514220942.879805-1-arnd@kernel.org> <20210514220942.879805-2-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20210514220942.879805-2-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Sid Manning <sidneym@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-d>

On Sat, May 15, 2021 at 12:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is a preparation for changing over architectures to the
> generic implementation one at a time. As there are no callers
> of either __strncpy_from_user() or __strnlen_user(), fold these
> into the strncpy_from_user() strnlen_user() functions to make

... and ...

> each implementation independent of the others.
>
> Many of these implementations have known bugs, but the intention
> here is to not change behavior at all and stay compatible with
> those bugs for the moment.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
