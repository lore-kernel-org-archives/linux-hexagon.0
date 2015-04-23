From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] Revert "Hexagon: fix signal.c compile error"
Date: Thu, 23 Apr 2015 15:40:36 -0500
Message-ID: <20150423204036.GA5404@codeaurora.org>
References: <1429752484-14499-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429752484-14499-1-git-send-email-vapier@gentoo.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-hexagon@vger.kernel.org

On Wed, Apr 22, 2015 at 09:28:04PM -0400, Mike Frysinger wrote:
> This reverts commit f3f601c1d2728f02544cfd143eaa82e5398b3e9b.
> 
> UAPI headers cannot use "uapi/" in their paths by design -- when they're
> installed, they do not have the uapi/ prefix.  Otherwise doing so breaks
> userland badly.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  arch/hexagon/include/uapi/asm/signal.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/hexagon/include/uapi/asm/signal.h b/arch/hexagon/include/uapi/asm/signal.h
> index 98106e5..24b9988 100644
> --- a/arch/hexagon/include/uapi/asm/signal.h
> +++ b/arch/hexagon/include/uapi/asm/signal.h
> @@ -19,8 +19,6 @@
>  #ifndef _ASM_SIGNAL_H
>  #define _ASM_SIGNAL_H
>  
> -#include <uapi/asm/registers.h>
> -
>  extern unsigned long __rt_sigtramp_template[2];
>  
>  void do_signal(struct pt_regs *regs);
> -- 
> 2.3.5
> 

I'll need to actually fix the thing the original commit was trying to fix,
but I can follow up with another patch.

Thanks!

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
