From: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH 28/44] sparc: remove arch specific dma_supported implementations
Date: Fri, 9 Jun 2017 00:22:48 +1000
Message-ID: <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-29-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4uonwkxSEgvudvLO+jctb2nX3UCb5m45J7B3TyghA6c=;
        b=ChiJjlMnld43ds+BKnr1dFta8e2/BZXkM6j2w5U2eVSmOPUGuoQ0cJwr0SlAlSw7kW
         y1qR0kk5fmRZ4iWKjYS9EvUy2KMRzXiEUlN0FPn4hC3ak6ueDIHltnnOoZcv0BbMfABd
         5V5SNIatGsI5IkDy6ASar/4YHzYiJwGvQ4pEfiGZ4rV6eJsB02hftaGV0KBmb9RtiWez
         boVrNudJzHHFQg4gFAriEZ68uNPdPAIRNKs+cZ3LEbLrUyxQGBzVxuJDjd7RHtRs07mu
         gJ1DWcJvh6/EHQnrUJDI5Vgb9emO0ysRvWs3eHP4PJzc+lDnyKnR9Yr1XjhO6uW7zhht
         aKHA==
In-Reply-To: <20170608132609.32662-29-hch@lst.de>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Christoph,

On Thu, Jun 8, 2017 at 11:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> Usually dma_supported decisions are done by the dma_map_ops instance.
> Switch sparc to that model by providing a ->dma_supported instance for
> sbus that always returns false, and implementations tailored to the sun4u
> and sun4v cases for sparc64, and leave it unimplemented for PCI on
> sparc32, which means always supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sparc/include/asm/dma-mapping.h |  3 ---
>  arch/sparc/kernel/iommu.c            | 40 +++++++++++++++---------------------
>  arch/sparc/kernel/ioport.c           | 22 ++++++--------------
>  arch/sparc/kernel/pci_sun4v.c        | 17 +++++++++++++++
>  4 files changed, 39 insertions(+), 43 deletions(-)
>
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index dd081d557609..12894f259bea 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -401,6 +401,11 @@ static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>         BUG();
>  }
>
> +static int sbus_dma_supported(struct device *dev, u64 mask)
> +{
> +       return 0;
> +}
> +

I'm guessing there's a few places that have DMA ops but DMA isn't
actually supported. Why not have a common method for this, maybe
"dma_not_supported"?

>  static const struct dma_map_ops sbus_dma_ops = {
>         .alloc                  = sbus_alloc_coherent,
>         .free                   = sbus_free_coherent,
> @@ -410,6 +415,7 @@ static const struct dma_map_ops sbus_dma_ops = {
>         .unmap_sg               = sbus_unmap_sg,
>         .sync_sg_for_cpu        = sbus_sync_sg_for_cpu,
>         .sync_sg_for_device     = sbus_sync_sg_for_device,
> +       .dma_supported          = sbus_dma_supported,
>  };
>
>  static int __init sparc_register_ioport(void)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
