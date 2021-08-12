From: 'Christoph Hellwig' <hch@lst.de>
Subject: Re: add support for the global coherent pool to the dma core
Date: Thu, 12 Aug 2021 15:09:14 +0200
Message-ID: <20210812130914.GA22352@lst.de>
References: <20210712061704.4162464-1-hch@lst.de> <03d501d783c4$1d3f10e0$57bd32a0$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <03d501d783c4$1d3f10e0$57bd32a0$@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: 'Christoph Hellwig' <hch@lst.de>, iommu@lists.linux-foundation.org, 'Russell King' <linux@armlinux.org.uk>, 'Dillon Min' <dillon.minfei@gmail.com>, 'Vladimir Murzin' <vladimir.murzin@arm.com>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, "'Manning, Sid'" <sidneym@quicinc.com>

On Wed, Jul 28, 2021 at 10:20:34AM -0500, Brian Cain wrote:
> > this series adds support for using the global coherent (aka uncached)
> > pool to the generic dma-direct code and then switches arm-nommu and
> > hexagon over to it, together with a bunch of cleanups.
> 
> Christoph,
> 
> Thanks for sending this -- I will take a look and give some feedback soon.

Any chance you'll get to this in the next days?  I'd love to merge this
series for the current merge window with a little time in linux-next.
