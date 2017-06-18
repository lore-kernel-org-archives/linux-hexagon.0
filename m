From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
Date: Sun, 18 Jun 2017 00:09:25 -0700
Message-ID: <20170618070925.GA18526@infradead.org>
References: <20170616181059.19206-1-hch@lst.de>
 <20170616181059.19206-4-hch@lst.de>
 <CAKgT0UdxrimWrxNVsLMQ9G6ABBJZwfWHTcP18qqd4rT0Fa-KWg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GLJ9MWRa5iSFHDHgMeqPS5qC6lxGLHkduureC37J84s=; b=o3WSYscRu94yDznMX81B/IkMn
        xNC30LRAlJGAuSUjIrTh1p9lupshPvLpxc/KSRQ4LX5WcGJVhpau5xThZK3lMRR66flbZ8T/j3AFV
        ka2Ujp4OMbzTPKLAjVkmO8AbZ5+rRL8FmVJ5fnattTMwlFVPFbUt3hU95ShDmG9TNWyCU4TWW29V8
        jEBpNwmqn7xjQ3jHp5mAKJK0KXVQKWAVQO+2l2DACf2jMITDi9KHMbU4RGoUyaXmUgU/VJFvTCmbZ
        JMmK5qVOx6/wDov94oruoTY2kb4lh816lNActDx4BkwU9SF0KbaYKwYqg3rFSxm7w4hgiHH6CKGkA
    
Content-Disposition: inline
In-Reply-To: <CAKgT0UdxrimWrxNVsLMQ9G6ABBJZwfWHTcP18qqd4rT0Fa-KWg@mail.gmail.com>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, the arch/x86 maintainers <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 16, 2017 at 01:40:24PM -0700, Alexander Duyck wrote:
> dma_unmap_page on dest_dma if "op == IOAT_OP_XOR"? Odds are it is what
> the compiler is already generating and will save a few lines of code
> so what you end up with is something like:

Honestly wanted to touch the code as little as possible :)  If we want
to make it prettier and more readable it needs to be refactored.

If you're interested I can take a stab at that, but I'd like to keep
it out of this already giant series.
