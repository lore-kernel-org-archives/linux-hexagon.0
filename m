From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch: hexagon: Kconfig: add HAVE_DMA_ATTR in Kconfig and
 remove "linux/dma-mapping.h" from "asm/dma-mapping.h"
Date: Sun, 24 Nov 2013 19:19:38 -0600
Message-ID: <20131125011938.GB18921@codeaurora.org>
References: <528AEFB7.4060301@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528AEFB7.4060301@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Nov 19, 2013 at 12:57:27PM +0800, Chen Gang wrote:
> When HAS_DMA, and also need use generic implementation, HAVE_DMA_ATTR
> must be enabled, or can not pass compiling with allmodconfig, the
> related error:
> 
>     CC [M]  drivers/ata/libata-core.o
>   drivers/ata/libata-core.c: In function 'ata_sg_clean':
>   drivers/ata/libata-core.c:4598:3: error: implicit declaration of function 'dma_unmap_sg' [-Werror=implicit-function-declaration]
>   drivers/ata/libata-core.c: In function 'ata_sg_setup':
>   drivers/ata/libata-core.c:4708:2: error: implicit declaration of function 'dma_map_sg' [-Werror=implicit-function-declaration]
> 
> "linux/dma-mapping.h" will include "asm/dma-mapping.h", so need remove
> "linux/dma-mapping.h" from "asm/dma-mapping.h",
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
