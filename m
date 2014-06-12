From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 4/6] update reference, kerneltrap.org no longer works
Date: Thu, 12 Jun 2014 11:06:13 -0500
Message-ID: <20140612160613.GA18376@codeaurora.org>
References: <1402329327-6766-1-git-send-email-bobby.prani@gmail.com>
 <1402329327-6766-4-git-send-email-bobby.prani@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402329327-6766-4-git-send-email-bobby.prani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: trivial@kernel.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Jun 09, 2014 at 11:55:24AM -0400, Pranith Kumar wrote:
> kerneltrap.org no longer works, update to a working reference
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/hexagon/include/asm/cache.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/include/asm/cache.h b/arch/hexagon/include/asm/cache.h
> index f4ca594..2635117 100644
> --- a/arch/hexagon/include/asm/cache.h
> +++ b/arch/hexagon/include/asm/cache.h
> @@ -28,7 +28,7 @@
>  #define __cacheline_aligned	__aligned(L1_CACHE_BYTES)
>  #define ____cacheline_aligned	__aligned(L1_CACHE_BYTES)
>  
> -/* See http://kerneltrap.org/node/15100  */
> +/* See http://lwn.net/Articles/262554/ */
>  #define __read_mostly
>  
>  #endif
> -- 
> 1.9.1
> 


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
