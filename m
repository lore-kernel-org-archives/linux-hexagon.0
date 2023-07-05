From: Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [08/12] drivers/firmware: Remove trailing whitespaces
Date: Wed, 5 Jul 2023 09:26:39 +0800
Message-ID: <483e9f1b-2ae5-7d0a-14a1-6de38acb13dc@loongson.cn>
References: <20230629121952.10559-9-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <20230629121952.10559-9-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi,

On 2023/6/29 19:45, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


> ---
>   drivers/firmware/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd627..0432737bbb8b4 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -99,7 +99,7 @@ config EFI_PCDP
>   	  You must also enable the appropriate drivers (serial, VGA, etc.)
>   
>   	  See DIG64_HCDPv20_042804.pdf available from
> -	  <http://www.dig64.org/specifications/>
> +	  <http://www.dig64.org/specifications/>
>   
>   config DMIID
>       bool "Export DMI identification via sysfs to userspace"

