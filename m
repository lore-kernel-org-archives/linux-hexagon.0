From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 1/2] atomic: Allow atomic_inc_not_zero to be overridden
Date: Thu, 1 Mar 2012 17:48:24 -0600
Message-ID: <20120301234824.GC2644@codeaurora.org>
References: <20120301180953.0f61576f@kryten>
 <20120301150256.9a7d0b06.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120301150256.9a7d0b06.akpm@linux-foundation.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org, paulus@samba.org, asharma@fb.com, vapier@gentoo.org, eric.dumazet@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Thu, Mar 01, 2012 at 03:02:56PM -0800, Andrew Morton wrote:
> Please merge this via the ppc tree?
> 
> 
> And let's ask the hexagon maintainers to take a look at the definition
> in arch/hexagon/include/asm/atomic.h.  I assume that it can be removed,
> but that might cause problems with files which include asm/atomic.h
> directly.  I have found two such files in non-arch code and have queued
> fixes.  There are no such files in arch/hexagon code, so I think it's
> safe to zap the hexagon definition of atomic_inc_not_zero().

Just tested it; it's safe to zap the Hexagon definition of
atomic_inc_not_zero()...  I'm fine with this going in through some
other tree (still getting mine set up).


Thanks,
Richard Kuo




-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
