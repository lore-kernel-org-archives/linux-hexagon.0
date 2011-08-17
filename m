From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/36] Hexagon: Core arch-specific header files
Date: Wed, 17 Aug 2011 21:19:04 +0200
Message-ID: <1351105.60z76SzR1l@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163520.053182080@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163520.053182080@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Wednesday 17 August 2011 11:34:59 Richard Kuo wrote:

> +#ifndef _ASM_TIMEX_H
> +#define _ASM_TIMEX_H
> +
> +#include <asm-generic/timex.h>
> +#include <asm/timer-regs.h>
> +
> +/*  Using TCX0 as our clock.  */
> +#define CLOCK_TICK_RATE		TCX0_CLK_RATE
> +
> +#endif

CLOCK_TICK_RATE will no longer be there in Linux-3.2, after a patch from
Deepak Saxena. If you rely on it anywhere, change that to use your
TCX0_CLK_RATE directly.

	Arnd
