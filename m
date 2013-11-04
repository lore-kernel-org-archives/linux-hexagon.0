From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: kernel: remove useless variables 'dn', 'r' and
 'err' in time_init_deferred() in "time.c"
Date: Sun, 3 Nov 2013 19:13:55 -0600
Message-ID: <20131104011355.GB4060@codeaurora.org>
References: <52738B84.9080704@asianux.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52738B84.9080704@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen@asianux.com>
Cc: linux-hexagon@vger.kernel.org

On Fri, Nov 01, 2013 at 07:07:48PM +0800, Chen Gang wrote:
> Remove them, since they are useless. The related warnings (with
> allmodconfig for v4):
> 
>     CC      arch/hexagon/kernel/time.o
>   arch/hexagon/kernel/time.c: In function 'time_init_deferred':
>   arch/hexagon/kernel/time.c:196: warning: unused variable 'err'
>   arch/hexagon/kernel/time.c:195: warning: unused variable 'r'
>   arch/hexagon/kernel/time.c:194: warning: unused variable 'dn'
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/hexagon/kernel/time.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
