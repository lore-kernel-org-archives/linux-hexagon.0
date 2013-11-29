From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v2] arch: hexagon: kernel: hexagon_ksyms.c: export related
 symbols which various modules need
Date: Fri, 29 Nov 2013 12:03:46 +0800
Message-ID: <52981222.3080007@gmail.com>
References: <529811AE.8050502@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MPmGsp/n8ts4Buwf/XxJwmfZe0ZUsd8i+ovOKLvWoKw=;
        b=IIB7T8ZDwQCW40Wi5XlDyQykFP6ACZiK7ENaJ/HPQYFo8hQ2r1nAwPKCO/X94rv6h0
         WU6dXs1zotB/0VjAvUBLcYMiP4RfFZfvuRyeqd2g5pRNWYMJ4myJISE2LvwdC7KWrsWq
         4mG20ifDwcVIFnW1Uj+E62SFn85y9gE6kUHqTPIm8xUD9WtV/42HEdE0d+RrSfzfj8+G
         hcVVDl5oPFZmF3uAZDhWY+L6wBGdVP+3b8by0qyOTpAmKqTJvF7CFsU4JCDqt21XpP4n
         KhYyUUolOrWNmKA3Yv1gKeiRQQX0VoHtu5As7d8RgPZ7j1U54teW6KWIKUSTDVcUYBG1
         3YCA==
In-Reply-To: <529811AE.8050502@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


After this patch, excluding the VGA_CONSOLE issue, the hexagon can pass
allmodconfig. :-)

Please help check all related patches when you have time.


Thanks.

On 11/29/2013 12:01 PM, Chen Gang wrote:
> Need export all related functions and symbols for various modules with
> allmodconfig. The related errors:
> 
>     MODPOST 2879 modules
>   ERROR: "__vmyield" [sound/sound_firmware.ko] undefined!
>   ERROR: "__phys_offset" [sound/drivers/snd-dummy.ko] undefined!
>   ERROR: "ioremap_nocache" [drivers/char/ipmi/ipmi_si.ko] undefined!
>   ERROR: "__iounmap" [drivers/char/ipmi/ipmi_si.ko] undefined!
>   ...
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/kernel/hexagon_ksyms.c |   27 +++++++++++++++++++++++----
>  1 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
> index 32b1379..3188de4 100644
> --- a/arch/hexagon/kernel/hexagon_ksyms.c
> +++ b/arch/hexagon/kernel/hexagon_ksyms.c
> @@ -20,6 +20,9 @@
>  
>  #include <asm/hexagon_vm.h>
>  #include <asm/uaccess.h>
> +#include <asm/io.h>
> +#include <linux/dma-mapping.h>
> +#include <asm/dma-mapping.h>
>  
>  EXPORT_SYMBOL(__copy_from_user_hexagon);
>  EXPORT_SYMBOL(__copy_to_user_hexagon);
> @@ -28,13 +31,29 @@ EXPORT_SYMBOL(__vmsetie);
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memset);
>  
> +/* Additional functions */
> +EXPORT_SYMBOL(__strnlen_user);
> +EXPORT_SYMBOL(__vmyield);
> +EXPORT_SYMBOL(__iounmap);
> +EXPORT_SYMBOL(__clear_user_hexagon);
> +EXPORT_SYMBOL(ioremap_nocache);
> +EXPORT_SYMBOL(empty_zero_page);
> +
> +/* Additional variables */
> +EXPORT_SYMBOL(_dflt_cache_att);
> +EXPORT_SYMBOL(__phys_offset);
> +EXPORT_SYMBOL(bad_dma_address);
> +
>  #define DECLARE_EXPORT(name)     \
>  	extern void name(void); EXPORT_SYMBOL(name)
>  
>  /* Symbols found in libgcc that assorted kernel modules need */
>  DECLARE_EXPORT(__hexagon_memcpy_likely_aligned_min32bytes_mult8bytes);
>  
> -DECLARE_EXPORT(__hexagon_divsi3);
> -DECLARE_EXPORT(__hexagon_modsi3);
> -DECLARE_EXPORT(__hexagon_udivsi3);
> -DECLARE_EXPORT(__hexagon_umodsi3);
> +DECLARE_EXPORT(__divsi3);
> +DECLARE_EXPORT(__modsi3);
> +DECLARE_EXPORT(__udivsi3);
> +DECLARE_EXPORT(__umodsi3);
> +
> +/* Additional functions */
> +DECLARE_EXPORT(csum_tcpudp_magic);
> 


-- 
Chen Gang
