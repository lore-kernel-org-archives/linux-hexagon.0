From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch: hexagon: include: asm: add generic macro 'mmiowb'
 in "io.h"
Date: Fri, 6 Dec 2013 12:19:20 -0600
Message-ID: <20131206181920.GA11490@codeaurora.org>
References: <528AEFB7.4060301@gmail.com>
 <20131125011938.GB18921@codeaurora.org>
 <52941E8C.7010909@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52941E8C.7010909@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-hexagon@vger.kernel.org

On Tue, Nov 26, 2013 at 12:07:40PM +0800, Chen Gang wrote:
> Need dumy mmiowb(), or can not pass compiling, the related error with
> allmodconfig:
> 
>     CC [M]  drivers/mmc/host/sdhci.o
>   drivers/mmc/host/sdhci.c: In function 'sdhci_request':
>   drivers/mmc/host/sdhci.c:1409:2: error: implicit declaration of function 'mmiowb' [-Werror=implicit-function-declaration]
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/include/asm/io.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
