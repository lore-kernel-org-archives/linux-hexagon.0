From: Christoph Hellwig <hch@lst.de>
Subject: use the generic dma-noncoherent code for hexagon
Date: Thu, 19 Jul 2018 05:56:32 -0700
Message-ID: <20180719125635.824-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I0gWHMe/CcpRrDZJN18GNjj0gafa/XFni8ideEiKeqQ=; b=PUar4Dfz5ujcgSw6lE3YvttL1
        Cj7xvYBhPE+UBChBKbswXvEHB/4jrikOWlD3QJ/TOvhqopXgMlpnrohdDVBUbK5MD7NdDd7lqQzOe
        iSxiHGWa2TMQ39sIcIouYn9SUJty/REiWppv/3ovMxYiTzEP61c98AVhliRG0BETl+Zt357buxlYj
        wDMoZk6P2rqK2wEB9Qw6df4j+46lvW8VYt5tFusOTIGeJgr2fBIJ1wPqHpnbrf3w6G47O+IhkNSGB
        ivhMBlj743MhKBQ3XBHaodHPvaCgPKdwT6hjAJYNSfyIchp6EEM7Z68eMTbhLDR0eukAOo4vYRt38
    
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Hi Richard,

can you review these patches to switch hexagon to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
