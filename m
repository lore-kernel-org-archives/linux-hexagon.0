From: rkuo <rkuo@codeaurora.org>
Subject: Re: [Suggestion] are they toolchains' issue?
Date: Fri, 1 Nov 2013 14:42:38 -0500
Message-ID: <20131101194238.GA4060@codeaurora.org>
References: <527396BA.7050906@asianux.com>
 <52739920.4010905@asianux.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52739920.4010905@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen@asianux.com>
Cc: linux-hexagon@vger.kernel.org

On Fri, Nov 01, 2013 at 08:05:52PM +0800, Chen Gang wrote:
> Hello Maintainers:
> 
> When compiling with allmodconfig for v4, an error occurs:
> 
>     CC      kernel/fork.o
>   /tmp/ccTx69dj.s: Assembler messages:
>   /tmp/ccTx69dj.s:7853: Error: invalid instruction `if (tstbit(r4.new,r0))jump:nt .L242'
> 
> Also when with allmodconfig (default for v2), it will cause error:
> 
>   /usr/local/bin/hexagon-ld: Relocatable linking with relocations from format elf32-littlehexagon (init/.tmp_main.o) to format elf32-littlehexagon (init/main.o) is not supported
> 
> Also when with defconfig, it will cause error:
> 
>     LD      init/mounts.o
>   /usr/local/bin/hexagon-ld: Relocatable linking with relocations from format elf32-littlehexagon (init/do_mounts.o) to format elf32-littlehexagon (init/mounts.o) is not supported
> 

Hi Chen,

Thanks for checking all these.  There are newer Hexagon tools available
here:

https://sourcery.mentor.com/GNUToolchain/release2568?cmpid=7108

You might want to try those out.  The tool prefix is hexagon-linux-, but
aside from that, a v4 defconfig on 3.12-rc7 compiled for me.

'allmodconfig' does not appear to compile due to DMA related issues...

Anyways, would you mind giving the newer tools a try?


Thanks,
Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
