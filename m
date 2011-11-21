From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH] Remove unneeded include of version.h from arch/hexagon/include/asm/spinlock_types.h
Date: Mon, 21 Nov 2011 10:54:00 -0600
Message-ID: <CAHrUA374rf6rsq4xMLrxRrFsdZvfed3KCUHcYf+b=21LPYVkDQ@mail.gmail.com>
References: <alpine.LNX.2.00.1111202157170.17195@swampdragon.chaosbits.net>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=65F5b8r9+1hQpn0r34rVrNdUrkMJTpUv3corRuKdiAc=;
        b=R7e3tT/cwT2nwrRvxzCUpvtAYUdZUepBYgTaIRbrru7kjioixAglBaSuo/AfLcPxB/
         iOAX1QFSNiDJjD9Hd2G3u3MOFSQYYewSQveI9DELRLFnymmR3yNhkTfhe5woAoLqvg5A
         Nwo0SE+eDcYOp2J1AJGHZqMWbcYu5WL73QOFc=
In-Reply-To: <alpine.LNX.2.00.1111202157170.17195@swampdragon.chaosbits.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

Acked-by: Linas Vepstas <linasvepstas@gmail.com>

On 20 November 2011 14:59, Jesper Juhl <jj@chaosbits.net> wrote:
> "make versioncheck" points out that arch/hexagon/include/asm/spinlock=
_types.h
> does not need to include version.h .
> A quick look at the file seems to confirm its findings, so here's a p=
atch that
> removes the include.
>
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
> =C2=A0arch/hexagon/include/asm/spinlock_types.h | =C2=A0 =C2=A02 --
> =C2=A01 files changed, 0 insertions(+), 2 deletions(-)
>
> =C2=A0Please note: I've not done any compile tests or other tests to =
confirm
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0this patch since I ha=
ve no way to build stuff for this
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0architecture, so plea=
se review carefully before applying.
>
> diff --git a/arch/hexagon/include/asm/spinlock_types.h b/arch/hexagon=
/include/asm/spinlock_types.h
> index 5e937af..99b5a75 100644
> --- a/arch/hexagon/include/asm/spinlock_types.h
> +++ b/arch/hexagon/include/asm/spinlock_types.h
> @@ -21,8 +21,6 @@
> =C2=A0#ifndef _ASM_SPINLOCK_TYPES_H
> =C2=A0#define _ASM_SPINLOCK_TYPES_H
>
> -#include <linux/version.h>
> -
> =C2=A0#ifndef __LINUX_SPINLOCK_TYPES_H
> =C2=A0# error "please don't include this file directly"
> =C2=A0#endif
> --
> 1.7.7.3
>
>
> --
> Jesper Juhl <jj@chaosbits.net> =C2=A0 =C2=A0 =C2=A0 http://www.chaosb=
its.net/
> Don't top-post http://www.catb.org/jargon/html/T/top-post.html
> Plain text mails only, please.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hexag=
on" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
