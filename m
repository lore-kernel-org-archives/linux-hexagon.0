From: Christoph Hellwig <hch@lst.de>
Subject: common non-cache coherent direct dma mapping ops v2
Date: Tue, 22 May 2018 14:04:05 +0200
Message-ID: <20180522120430.28709-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+50stOMw/+nrvTGs4EZ04vGJ/yTaM2PB1eUYzmbp2+8=; b=XUwihSx5C4G9C2ntsTZzpbimg
        PJlLXG3CfG90Lq704moNxwh0EDMdguDL7ZB4FOAn6XIxtyAii9CTBkg9xrqJY/PkhCaU6Fi4oVr7p
        AOp4kKWYLAuvB0wi/jtrEx5YjL7J++qbC1JFddCWnMJMHWfI4jkkioUmQyGNQv+hykwFNMYocOUIl
        jm8uZjx8t6+jFLXLNza9EbmEuI5EhXvRhW/5mOHn/obJfRyP1xksg2hNMDsFQWh68sgTF0MGfCu8+
        ehKaKB8Dr4AenH/NATFLJrGJ3/EsegC9ioNVHA/YdoG5jO+XRPSa1IXoft9Rc+f5b6wjTwFm2xu6Z
    
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Hi all,

this series continues consolidating the dma-mapping code, with a focus
on architectures that do not (always) provide cache coherence for DMA.
Three architectures (arm, mips and powerpc) are still left to be
converted later due to complexity of their dma ops selection.

The dma-noncoherent ops calls the dma-direct ops for the actual
translation of streaming mappins and allow the architecture to provide
any cache flushing required for cpu to device and/or device to cpu
ownership transfers.  The dma coherent allocator is for now still left
entirely to architecture supplied implementations due the amount of
variations.  Hopefully we can do some consolidation for them later on
as well.

A lot of architectures are currently doing very questionable things
in their dma mapping routines, which are documented in the changelogs
for each patch.  Please review them very careful and correct me on
incorrect assumptions.

Because this series sits on top of three previously submitted series
a git tree might be useful to actually test it.  It is provided here:

    git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent.2

Changes since v1:
 - dropped the already merged generic, arc and c6x patches
   (with the map_single offset fix from Alexey Brodkin)
 - split various changes into smaller patches
 - dropped the arm-nommu changes for now
 - fixed a typo

Changes since RFC:
 - fix a typo accidentally disabling the device to cpu transfer sync
 - fixed a few compile failures
