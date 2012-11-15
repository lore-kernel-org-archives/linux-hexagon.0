From: Shuah Khan <shuah.khan@hp.com>
Subject: Re: [PATCH RFT RESEND linux-next] hexagon: dma-mapping: support
 debug_dma_mapping_error
Date: Thu, 15 Nov 2012 10:57:29 -0700
Message-ID: <1353002249.2532.36.camel@lorien2>
References: <1351206731.6851.10.camel@lorien2>
	 <1351266197.4013.3.camel@lorien2> <1351874901.2721.18.camel@lorien2>
	 <20121105010859.GA20521@codeaurora.org>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20121105010859.GA20521@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>, m.szyprowski@samsung.com
Cc: Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de, kyungmin.park@samsung.com, linas@codeaurora.org, linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

On Sun, 2012-11-04 at 19:08 -0600, Richard Kuo wrote:
> On Fri, Nov 02, 2012 at 10:48:21AM -0600, Shuah Khan wrote:
> > On Fri, 2012-10-26 at 09:43 -0600, Shuah Khan wrote:
> > > Add support for debug_dma_mapping_error() call to avoid warning from
> > > debug_dma_unmap() interface when it checks for mapping error checked
> > > status. Without this patch, device driver failed to check map error
> > > warning is generated.
> > > 
> > > Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> > > ---
> > >  arch/hexagon/include/asm/dma-mapping.h |    1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Would you like se this patch go through arch tree or linux-next? Please
> > let me know your preference.
> > 
> > -- Shuah
> > > 
> > > diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
> > > index 85e9935..1957c4c 100644
> > > --- a/arch/hexagon/include/asm/dma-mapping.h
> > > +++ b/arch/hexagon/include/asm/dma-mapping.h
> > > @@ -65,6 +65,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> > >  {
> > >  	struct dma_map_ops *dma_ops = get_dma_ops(dev);
> > >  
> > > +	debug_dma_mapping_error(dev, dma_addr);
> > >  	if (dma_ops->mapping_error)
> > >  		return dma_ops->mapping_error(dev, dma_addr);
> > >  
> > 
> > 
> 
> This looks fine; I'm OK with this going through linux-next.  Thanks!
> 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 

Marek,

This one is for hexagon to go through your tree with the other arch
patches for debug_dma_mapping_error().

Thanks,
-- Shuah

