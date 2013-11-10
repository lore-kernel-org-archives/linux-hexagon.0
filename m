From: rkuo <rkuo@codeaurora.org>
Subject: Re: [Suggestion] are they toolchains' issue?
Date: Sat, 9 Nov 2013 18:28:34 -0600
Message-ID: <20131110002834.GA3879@codeaurora.org>
References: <527396BA.7050906@asianux.com>
 <52739920.4010905@asianux.com>
 <20131101194238.GA4060@codeaurora.org>
 <5274FE49.9000104@asianux.com>
 <5279AFED.3000600@asianux.com>
 <527CAF1A.40907@asianux.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <527CAF1A.40907@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen@asianux.com>
Cc: linux-hexagon@vger.kernel.org

On Fri, Nov 08, 2013 at 05:30:02PM +0800, Chen Gang wrote:
> Hello Maintainers:
> 
> I met an issue for linux next-20131105
> 
> The related error:
> 
>     CC [M]  fs/ubifs/lpt_commit.o
>   fs/ubifs/lpt_commit.c: In function 'next_pnode_to_dirty':
>   fs/ubifs/lpt_commit.c:620:1: internal compiler error: in hwloop_optimize, at config/hexagon/hexagon.c:5796
>   Please submit a full bug report,
>   with preprocessed source if appropriate.
>   See <http://gcc.gnu.org/bugs.html> for instructions.
> 
> The related information:
> 
>   [root@gchenlinux linux-next]# hexagon-linux-gcc -v
>   Using built-in specs.
>   COLLECT_GCC=hexagon-linux-gcc
>   COLLECT_LTO_WRAPPER=/usr/local/libexec/gcc/hexagon-linux/4.6.1/lto-wrapper
>   Target: hexagon-linux
>   Configured with: ../gcc-hexagon-2012.03/configure --without-header --disable-nls --enable-language=c --disable-threads --disable-shared --enable-werror=no target_configargs=enable_vtable_verify=yes --target=hexagon-linux
>   Thread model: single
>   gcc version 4.6.1 (GCC) 
>   [root@gchenlinux linux-next]# hexagon-linux-ld -v
>   GNU ld (GNU Binutils) 2.21.53.20110905
>   [root@gchenlinux linux-next]# hexagon-linux-as -v
>   GNU assembler version 2.21.53 (hexagon-linux) using BFD version (GNU Binutils) 2.21.53.20110905
> 
> Welcome any suggestions or completions.
> 
> Thanks.
> 

That's definitely a bug; I reproduced it over here as well.  I've submitted 
it to the tools team; I will let you know anything else I find.


Thanks for reporting this!

-Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
