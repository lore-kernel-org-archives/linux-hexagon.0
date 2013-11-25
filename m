From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch: hexagon: include: asm: add "vga.h" in Kbuild
Date: Sun, 24 Nov 2013 19:20:00 -0600
Message-ID: <20131125012000.GC18921@codeaurora.org>
References: <528AF461.4020502@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528AF461.4020502@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Nov 19, 2013 at 01:17:21PM +0800, Chen Gang wrote:
> Need include generic "vga.h", or can not pass compiling with
> allmodconfig, the related error:
> 
>     CC [M]  drivers/gpu/drm/drm_irq.o
>   In file included from include/linux/vgaarb.h:34:0,
>                    from drivers/gpu/drm/drm_irq.c:42:
>   include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory
> 
> Also move "preempt.h" upper to match sort order.
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/include/asm/Kbuild |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
