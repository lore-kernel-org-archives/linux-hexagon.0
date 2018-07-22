From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch/h8300: modify ffs(), fls() etc. functions to return int
Date: Sun, 22 Jul 2018 11:25:07 +0200
Message-ID: <CAMuHMdVwY0b9S3j2MnuC59vYOuV=LXtQwnhevq227r+mec491Q@mail.gmail.com>
References: <1cdcd8e1-b12c-31cb-1188-c062dae3e461@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1cdcd8e1-b12c-31cb-1188-c062dae3e461@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

CC hexagon

hexagon != H8/300 != SuperH

On Sat, Jul 21, 2018 at 5:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> printk format build warning.  This is due to hexagon's ffs() being
> coded as returning long instead of int.
>
> Fix the printk format warning by changing all of hexagon's ffx() and
> flx() functions to return int instead of long.  The variables that
> they return are already int instead of long.
>
> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
>
>
> There are no ffx() or flx() allmodconfig build errors after making this
> change.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/hexagon/include/asm/bitops.h |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> --- linux-next-20180717.orig/arch/hexagon/include/asm/bitops.h
> +++ linux-next-20180717/arch/hexagon/include/asm/bitops.h
> @@ -194,7 +194,7 @@ static inline int __test_bit(int nr, con
>   *
>   * Undefined if no zero exists, so code should check against ~0UL first.
>   */
> -static inline long ffz(int x)
> +static inline int ffz(int x)
>  {
>         int r;
>
> @@ -211,7 +211,7 @@ static inline long ffz(int x)
>   * This is defined the same way as ffs.
>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>   */
> -static inline long fls(int x)
> +static inline int fls(int x)
>  {
>         int r;
>
> @@ -232,7 +232,7 @@ static inline long fls(int x)
>   * the libc and compiler builtin ffs routines, therefore
>   * differs in spirit from the above ffz (man ffs).
>   */
> -static inline long ffs(int x)
> +static inline int ffs(int x)
>  {
>         int r;
>
> @@ -254,7 +254,7 @@ static inline long ffs(int x)
>   * bits_per_long assumed to be 32
>   * numbering starts at 0 I think (instead of 1 like ffs)
>   */
> -static inline unsigned long __ffs(unsigned long word)
> +static inline int __ffs(unsigned long word)

The version in asm-generic deoes use "unsigned long".

See also "m68k/bitops: convert __ffs to match generic declaration"
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?h=for-v4.19&id=4b538d3dca3e590cdb0234746011a6d9c245cfa3

>  {
>         int num;
>
> @@ -272,7 +272,7 @@ static inline unsigned long __ffs(unsign
>   * Undefined if no set bit exists, so code should check against 0 first.
>   * bits_per_long assumed to be 32
>   */
> -static inline unsigned long __fls(unsigned long word)
> +static inline int __fls(unsigned long word)

Same here

>  {
>         int num;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
