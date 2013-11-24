From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] arch: hexagon: include: asm: add "vga.h" in Kbuild
Date: Sun, 24 Nov 2013 12:23:29 +0800
Message-ID: <52917F41.8060302@gmail.com>
References: <528AF461.4020502@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mHwBh4kVlgiweqMT27iHU5OyaAiEK/+j64wv3VUwGWY=;
        b=krCJblhZosnGFhdKLktTNfe57aOyoCRQ+BZyc5DNFtYqJj/HsOHkXaeAYkDhgEOQlf
         GBrHwiqtvSBMuqh8FSf8RELD8wWv8bipVIP1Q9wXGuPHkl8etG+NKFdvdBINaxQwYyKi
         mRg03ZsG73X9nmeMbcw+XssjlTtrLKkLaJG1y7a78HXda28jj/Ab/XrjmkGrp2XFMwZs
         aFfn0m8R/kgIdJun+wnTiB2oyYp6lpZGV8Qd0zLIjF83lC5v31zXuiz4ErcoNRisRrV6
         l0d/JPSNmfXnvDf6lV9Dm1NwLJkjmV6JqsRBf02SDQ3sinDp3GkFVXZg+EeS/+wRHHPO
         AmyQ==
In-Reply-To: <528AF461.4020502@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello Maintainers:

Please help check it when you have time, thanks.

I changed my mail address -- I have to leave original company, so at
present, I need be as a volunteer to Public Open Source (just like
another quite a few volunteers).

Within this month, I still want to let hexagon pass allmodconfig, hope
we can continue (in the future, at least, as a volunteer, I still plan
to provide 1-3 patches per month to upstream kernel).


BTW: in fact, my original contributions to upstream kernel have given me
much help for finding/changing 'jobs' (but sorry, I can not be sure
whether I can still mainly focus on upstream kernel, next).


:-)

Thanks.

On 11/19/2013 01:17 PM, Chen Gang wrote:
> Need include generic "vga.h", or can not pass compiling with
> allmodconfig, the related error:
> 
>     CC [M]  drivers/gpu/drm/drm_irq.o
>   In file included from include/linux/vgaarb.h:34:0,
>                    from drivers/gpu/drm/drm_irq.c:42:
>   include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory
> 
> Also move "preempt.h" upper to match sort order.
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/include/asm/Kbuild |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
> index 67c3450..424e28e 100644
> --- a/arch/hexagon/include/asm/Kbuild
> +++ b/arch/hexagon/include/asm/Kbuild
> @@ -31,6 +31,7 @@ generic-y += pci.h
>  generic-y += percpu.h
>  generic-y += poll.h
>  generic-y += posix_types.h
> +generic-y += preempt.h
>  generic-y += resource.h
>  generic-y += rwsem.h
>  generic-y += scatterlist.h
> @@ -52,5 +53,5 @@ generic-y += trace_clock.h
>  generic-y += types.h
>  generic-y += ucontext.h
>  generic-y += unaligned.h
> +generic-y += vga.h
>  generic-y += xor.h
> -generic-y += preempt.h
> 


-- 
Chen Gang
