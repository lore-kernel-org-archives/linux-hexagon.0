From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 32/36] Hexagon: Comet platform support
Date: Wed, 17 Aug 2011 22:07:03 +0200
Message-ID: <1490448.Ut7YRxkLUk@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163522.852412019@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163522.852412019@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:35:29 Richard Kuo wrote:

> Index: linux-hexagon-kernel/arch/hexagon/configs/comet_defconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-hexagon-kernel/arch/hexagon/configs/comet_defconfig	2011-07-20 15:19:44.785151291 -0500
> @@ -0,0 +1,873 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux/hexagon 2.6.39-rc5 Kernel Configuration
> +# Wed May  4 16:08:56 2011
> +#
> +

You should generate minimal defconfig files using 'make savedefconfig',
instead of listing the full config file as a defconfig.

> Index: linux-hexagon-kernel/arch/hexagon/platform/comet/board.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-hexagon-kernel/arch/hexagon/platform/comet/board.c	2011-07-20 15:19:44.785151291 -0500
> @@ -0,0 +1,195 @@
> +/*
> + * linux/arch/hexagon/platform/comet/board.c

We really don't want to have board files in new architectures any more. If your
hardware is not fully discoverable, you should instead describe it in a device
tree source file, see powerpc, microblaze, and the newer arm platforms.
> +/*
> + * The "machine" io starts at UART1, but UART3 is the one that's signed up
> + * for console.
> + *
> + * If you change UART3, you need to change hexagon_cosimcfg for
> + * software simulation.
> + */
> +
> +#define EBI1_CS_N1_TOP		0x30000000
> +
> +#define SMC911X_PHYS		0x84000000
> +#define AUDIO_PHYS		0xa0700000
> +#define SSBI_PHYS		0xa8100000
> +#define CLK_CTL_PHYS		0xa8600000
> +
> +#define TLMMADDR_GPIO1_BASE		0xa8e00000
> +#define TLMMADDR_GPIO2_BASE		0xa8f00000
> +#define TLMMADDR_GPIO1SHDW1_BASE	0xa9000000
> +#define TLMMADDR_GPIO2SHDW1_BASE	0xa9100000
> +
> +#define MSM_UART1_PHYS		0xA9A00000
> +#define MSM_UART1_SIZE		(1<<12)
> +
> +#define MSM_UART2_PHYS		0xA9B00000
> +#define MSM_UART2_SIZE		(1<<12)
> +
> +#define MSM_UART3_PHYS		0xA9C00000
> +#define MSM_UART3_SIZE		(1<<12)
> +
> +#define ADSP6_SIRC		0xab010000
> +
> +#define MSS_PERIPH_PHYS		0xb8000000

All the register definitions need to go into the device tree file.

> +/* Second-level interrupt registers */
> +/* These all sit on thier own 4K page */
> +/* These are relative to ADSP6_SIRC */
> +#define HEXSS_SIRC0_INT_ENABLE		0x0000
> +#define HEXSS_SIRC0_INT_ENABLE_CLEAR	0x0004
> +#define HEXSS_SIRC0_INT_ENABLE_SET	0x0008
> +#define HEXSS_SIRC0_INT_TYPE		0x000C
> +#define HEXSS_SIRC0_INT_POLARITY	0x0010
> +#define HEXSS_SIRC0_IRQ_STATUS		0x0014
> +#define HEXSS_SIRC0_INT_CLEAR		0x0018
> +#define HEXSS_SIRC0_SOFT_INT		0x001C

This and the rest of this file seems to be driver specific, so move
the definitions into the respective driver files that use them.

There is no need for a global header file.

	Arnd
