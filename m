From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch: hexagon: kernel: add export symbol function
 __delay()
Date: Sun, 24 Nov 2013 19:19:09 -0600
Message-ID: <20131125011908.GA18921@codeaurora.org>
References: <528AD6B3.1060507@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528AD6B3.1060507@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Nov 19, 2013 at 11:10:43AM +0800, Chen Gang wrote:
> Need add __delay() implementation, or can not pass allmodconfig in
> next-20131118 tree.
> 
> The related error:
> 
>     CC      kernel/locking/spinlock_debug.o
>   kernel/locking/spinlock_debug.c: In function '__spin_lock_debug':
>   kernel/locking/spinlock_debug.c:114:3: error: implicit declaration of function '__delay' [-Werror=implicit-function-declaration]
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/include/asm/delay.h |    1 +
>  arch/hexagon/kernel/time.c       |    9 +++++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)

Thanks again for all the cleanups.  I've tested this and the rest of your
patches on my internal tree and everything checks out.

Also just to let you know, I'm still waiting to hear back on that compiler
bug.



Acked-by: Richard Kuo <rkuo@codeaurora.org>



-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
