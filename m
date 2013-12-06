From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch: hexagon: kernel: reset.c: use function pointer
 instead of function for pm_power_off and export it
Date: Fri, 6 Dec 2013 12:23:20 -0600
Message-ID: <20131206182320.GE11490@codeaurora.org>
References: <529811A1.3030708@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529811A1.3030708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Nov 29, 2013 at 12:01:37PM +0800, Chen Gang wrote:
> 'pm_power_off' is a function pointer, not a function, so need change
> its type, and also need export it, or can not pass compiling with
> allmodconfig. The related error:
> 
>     MODPOST 2879 modules
>   ERROR: "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko] undefined!
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/kernel/reset.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
