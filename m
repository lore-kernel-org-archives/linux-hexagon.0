From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] hexagon: remove CONFIG_EXPERIMENTAL from defconfigs
Date: Fri, 15 Jan 2021 09:29:47 -0600
Message-ID: <003801d6eb53$430a26c0$c91e7440$@codeaurora.org>
References: <20210115010011.29483-1-rdunlap@infradead.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610724622; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=oA7RZAvzLPHcI3sWTvYYs4e/HB09ZcFYEQzi+A912XA=; b=af75JqwqPPiMwAicGL3WfI3S9KIIdDLJCYhoVtXyCRRafZ/8VFTWhK7Hs5VQIZsWxwYZsgwc
 yzjgvUwq+UK6QrsA0F2iQS0wuWS/SpPLMcsuULoutNNRXH02fAvC8Vs0M9OM4jBc6Oq+R4NO
 AoFdloLrh3EdKc4TweToApsBGYc=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <20210115010011.29483-1-rdunlap@infradead.org>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Randy Dunlap' <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: 'Kees Cook' <keescook@chromium.org>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-hexagon@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
...
> Since CONFIG_EXPERIMENTAL was removed in 2013, go ahead and drop it
> from any defconfig files.

Acked-by: Brian Cain <bcain@codeaurora.org>

> Fixes: 3d374d09f16f ("final removal of CONFIG_EXPERIMENTAL")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/hexagon/configs/comet_defconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-next-20210114.orig/arch/hexagon/configs/comet_defconfig
> +++ linux-next-20210114/arch/hexagon/configs/comet_defconfig
> @@ -1,7 +1,6 @@
>  CONFIG_SMP=y
>  CONFIG_DEFAULT_MMAP_MIN_ADDR=0
>  CONFIG_HZ_100=y
> -CONFIG_EXPERIMENTAL=y
>  CONFIG_CROSS_COMPILE="hexagon-"
>  CONFIG_LOCALVERSION="-smp"
>  # CONFIG_LOCALVERSION_AUTO is not set

