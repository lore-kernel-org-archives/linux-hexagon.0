From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] dma-mapping: consolidate dma_set_mask
Date: Thu, 13 Aug 2015 16:25:05 +0100
Message-ID: <20150813152505.GR7557@n2100.arm.linux.org.uk>
References: <1439478248-15183-1-git-send-email-hch@lst.de>
 <1439478248-15183-6-git-send-email-hch@lst.de>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
	h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=gVvLgJVQfoVy0/kUxBMzw0XYzsR/Eg0lBuCSlOC2V48=;
	b=Xoevkfq4czJgNzx5f9RtUS3gwuLI3JTFz7I9o3mg7AZc0r/iN5jfx3boks2fsE/QGRGBqkjTgUpBhKU1CcQU+8jjSK6Rd1FV3m+Pglmb9aVFosZWYWuM+K3TVwduCTaoit4buDU7lvMhgRq+Z7OqL0vB/nrjC+VMGRkico/zrk4=;
Content-Disposition: inline
In-Reply-To: <1439478248-15183-6-git-send-email-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu, jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn, x86@kernel.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 13, 2015 at 05:04:08PM +0200, Christoph Hellwig wrote:
> diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
> index 1143c4d..260f52a 100644
> --- a/arch/arm/common/dmabounce.c
> +++ b/arch/arm/common/dmabounce.c
> @@ -440,14 +440,6 @@ static void dmabounce_sync_for_device(struct device *dev,
>  	arm_dma_ops.sync_single_for_device(dev, handle, size, dir);
>  }
>  
> -static int dmabounce_set_mask(struct device *dev, u64 dma_mask)
> -{
> -	if (dev->archdata.dmabounce)
> -		return 0;
> -
> -	return arm_dma_ops.set_dma_mask(dev, dma_mask);

Are you sure about this?  A user of dmabounce gets to request any mask
with the original code (even though it was never written back... which
is a separate bug.)  After this, it seems that this will get limited
by the dma_supported() check.  As this old code is about bouncing any
buffer into DMA-able memory, it doesn't care about the DMA mask.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
