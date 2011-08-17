From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 27/36] Hexagon: Provide DMA implementation
Date: Wed, 17 Aug 2011 22:01:07 +0200
Message-ID: <16233560.LW8Ali0bj4@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163522.381019304@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163522.381019304@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Wednesday 17 August 2011 11:35:24 Richard Kuo wrote:

> +static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
> +				   unsigned long offset, size_t size,
> +				   enum dma_data_direction dir,
> +				   struct dma_attrs *attrs)
> +{
> +	dma_addr_t bus = page_to_phys(page) + offset;
> +	WARN_ON(size == 0);
> +
> +	if (!check_addr("map_single", dev, bus, size))
> +		return bad_dma_address;
> +
> +	flush_dcache_range(PAGE_OFFSET + bus, PAGE_OFFSET + bus + size);
> +
> +	return bus;
> +}
> +
> +static void hexagon_sync_single_for_cpu(struct device *dev,
> +					dma_addr_t dma_handle, size_t size,
> +					enum dma_data_direction dir)
> +{
> +	mb();
> +}

Why do you need to flush the cache in map_page, but not in sync?
Normally when you have non-coherent DMA, you need to invalidate
the cache in sync_*_foc_cpu and flush it sync_*_for_device.

	Arnd
