From: Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [11/12] fbdev/core: Protect edid_info with
 CONFIG_ARCH_HAS_EDID_INFO
Date: Wed, 5 Jul 2023 09:43:09 +0800
Message-ID: <dc239a28-4314-1661-f556-670946a0982b@loongson.cn>
References: <20230629121952.10559-12-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <20230629121952.10559-12-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi,


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> Guard usage of edid_info with CONFIG_ARCH_HAS_EDID_INFO instead
> of CONFIG_X86. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>   drivers/video/fbdev/core/fbmon.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 35be4431f649a..9ae063021e431 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1480,17 +1480,19 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
>   		-EINVAL : 0;
>   }
>   
> -#if defined(CONFIG_FIRMWARE_EDID) && defined(CONFIG_X86)
> +#if defined(CONFIG_FIRMWARE_EDID)
>   const unsigned char *fb_firmware_edid(struct fb_info *info)
>   {
>   	unsigned char *edid = NULL;
>   
> +#if defined(CONFIG_ARCH_HAS_EDID_INFO)
>   	/*
>   	 * We need to ensure that the EDID block is only
>   	 * returned for the primary graphics adapter.
>   	 */
>   	if (fb_is_primary_device(info))
>   		edid = edid_info.dummy;
> +#endif
>   
>   	return edid;
>   }

