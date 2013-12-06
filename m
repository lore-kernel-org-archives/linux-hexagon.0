From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch: hexagon: include: uapi: asm: setup.h add swith
 macro __KERNEL__
Date: Fri, 6 Dec 2013 12:21:34 -0600
Message-ID: <20131206182134.GC11490@codeaurora.org>
References: <528AEFB7.4060301@gmail.com>
 <20131125011938.GB18921@codeaurora.org>
 <5292B845.3010404@gmail.com>
 <5292B8A0.7020409@gmail.com>
 <5294255E.7040105@gmail.com>
 <52958304.4050707@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52958304.4050707@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Nov 27, 2013 at 01:28:36PM +0800, Chen Gang wrote:
> Define dummy '__init' instead of include "linux/init.h" if !__KERNEL__,
> or can not pass checking. The related error (with allmodconfig under
> hexagon):
> 
>     CHECK   include/asm (34 files)
>   usr/include/asm/setup.h:22: included file 'linux/init.h' is not exported
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/include/uapi/asm/setup.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
