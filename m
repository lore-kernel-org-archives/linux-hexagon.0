From: Christoph Hellwig <hch@lst.de>
Subject: clean up and modularize arch dma_mapping interface V2
Date: Fri, 16 Jun 2017 20:10:15 +0200
Message-ID: <20170616181059.19206-1-hch@lst.de>
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=41KyiF2F2DWxIRbSvuXvB+YeQ1lQaKy72q70xwqtfwY=; b=jvwxIOJNuTIbiA+Bvx9+xA5YP
        hm9SWuBM21AkR4HkfU3qGsSsnbHIfzD3V+zzFV8+SIv5ZTA6diCkZ2LKOBfLLxaIxB4kLw525b/jC
        0C2IxfI/RFHJ7gLyyOQ+PYsYXSN9FfcPQ4mgv0h3uW+WbtIRUCnQpvirj+1kQPJmzbJQfM/062Tjs
        C8fDBhq6FSyB2lWQ1tP8eERVm8ZPnQOCv5VBB4uzczF92Q8g99m1cUumT3Wu77BCi6TqOspLxtfUg
        ZAzIUxQbtw0FbDc5NQLm8fjAS0czt2dhQjE+U+PG2kFwkdCGR3T4k3J/bUw6UfMIBV/hYBfP1kFBD
    
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi all,

for a while we have a generic implementation of the dma mapping routines
that call into per-arch or per-device operations.  But right now there
still are various bits in the interfaces where don't clearly operate
on these ops.  This series tries to clean up a lot of those (but not all
yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
way of signaling failures of the mapping routines from the
implementations to the generic code (and cleans up various drivers that
were incorrectly using it), and gets rid of the ->set_dma_mask routine
in favor of relying on the ->dma_capable method that can be used in
the same way, but which requires less code duplication.

I've got a good number of reviews last time, but a few are still missing.
I'd love to not have to re-spam everyone with this patchbomb, so early
ACKs (or complaints) are welcome.

I plan to create a new dma-mapping tree to collect all this work.
Any volunteers for co-maintainers, especially from the iommu gang?

The whole series is also available in git:

    git://git.infradead.org/users/hch/misc.git dma-map

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map

Changes since V1:
 - remove two lines of code from arm dmabounce
 - a few commit message tweaks
 - lots of ACKs
