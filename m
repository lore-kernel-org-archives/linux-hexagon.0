From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch/hexagon/kernel/dma.c: make function static
Date: Thu, 26 Jan 2012 16:52:22 -0600
Message-ID: <20120126225222.GA11120@codeaurora.org>
References: <1327411896-4532-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327411896-4532-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 24, 2012 at 02:31:36PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> This function is only used in the same file, and the other similar
> functions in this file are also static.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  arch/hexagon/kernel/dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
> index 54891e1..0b49a0a 100644
> --- a/arch/hexagon/kernel/dma.c
> +++ b/arch/hexagon/kernel/dma.c
> @@ -54,7 +54,7 @@ static struct gen_pool *coherent_pool;
>  
>  /* Allocates from a pool of uncached memory that was reserved at boot time */
>  
> -void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
> +static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
>  				 dma_addr_t *dma_addr, gfp_t flag)
>  {
>  	void *ret;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hexagon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks!

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
