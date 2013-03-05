From: rkuo@codeaurora.org
Subject: Re: Serious error in the code
Date: Tue, 5 Mar 2013 11:19:59 -0800
Message-ID: <e4970b507ec53673b77261c392ebbbff.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: cotulla@yandex.ru
Cc: linux-hexagon@vger.kernel.org

On Sat, Mar 2, 2013 at 7:59 AM, <cotulla@yandex.ru> wrote:
> Hello,
> During porting we found a serious error:
> Function
> static inline int __atomic_add_unless(atomic_t *v, int a, int u) is
implemented wrong.
> Hexagon implementation returns 0 or 1, while it _must_ return old value.
linux/atomic.h defines it as:
> static inline int atomic_add_unless(atomic_t *v, int a, int u)
> {
>          return __atomic_add_unless(v, a, u) != u;
> }
> So it's really supposed for __atomic_add_unless return old value, not
0/1
> flag.
> And finally atomic_add_unless returns 0/1 flag by comparing values. I
think developer was confused by atomic_add_unless() description which is
> different from __atomic_add_unless().
> This was a very awful error. . .dunno how it worked before.

You are correct, this was a bug.  We have this fixed locally, but I have
not had a chance to upstream the fix.  I'm actually in the process of
trying to clean up all our local changes for upstreaming.

If you find other stuff or have questions, feel free to post about it.  It
sounds like you've made pretty good progress.


> However this is not the first error in the code - for example
> hexagon_dma_init() is never called outside.

We actually weren't using DMA in the example "platform".   We've been
calling it at board level init, which I think I've seen other
architectures do as well.

But now that you mention it, perhaps a call to it should be placed
somewhere in the initcalls.


Thanks,
Richard Kuo


--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

