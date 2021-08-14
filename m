From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 7/7] hexagon: use the generic global coherent pool
Date: Fri, 13 Aug 2021 20:57:06 -0500
Message-ID: <00a901d790af$b05165c0$10f43140$@codeaurora.org>
References: <20210712061704.4162464-1-hch@lst.de> <20210712061704.4162464-8-hch@lst.de>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628906258; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=C+qezgIh0rDWivT4rvbZT5YmyvAyYRUfpE+phtBAAaw=; b=qGhgmUBTUM1Zelzy2cH2eBX5UwsOGPNaKWkl9Y06iRNTcR/j8lK0W6yqFeGFFpNRN+0E2Mxi
 JHJ/zR92YrDn3bzP7EaE0WNz9fBTLtZbAnTF96YrMg+dq+m+iAWm1mIaPLiG4fgLxmSRZg1o
 T1MGPD7rjj+m/PGy8id86M/zKTU=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <20210712061704.4162464-8-hch@lst.de>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Christoph Hellwig' <hch@lst.de>, iommu@lists.linux-foundation.org, 'Russell King' <linux@armlinux.org.uk>
Cc: 'Dillon Min' <dillon.minfei@gmail.com>, 'Vladimir Murzin' <vladimir.murzin@arm.com>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, "'Manning, Sid'" <sidneym@quicinc.com>



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
...
> Switch hexagon to use the generic code for dma_alloc_coherent from
> a global pre-filled pool.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Brian Cain <bcain@codeaurora.org>

