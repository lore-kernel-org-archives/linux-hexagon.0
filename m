From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] hexagon: io: Define ioremap_uc to fix build error
Date: Tue, 10 Dec 2019 09:09:38 +0100
Message-ID: <CAMuHMdXwJUzuSNS7CBpU5J6ofOZGrWMStJU9VaT2gp3m5U5=Lw@mail.gmail.com>
References: <20191204133328.18668-1-linux@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204133328.18668-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Brian Cain <bcain@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tuowen Zhao <ztuowen@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>, Lee Jones <lee.jones@linaro.org>

On Wed, Dec 4, 2019 at 2:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> ioremap_uc is now mandatory.
>
> lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'
>
> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
> Cc: Tuowen Zhao <ztuowen@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/hexagon/include/asm/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 539e3efcf39c..39e5605c5d42 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
>
>  void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
>  #define ioremap_nocache ioremap
> -
> +#define ioremap_uc ioremap
>
>  #define __raw_writel writel

Do we really need this? There is only one user of ioremap_uc(), which
Christoph is trying hard to get rid of, and the new devres helper that
triggers all of this :-(
https://lore.kernel.org/dri-devel/20191112105507.GA7122@lst.de/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
