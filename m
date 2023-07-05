From: Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [05/12] arch: Remove trailing whitespaces
Date: Wed, 5 Jul 2023 09:25:01 +0800
Message-ID: <d1c0702f-e16d-1edd-19a4-1bdc2def14ab@loongson.cn>
References: <20230629121952.10559-6-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <20230629121952.10559-6-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-csky@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Zi Yan <ziy@nvidia.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, loongarch@lists.linux.dev, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arm-kernel@lists.infradea


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>

> ---
>   arch/ia64/Kconfig | 4 ++--
>   arch/sh/Kconfig   | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 21fa63ce5ffc0..e79f15e32a451 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -260,7 +260,7 @@ config PERMIT_BSP_REMOVE
>   	default n
>   	help
>   	Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
> -	support.
> +	support.
>   
>   config FORCE_CPEI_RETARGET
>   	bool "Force assumption that CPEI can be re-targeted"
> @@ -335,7 +335,7 @@ config IA64_PALINFO
>   config IA64_MC_ERR_INJECT
>   	tristate "MC error injection support"
>   	help
> -	  Adds support for MC error injection. If enabled, the kernel
> +	  Adds support for MC error injection. If enabled, the kernel
>   	  will provide a sysfs interface for user applications to
>   	  call MC error injection PAL procedures to inject various errors.
>   	  This is a useful tool for MCA testing.
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 9652d367fc377..04b9550cf0070 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -234,7 +234,7 @@ config CPU_SUBTYPE_SH7201
>   	select CPU_SH2A
>   	select CPU_HAS_FPU
>   	select SYS_SUPPORTS_SH_MTU2
> -
> +
>   config CPU_SUBTYPE_SH7203
>   	bool "Support SH7203 processor"
>   	select CPU_SH2A
> @@ -496,7 +496,7 @@ config CPU_SUBTYPE_SH7366
>   endchoice
>   
>   source "arch/sh/mm/Kconfig"
> -
> +
>   source "arch/sh/Kconfig.cpu"
>   
>   source "arch/sh/boards/Kconfig"
> @@ -647,7 +647,7 @@ config GUSA
>   	  This is the default implementation for both UP and non-ll/sc
>   	  CPUs, and is used by the libc, amongst others.
>   
> -	  For additional information, design information can be found
> +	  For additional information, design information can be found
>   	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
>   
>   	  This should only be disabled for special cases where alternate

