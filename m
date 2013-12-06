From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: correct type on pgd copy
Date: Fri, 6 Dec 2013 15:15:54 -0600
Message-ID: <20131206211554.GA14311@codeaurora.org>
References: <1386296005-2346-1-git-send-email-imirkin@alum.mit.edu>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386296005-2346-1-git-send-email-imirkin@alum.mit.edu>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: linux-hexagon@vger.kernel.org

On Thu, Dec 05, 2013 at 09:13:25PM -0500, Ilia Mirkin wrote:
> swapper_pg_dir is an array of pgd_t, not pgd_t*. This has no actual
> effect since sizeof(pgd_t) == sizeof(pgd_t*), but unconfuses tools that
> check types.
> 
> Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
> ---
> 
> Looks like I wrote this ~2 years ago, when I was playing around with spatch,
> but forgot to send it out (along with a few other patches which no longer
> applied). This still seems valid though.
> 
>  arch/hexagon/include/asm/pgalloc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks! I'll try to send this out with my next pull request.


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
