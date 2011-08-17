From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 08/36] Hexagon: Add delay functions
Date: Wed, 17 Aug 2011 21:38:35 +0200
Message-ID: <101063053.zZmSHVMM0X@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163520.622136231@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163520.622136231@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:35:05 Richard Kuo wrote:
> +#include <asm/param.h>
> +
> +extern void __udelay(unsigned long usecs);
> +
> +#define udelay(usecs) __udelay((usecs))
> +
> +extern void __delay(unsigned long loops);

If you have any kind of reliable timer register, it's better
to poll that than to rely on a delay loop that is especially
inaccurate when running under a hypervisor.

That also speeds up boot time because you no longer need to
calibrate the delay loop.

	Arnd
