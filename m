From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH] hexagon: drop selects of bogus Kconfig symbols
Date: Fri, 11 Nov 2011 14:32:17 -0600
Message-ID: <CAHrUA37j5VdreUxb4gE0f4mAOxQDeAxv=dnHB_d=TPs=Fr-ZqA@mail.gmail.com>
References: <1320955667.27598.72.camel@x61.thuisdomein>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ovf2uAUUxZFvBRcIu8TIRL9UvlPkK1J7kYMfdJFVl2M=;
        b=OEzo0aqQJEpiUUm63chpyZ7iRYEsfx8QerEj/TbJ+uR0BCYQGSSZ+XCTjtqzWpwaox
         LK99n+53uvuyK8vG+KPNS6WS/VFzCVL0TaCEILg1rJ375WcWlrObo15gaY5VzG6w94kj
         0Rb418IJS/7brkaY9tHAdIVvrYuFKNTuA1Qic=
In-Reply-To: <1320955667.27598.72.camel@x61.thuisdomein>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

We needed these in the 2.6.3x series, and failed to notice when they we=
nt away.

Acked-by: Linas Vepstas <linasvepstas@gmail.com>

On 10 November 2011 14:07, Paul Bolle <pebolle@tiscali.nl> wrote:
> There are no Kconfig symbols named GENERIC_HARDIRQS_NO__DO_IRQ and
> GENERIC_HARDIRQS_NO_DEPRECATED. The two select statements for these
> symbols are nops. Drop these.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Tested by running "yes "" | make ARCH=3Dhexagon config" before and af=
ter
> applying this patch. Identical .config files were generated.
>
> =C2=A0arch/hexagon/Kconfig | =C2=A0 =C2=A02 --
> =C2=A01 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index 02513c2..f03740e 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -18,8 +18,6 @@ config HEXAGON
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select GENERIC_ATOMIC64
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select HAVE_PERF_EVENTS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select HAVE_GENERIC_HARDIRQS
> - =C2=A0 =C2=A0 =C2=A0 select GENERIC_HARDIRQS_NO__DO_IRQ
> - =C2=A0 =C2=A0 =C2=A0 select GENERIC_HARDIRQS_NO_DEPRECATED
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# GENERIC_ALLOCATOR is used by dma_alloc_c=
oherent()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select GENERIC_ALLOCATOR
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select GENERIC_IRQ_SHOW
> --
> 1.7.4.4
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hexag=
on" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
