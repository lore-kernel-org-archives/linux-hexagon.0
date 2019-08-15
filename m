From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] hexagon: drop empty and unused free_initrd_mem
Date: Thu, 15 Aug 2019 15:27:28 +0200
Message-ID: <20190815132728.GB12036@lst.de>
References: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Richard Kuo <rkuo@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:35:33AM +0300, Mike Rapoport wrote:
> hexagon never reserves or initializes initrd and the only mention of it is
> the empty free_initrd_mem() function.
> 
> As we have a generic implementation of free_initrd_mem(), there is no need
> to define an empty stub for the hexagon implementation and it can be
> dropped.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
