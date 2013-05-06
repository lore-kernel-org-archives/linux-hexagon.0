From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] HEXAGON: Remove non existent reference to GENERIC_KERNEL_EXECVE
 & GENERIC_KERNEL_THREAD
Date: Mon, 06 May 2013 13:51:57 -0500
Message-ID: <5187FBCD.5040305@codeaurora.org>
References: <1367755108-13169-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1367755108-13169-1-git-send-email-shc_work@mail.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-hexagon@vger.kernel.org

On 05/05/2013 06:58 AM, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>   arch/hexagon/Kconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index b418471..33a9792 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -30,8 +30,6 @@ config HEXAGON
>   	select GENERIC_CLOCKEVENTS_BROADCAST
>   	select MODULES_USE_ELF_RELA
>   	select GENERIC_CPU_DEVICES
> -	select GENERIC_KERNEL_THREAD
> -	select GENERIC_KERNEL_EXECVE
>   	---help---
>   	  Qualcomm Hexagon is a processor architecture designed for high
>   	  performance and low power across a wide variety of applications.

Thanks, I'll take this into my tree and send it out at the next opportunity.


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
