From: Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [01/12] efi: Do not include <linux/screen_info.h> from EFI header
Date: Wed, 5 Jul 2023 09:40:10 +0800
Message-ID: <26e355dd-049c-fa82-dc5d-565b86339253@loongson.cn>
References: <20230629121952.10559-2-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <20230629121952.10559-2-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hi, Thomas


I love your patch, LoongArch also have UEFI GOP support,

Maybe the arch/loongarch/kernel/efi.c don't include the '#include 
<linux/screen_info.h>' explicitly.


```

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 3d448fef3af4..04f4d217aefb 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -19,6 +19,7 @@
  #include <linux/memblock.h>
  #include <linux/reboot.h>
  #include <linux/uaccess.h>
+#include <linux/screen_info.h>

  #include <asm/early_ioremap.h>
  #include <asm/efi.h>
```


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> The header file <linux/efi.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements. Update a number of source files that
> require struct screen_info's definition.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

With the above issue solved, please take my R-B if you would like.


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>

> ---
>   arch/arm/kernel/efi.c                         | 2 ++
>   arch/arm64/kernel/efi.c                       | 1 +
>   drivers/firmware/efi/libstub/efi-stub-entry.c | 2 ++
>   drivers/firmware/efi/libstub/screen_info.c    | 2 ++
>   include/linux/efi.h                           | 3 ++-
>   5 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
> index e2b9d2618c672..e94655ef16bb3 100644
> --- a/arch/arm/kernel/efi.c
> +++ b/arch/arm/kernel/efi.c
> @@ -5,6 +5,8 @@
>   
>   #include <linux/efi.h>
>   #include <linux/memblock.h>
> +#include <linux/screen_info.h>
> +
>   #include <asm/efi.h>
>   #include <asm/mach/map.h>
>   #include <asm/mmu_context.h>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index baab8dd3ead3c..3afbe503b066f 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/efi.h>
>   #include <linux/init.h>
> +#include <linux/screen_info.h>
>   
>   #include <asm/efi.h>
>   #include <asm/stacktrace.h>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index cc4dcaea67fa6..2f1902e5d4075 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
>   #include <linux/efi.h>
> +#include <linux/screen_info.h>
> +
>   #include <asm/efi.h>
>   
>   #include "efistub.h"
> diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
> index 4be1c4d1f922b..a51ec201ca3cb 100644
> --- a/drivers/firmware/efi/libstub/screen_info.c
> +++ b/drivers/firmware/efi/libstub/screen_info.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <linux/efi.h>
> +#include <linux/screen_info.h>
> +
>   #include <asm/efi.h>
>   
>   #include "efistub.h"
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 571d1a6e1b744..360895a5572c0 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -24,10 +24,11 @@
>   #include <linux/range.h>
>   #include <linux/reboot.h>
>   #include <linux/uuid.h>
> -#include <linux/screen_info.h>
>   
>   #include <asm/page.h>
>   
> +struct screen_info;
> +
>   #define EFI_SUCCESS		0
>   #define EFI_LOAD_ERROR		( 1 | (1UL << (BITS_PER_LONG-1)))
>   #define EFI_INVALID_PARAMETER	( 2 | (1UL << (BITS_PER_LONG-1)))

