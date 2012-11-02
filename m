From: Shuah Khan <shuah.khan@hp.com>
Subject: Re: [PATCH RFT RESEND linux-next] hexagon: dma-mapping: support
 debug_dma_mapping_error
Date: Fri, 02 Nov 2012 10:48:21 -0600
Message-ID: <1351874901.2721.18.camel@lorien2>
References: <1351206731.6851.10.camel@lorien2>
	 <1351266197.4013.3.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1351266197.4013.3.camel@lorien2>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>
Cc: arnd@arndb.de, kyungmin.park@samsung.com, m.szyprowski@samsung.com, linas@codeaurora.org, linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

On Fri, 2012-10-26 at 09:43 -0600, Shuah Khan wrote:
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> ---
>  arch/hexagon/include/asm/dma-mapping.h |    1 +
>  1 file changed, 1 insertion(+)

Would you like se this patch go through arch tree or linux-next? Please
let me know your preference.

-- Shuah
> 
> diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
> index 85e9935..1957c4c 100644
> --- a/arch/hexagon/include/asm/dma-mapping.h
> +++ b/arch/hexagon/include/asm/dma-mapping.h
> @@ -65,6 +65,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  {
>  	struct dma_map_ops *dma_ops = get_dma_ops(dev);
>  
> +	debug_dma_mapping_error(dev, dma_addr);
>  	if (dma_ops->mapping_error)
>  		return dma_ops->mapping_error(dev, dma_addr);
>  

