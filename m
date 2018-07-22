From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch/h8300: fix kernel/dma.c build warning
Date: Sun, 22 Jul 2018 11:25:59 +0200
Message-ID: <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
References: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

CC hexagon

hexagon != H8/300 != SuperH

On Sat, Jul 21, 2018 at 5:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
> to unsigned long to match the function parameter type.
>
> ../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
> ../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
> ../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/hexagon/kernel/dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20180717.orig/arch/hexagon/kernel/dma.c
> +++ linux-next-20180717/arch/hexagon/kernel/dma.c
> @@ -47,7 +47,7 @@ void *arch_dma_alloc(struct device *dev,
>                         panic("Can't create %s() memory pool!", __func__);
>                 else
>                         gen_pool_add(coherent_pool,
> -                               pfn_to_virt(max_low_pfn),
> +                               (unsigned long)pfn_to_virt(max_low_pfn),
>                                 hexagon_coherent_pool_size, -1);
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
