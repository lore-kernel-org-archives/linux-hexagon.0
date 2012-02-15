From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: hexagon: signal handling bugs
Date: Wed, 15 Feb 2012 11:45:16 -0600
Message-ID: <20120215174516.GC29780@codeaurora.org>
References: <20110817163457.878854582@codeaurora.org>
 <20110817163521.165013232@codeaurora.org>
 <20120211232740.GM23916@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120211232740.GM23916@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Feb 11, 2012 at 11:27:40PM +0000, Al Viro wrote:
> I don't have any access to hardware *or* cross-toolchain, so all I can do
> here is RTFS and review.  For #2..#5 I would not be afraid to post untested
> patches (they are essentially trivial), but #1 is well beyond my arrogance
> threshold - messing in assembler glue on an architecture I don't know *and*
> can't test...  Sorry.

Thanks for reviewing the code.  Admittedly, it's been a while since I looked
at the signal handling bits, so I will need to review it again and test the
changes where appropriate.  I'll post a patch or something for review when
ready...



Thanks again,
Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
