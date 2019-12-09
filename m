From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] hexagon: io: Define ioremap_uc to fix build error
Date: Mon, 9 Dec 2019 16:40:39 +0200
Message-ID: <20191209144039.GI32742@smile.fi.intel.com>
References: <20191204133328.18668-1-linux@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191204133328.18668-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Tuowen Zhao <ztuowen@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>, Lee Jones <lee.jones@linaro.org>

On Wed, Dec 04, 2019 at 05:33:28AM -0800, Guenter Roeck wrote:
> ioremap_uc is now mandatory.
> 
> lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'

Thanks for a fix!
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


