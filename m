From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: kernel: kgdb: include related header for pass
 compiling.
Date: Sun, 3 Nov 2013 19:15:28 -0600
Message-ID: <20131104011528.GC4060@codeaurora.org>
References: <52739669.9000509@asianux.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52739669.9000509@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen@asianux.com>
Cc: linux-hexagon@vger.kernel.org

On Fri, Nov 01, 2013 at 07:54:17PM +0800, Chen Gang wrote:
> Need include related headers for pass compiling, the related error
> (with allmodconfig for v4):
> 
>     CC      arch/hexagon/kernel/kgdb.o
>   arch/hexagon/kernel/kgdb.c:30: error: invalid use of undefined type 'struct pt_regs'
>   arch/hexagon/kernel/kgdb.c:31: error: invalid use of undefined type 'struct pt_regs'
>   ...
>   arch/hexagon/kernel/kgdb.c:220: error: implicit declaration of function 'local_irq_save'
>   arch/hexagon/kernel/kgdb.c:222: error: implicit declaration of function 'local_irq_restore'
>   ...
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/hexagon/kernel/kgdb.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 

Thanks for the cleanup.  I can take these patches into my tree for my next
push, or they can go in one of the other tree.  In that case,

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
