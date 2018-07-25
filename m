From: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA operation
Date: Tue, 24 Jul 2018 22:29:48 -0500
Message-ID: <20180725032948.GG12771@codeaurora.org>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1532489390;
	bh=IK0gPKQ/dW1M+CNv0yfWCs4m7A4BaTgHR+y2d/zDsb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTxhmuOXhCjBpwxQI/ST++zlJX7ifBnPJCRqqo3T7Q3nr8O2gKRm36Wgec6GObEbq
	QiM6YNbTyz4aqZASMiyneVvRIlMLXhXrxUBjBBwliCL9+ntk88tWOGIN5ny6jeNLjP
	5H2pHJdo0xdEaTjtbHB0FJf7eTce334Lbb9VCeTQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1532489390;
	bh=IK0gPKQ/dW1M+CNv0yfWCs4m7A4BaTgHR+y2d/zDsb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTxhmuOXhCjBpwxQI/ST++zlJX7ifBnPJCRqqo3T7Q3nr8O2gKRm36Wgec6GObEbq
	QiM6YNbTyz4aqZASMiyneVvRIlMLXhXrxUBjBBwliCL9+ntk88tWOGIN5ny6jeNLjP
	5H2pHJdo0xdEaTjtbHB0FJf7eTce334Lbb9VCeTQ=
Content-Disposition: inline
In-Reply-To: <20180719125635.824-2-hch-jcswGhMUV9g@public.gmane.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Jul 19, 2018 at 05:56:33AM -0700, Christoph Hellwig wrote:
> hexagon does all the required cache maintainance at dma map time, and none
> at unmap time.  It thus has to implement sync_single_for_device to match
> the map cace for buffer reuse, but there is no point in doing another
> invalidation in the sync_single_cpu_case, which in terms of cache
> maintainance is equivalent to the unmap case.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/hexagon/kernel/dma.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Patch series looks good.  Definitely appreciate the cleanup.

I can take it through my tree, or if not:

Acked-by: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Thanks!

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
