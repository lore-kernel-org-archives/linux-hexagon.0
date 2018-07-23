From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
Date: Mon, 23 Jul 2018 09:58:33 +0200
Message-ID: <CAMuHMdV9yvjTkpao2SdnWObQpjeNV_g=cJwq-SCzDiXvq8jNdw@mail.gmail.com>
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>

On Mon, Jul 23, 2018 at 1:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> printk format build warning.  This is due to hexagon's ffs() being
> coded as returning long instead of int.
>
> Fix the printk format warning by changing all of hexagon's ffs() and
> fls() functions to return int instead of long.  The variables that
> they return are already int instead of long.  This return type
> matches the return type in <asm-generic/bitops/>.
>
> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
>
> There are no ffs() or fls() allmodconfig build errors after making this
> change.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
