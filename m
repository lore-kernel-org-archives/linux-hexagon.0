From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: add support for the global coherent pool to the dma core
Date: Wed, 28 Jul 2021 10:20:34 -0500
Message-ID: <03d501d783c4$1d3f10e0$57bd32a0$@codeaurora.org>
References: <20210712061704.4162464-1-hch@lst.de>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627485655; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=NMBA6eMZ2++sBypZUxc6pdznV/MW5syE3FBstf0UH5I=; b=c8QNd+dWyXTnxvW4I+wgldCCEjqgVWgDMj5xN0xWmvy6aAOhkgo1IibcwKfBDO3Q5gTahp26
 K/Kpm3nA2NwiLOrSluZry7jYj1PTrPEceHavV5SrZXoKGjzmWx+Yl1h0ZulFJ4xUWxGn4pso
 a0sIlCbR0w7yM3Zto3U74iZAxQI=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Christoph Hellwig' <hch@lst.de>, iommu@lists.linux-foundation.org, 'Russell King' <linux@armlinux.org.uk>
Cc: 'Dillon Min' <dillon.minfei@gmail.com>, 'Vladimir Murzin' <vladimir.murzin@arm.com>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, "'Manning, Sid'" <sidneym@quicinc.com>



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, July 12, 2021 1:17 AM
> To: iommu@lists.linux-foundation.org; Russell King
<linux@armlinux.org.uk>;
> Brian Cain <bcain@codeaurora.org>
> Cc: Dillon Min <dillon.minfei@gmail.com>; Vladimir Murzin
> <vladimir.murzin@arm.com>; linux-arm-kernel@lists.infradead.org; linux-
> hexagon@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: add support for the global coherent pool to the dma core
> 
> Hi all,
> 
> this series adds support for using the global coherent (aka uncached)
> pool to the generic dma-direct code and then switches arm-nommu and
> hexagon over to it, together with a bunch of cleanups.

Christoph,

Thanks for sending this -- I will take a look and give some feedback soon.

> Diffstat:
>  arch/arm/Kconfig                |    5 -
>  arch/arm/mm/dma-mapping-nommu.c |  173
+--------------------------------------
> -
>  arch/hexagon/Kconfig            |    1
>  arch/hexagon/kernel/dma.c       |   57 ++-----------
>  include/linux/dma-map-ops.h     |   18 ++--
>  kernel/dma/Kconfig              |    4
>  kernel/dma/coherent.c           |  159
+++++++++++++++++-------------------
>  kernel/dma/direct.c             |   15 +++
>  8 files changed, 124 insertions(+), 308 deletions(-)

