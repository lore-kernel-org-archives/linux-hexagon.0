From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v5 26/44] hexagon: dma-mapping: Use unsigned long for
 dma_attrs
Date: Thu, 30 Jun 2016 19:13:19 -0500
Message-ID: <20160701001319.GA26190@codeaurora.org>
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
 <1467275171-6298-1-git-send-email-k.kozlowski@samsung.com>
 <1467275171-6298-26-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467275171-6298-26-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, hch@infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-hexagon@vger.kernel.org

On Thu, Jun 30, 2016 at 10:25:53AM +0200, Krzysztof Kozlowski wrote:
> Split out subsystem specific changes for easier reviews. This will be
> squashed with main commit.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/hexagon/include/asm/dma-mapping.h | 1 -
>  arch/hexagon/kernel/dma.c              | 8 ++++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 

For Hexagon:

Acked-By: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
