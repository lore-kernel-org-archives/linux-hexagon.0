From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 25/44] arm: implement ->mapping_error
Date: Thu, 8 Jun 2017 15:43:14 +0100
Message-ID: <20170608144313.GL4902@n2100.armlinux.org.uk>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-26-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0W7TZGQP+bJYGgTUAQ51lY8PEpbyQfuBSdypiDV83TQ=;
        b=D4CSK6wracUSbzKx0d4bkdbs9NsJmLe0ERk3kCzyinEEbr1uFDCT4wfteBzKrYRYkcduHxczWyI8hJwvTKG832HUyV32gjcOhnhXgA8BYKhHBR6AVHxqUASWeQh6FM4VH0TBah21gZmHkpD79ZOr8jAER1ukmFI0LuDKoB/H/7Q=;
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-26-hch@lst.de>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

BOn Thu, Jun 08, 2017 at 03:25:50PM +0200, Christoph Hellwig wrote:
> +static int dmabounce_mapping_error(struct device *dev, dma_addr_t dma_addr)
> +{
> +	if (dev->archdata.dmabounce)
> +		return 0;

I'm not convinced that we need this check here:

        dev->archdata.dmabounce = device_info;
        set_dma_ops(dev, &dmabounce_ops);

There shouldn't be any chance of dev->archdata.dmabounce being NULL if
the dmabounce_ops has been set as the current device DMA ops.  So I
think that test can be killed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
