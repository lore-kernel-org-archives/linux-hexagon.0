From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2] flush_icache_range: Export symbol to fix build errors
Date: Mon, 18 Aug 2014 20:22:02 +0400
Message-ID: <CAMo8BfKshP0KT=D8dWzDfbGSfEpd_SeQPRboGGN9b8B4btRBtQ@mail.gmail.com>
References: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m2zaCsSM44eaAifxWK3Aha+SGjCEfIHeP1NlnJ2nBS4=;
        b=sx8t46PddpBjiovTI+LSrDOARlkLRdOyOtku6h2QoaaieWmbddjy1ncAt5y8U68P7N
         /ttaMR2/skm19UIbl+DdCRbAGyA1WAyp+qRqdhn6/AqsQLJRlrb6iIVZVgIWBu0b1O7j
         q+9pA6YTQj6815P1sTQCFOxgco7VpiEuTHCGGyxxQ6QOQISF6etd8empftMr7VdsHxnR
         CaFpt0ZMeKGOHHFZUZ9jUDR/Us5sQ54SzMaO6u2AzVGWTjAL7jr5JWGwO2J6d/GvuQ8P
         0HHINdGz5oF/E5JtwHJYurVNq28wB59OXmhrEDPdfErhiIjKiE07p17eZ1LIhmdrTWHK
         XLzg==
In-Reply-To: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, Noam Camus <noamc@ezchip.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tony Lu <zlu@tilera.com>, Kirill Tkhai <tkhai@yandex.ru>, open list <linux-kernel@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>

On Mon, Aug 18, 2014 at 7:59 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
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

For xtensa
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
