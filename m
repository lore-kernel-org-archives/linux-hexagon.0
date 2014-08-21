From: Tony Lu <zlu@tilera.com>
Subject: RE: [PATCH v2] flush_icache_range: Export symbol to fix build errors
Date: Thu, 21 Aug 2014 02:40:26 +0000
Message-ID: <BAB94DBB0E89D8409949BC28AC95914C5D78D05E@USMAExch1.tad.internal.tilera.com>
References: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Pranith Kumar <bobby.prani@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Noam Camus <noamc@ezchip.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Kirill Tkhai <tkhai@yandex.ru>, open list <linux-kernel@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>

>-----Original Message-----
>Fix building errors occuring due to a missing export of flush_icache_range()
>in
>
>kisskb.ellerman.id.au/kisskb/buildresult/11677809/
>
>ERROR: "flush_icache_range" [drivers/misc/lkdtm.ko] undefined!
>
>Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>CC: Andrew Morton <akpm@linux-foundation.org>
>---
> arch/arc/mm/cache_arc700.c | 1 +
> arch/hexagon/mm/cache.c    | 1 +
> arch/sh/mm/cache.c         | 1 +
> arch/tile/kernel/smp.c     | 1 +
> arch/xtensa/kernel/smp.c   | 1 +
> 5 files changed, 5 insertions(+)
>

For Tile,

Acked-by: Zhigang Lu <zlu@tilera.com>
