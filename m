From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch: hexagon: include: asm: Kbuild: add generic
 "serial.h" in Kbuild
Date: Fri, 6 Dec 2013 12:20:01 -0600
Message-ID: <20131206182001.GB11490@codeaurora.org>
References: <528AEFB7.4060301@gmail.com>
 <20131125011938.GB18921@codeaurora.org>
 <52941E8C.7010909@gmail.com>
 <52941F07.6010302@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52941F07.6010302@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-hexagon@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On Tue, Nov 26, 2013 at 12:09:43PM +0800, Chen Gang wrote:
> Add "serial.h" in Kbuild, or can not pass compiling with allmodconfig,
> the related error:
> 
>     CC [M]  drivers/staging/speakup/speakup_acntpc.o
>   In file included from drivers/staging/speakup/speakup_acntpc.c:33:0:
>   drivers/staging/speakup/serialio.h:7:24: fatal error: asm/serial.h: No such file or directory
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/include/asm/Kbuild |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
