From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 31/44] hexagon: remove arch-specific dma_supported
 implementation
Date: Thu, 15 Jun 2017 19:20:16 -0500
Message-ID: <20170616002016.GB7343@codeaurora.org>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-32-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572425;
        bh=WuWNFHi7hiU/mdKf44MyuHbyiyUY4D4v3n20Cfm5WkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ba4FOqmZ/hC/H8HI98uazPzyRCQ4s6X38Qo9MEnuBr+7y+PgfyLwP1rgDh7M3iin+
         I+Uiv+lmUW+Yb8pTXO4bnP08TI3HiLH9/Kwkj0Oih9LMRHmL8EnZnJ77xPKbQ875bt
         EDq8+IuFTzIhQBs4D/pD9PA1a9Owy3Fs3Ej+/Hv8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572424;
        bh=WuWNFHi7hiU/mdKf44MyuHbyiyUY4D4v3n20Cfm5WkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W58BUEKOpgU8/+q8N/KlcUlUhM4IAF64VQYo9+a+UVbGcK9HluQdDFvSAEVd9ROJf
         XuGsuw4XObEfaMUAY3Aqtr9IoIqIiUcqA9emQI+jHSPxQdQ4L7ebwX/D3OH9zRZSfJ
         zLgAVgnn53cjVMijd9Sxi0oKZbQC55rcddacMJ0U=
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-32-hch@lst.de>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 08, 2017 at 03:25:56PM +0200, Christoph Hellwig wrote:
> This implementation is simply bogus - hexagon only has a simple
> direct mapped DMA implementation and thus doesn't care about the
> address.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/dma-mapping.h | 2 --
>  arch/hexagon/kernel/dma.c              | 9 ---------
>  2 files changed, 11 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
