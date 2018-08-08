From: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA operation
Date: Tue, 7 Aug 2018 19:19:27 -0500
Message-ID: <20180808001927.GA20752@codeaurora.org>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de>
	<20180725032948.GG12771@codeaurora.org>
	<20180725043927.GA10827@lst.de> <20180731152229.GA956@lst.de>
	<20180807070136.GA32634@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1533687570;
	bh=F1B+uqwTK57+pAEjaaErwGGtUQvzb8P2PoBQko3xaes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFipu7ZQ7K0b75YfZj6FN/llNZ5Q4aTPx2y3FMsx/2irxdRRopWqw0s9sR+E//hhy
	wHxeD4ZIgVWlTKirnnbRJx6VMxlgwSnJf7/sAXvjilp0V8v+n7QJsyNBszJzNQn0Bk
	T79dO9jirx6lRWDLwJxW0ok+muokwBmv3oYQPN+w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1533687569;
	bh=F1B+uqwTK57+pAEjaaErwGGtUQvzb8P2PoBQko3xaes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9/b5O9Ch449pdgSIDMpSB35ivBNhk2f4RBYOiERxxPOHWwSgzdyZFR7//uU63vo4
	4n3TNnsb9qzaYyw4Ach45cBISsISzYu8BrbFg2z7ynIkJRxeYfQttDgAyBdZMXx4H+
	GVuc6R2Iq8YsPFUeIVjvIfYsz/JneOkrwJLwy/CE=
Content-Disposition: inline
In-Reply-To: <20180807070136.GA32634-jcswGhMUV9g@public.gmane.org>
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

On Tue, Aug 07, 2018 at 09:01:36AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 05:22:29PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 25, 2018 at 06:39:27AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 24, 2018 at 10:29:48PM -0500, Richard Kuo wrote:
> > > > Patch series looks good.  Definitely appreciate the cleanup.
> > > > 
> > > > I can take it through my tree, or if not:
> > > > 
> > > > Acked-by: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > 
> > > Please take it through your tree, thanks!
> > 
> > I haven't seen it in linux-next yet, do you still plan to take it?
> > 
> > Otherwise I'll merge it in the dma-mapping tree.
> 
> Given that I haven't seen this in linux-next nor haven't heard back
> from you I assume you are on your well deserved summer vacation.
> 
> If I don't hear back until tomorrow night I'll merge it through the
> dma-mapping tree, so that I have it in linux-next before heading out
> to my summer vacation.

I am here, and I have the patch queued up but it's waiting for approval
before I get to push it out through my tree.

That said, I am perfectly fine with this going through a different tree
if expedience is needed.


Thanks,
Richard Kuo


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
