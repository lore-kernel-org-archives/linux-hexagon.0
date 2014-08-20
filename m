From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] flush_icache_range: Export symbol to fix build errors
Date: Wed, 20 Aug 2014 16:34:29 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4BBAE9@IN01WEMBXA.internal.synopsys.com>
References: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Pranith Kumar <bobby.prani@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Noam Camus <noamc@ezchip.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tony Lu <zlu@tilera.com>, Kirill Tkhai <tkhai@yandex.ru>, open list <linux-kernel@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>

On Monday 18 August 2014 08:59 AM, Pranith Kumar wrote:
> Fix building errors occuring due to a missing export of flush_icache_range() in
>
> kisskb.ellerman.id.au/kisskb/buildresult/11677809/
>
> ERROR: "flush_icache_range" [drivers/misc/lkdtm.ko] undefined!
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/arc/mm/cache_arc700.c | 1 +
>  arch/hexagon/mm/cache.c    | 1 +
>  arch/sh/mm/cache.c         | 1 +
>  arch/tile/kernel/smp.c     | 1 +
>  arch/xtensa/kernel/smp.c   | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/arch/arc/mm/cache_arc700.c b/arch/arc/mm/cache_arc700.c
> index 4670afc..e88ddbf 100644
> --- a/arch/arc/mm/cache_arc700.c
> +++ b/arch/arc/mm/cache_arc700.c
> @@ -581,6 +581,7 @@ void flush_icache_range(unsigned long kstart, unsigned long kend)
>  		tot_sz -= sz;
>  	}
>  }
> +EXPORT_SYMBOL(flush_icache_range);
 
Acked-by: Vineet Gupta <vgupta@synopsys.com>   # for arch/arc bits

thx,
-Vineet
