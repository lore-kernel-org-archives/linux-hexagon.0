From: "Tan, Ley Foon" <ley.foon.tan@intel.com>
Subject: RE: [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
Date: Mon, 29 Mar 2021 01:35:21 +0000
Message-ID: <BY5PR11MB38934E74AF74D40379E46AB9CC7E9@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <85b1dc6339351cbc46d179e8fdb9dfc398e58303.1616765870.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ay8TMmJ++2GJdBf7EWjPTAnf1cCb7gNzJ19byz4mjw=;
 b=u/DX/kYhvaEdHbMUGTBhNPannLaSs2aqRDefhuYJOx8lA/ZONkC9mEysKJnE+KwH2IjHkNftja78aAwafaR7E8gNsMHdrjIzHD3+J+lcX49p94nISQoVItvKvzdZBu7WyCxMsAZ6S5ZXkhnnag3f8xpqZNyQyU361husRYP8uwY=
In-Reply-To: <85b1dc6339351cbc46d179e8fdb9dfc398e58303.1616765870.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "will@kernel.org" <will@kernel.org>, "danielwa@cisco.com" <danielwa@cisco.com>, "robh@kernel.org" <robh@kernel.org>, "daniel@gimpelevich.san-francisco.ca.us" <daniel@gimpelevich.san-francisco.ca.us>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, microblaze <monstr@monstr.eu>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, lin



> -----Original Message-----
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> Sent: Friday, March 26, 2021 9:45 PM
> To: will@kernel.org; danielwa@cisco.com; robh@kernel.org;
> daniel@gimpelevich.san-francisco.ca.us
> Cc: linux-arch@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; microblaze
> <monstr@monstr.eu>; linux-mips@vger.kernel.org; Tan, Ley Foon
> <ley.foon.tan@intel.com>; openrisc@lists.librecores.org; linux-
> hexagon@vger.kernel.org; linux-riscv@lists.infradead.org; x86@kernel.org;
> linux-xtensa@linux-xtensa.org; linux-sh@vger.kernel.org;
> sparclinux@vger.kernel.org
> Subject: [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
>=20
> This converts the architecture to GENERIC_CMDLINE.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/nios2/Kconfig        | 24 +-----------------------
>  arch/nios2/kernel/setup.c | 13 ++++---------
>  2 files changed, 5 insertions(+), 32 deletions(-)
>=20
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig index
> c24955c81c92..f66c97b15813 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -90,31 +90,9 @@ config NIOS2_ALIGNMENT_TRAP
>=20
>  comment "Boot options"
>=20
> -config CMDLINE_BOOL
> -	bool "Default bootloader kernel arguments"
> -	default y
> -
> -config CMDLINE
> -	string "Default kernel command string"
> -	default ""
> -	depends on CMDLINE_BOOL
> -	help
> -	  On some platforms, there is currently no way for the boot loader to
> -	  pass arguments to the kernel. For these platforms, you can supply
> -	  some command-line options at build time by entering them here.  In
> -	  other cases you can specify kernel args so that you don't have
> -	  to set them up in board prom initialization routines.
> -
> -config CMDLINE_FORCE
> -	bool "Force default kernel command string"
> -	depends on CMDLINE_BOOL
> -	help
> -	  Set this to have arguments from the default kernel command string
> -	  override those passed by the boot loader.
> -
>  config NIOS2_CMDLINE_IGNORE_DTB
>  	bool "Ignore kernel command string from DTB"
> -	depends on CMDLINE_BOOL
> +	depends on CMDLINE !=3D ""
>  	depends on !CMDLINE_FORCE
>  	default y
>  	help

Missing " select GENERIC_CMDLINE" ?




> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c index
> d2f21957e99c..42464f457a6d 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -20,6 +20,7 @@
>  #include <linux/initrd.h>
>  #include <linux/of_fdt.h>
>  #include <linux/screen_info.h>
> +#include <linux/cmdline.h>
>=20
>  #include <asm/mmu_context.h>
>  #include <asm/sections.h>
> @@ -108,7 +109,7 @@ asmlinkage void __init nios2_boot_init(unsigned r4,
> unsigned r5, unsigned r6,
>  				       unsigned r7)
>  {
>  	unsigned dtb_passed =3D 0;
> -	char cmdline_passed[COMMAND_LINE_SIZE] __maybe_unused =3D
> { 0, };
> +	char cmdline_passed[COMMAND_LINE_SIZE] =3D { 0, };
>=20
>  #if defined(CONFIG_NIOS2_PASS_CMDLINE)
>  	if (r4 =3D=3D 0x534f494e) { /* r4 is magic NIOS */ @@ -127,14 +128,8 @@
> asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned=
 r6,
>=20
>  	early_init_devtree((void *)dtb_passed);
>=20
> -#ifndef CONFIG_CMDLINE_FORCE
> -	if (cmdline_passed[0])
> -		strlcpy(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
> -#ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
> -	else
> -		strlcpy(boot_command_line, CONFIG_CMDLINE,
> COMMAND_LINE_SIZE);
> -#endif
> -#endif
> +	if (cmdline_passed[0] ||
> IS_ENABLED(CONFIG_NIOS2_CMDLINE_IGNORE_DTB))
> +		cmdline_build(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
>=20
>  	parse_early_param();
>  }
> --
> 2.25.0

