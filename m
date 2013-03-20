From: rkuo@codeaurora.org
Subject: Re: Bare metal hexagon status
Date: Tue, 19 Mar 2013 17:17:38 -0700
Message-ID: <4f19608dc42a233a141be55ae6f249d2.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: jonpry@gmail.com
Cc: linux-hexagon@vger.kernel.org

On Sat, Mar 16, 2013 at 3:59 PM, Jon Pry <jonpry@gmail.com> wrote:
> The port to bare metal hexagon appears to be fully functional on V3
> processors. All cores are running under SMP. It has not yet been
> tested on V2. So anybody interested in Hexagon programming should be
> able to mess with it now.

Excellent!

I am trying to get some other arch fixes out before you guys manage to run
into them, but unfortunately have been very sidetracked as of late.

Also, I wanted to note that there is a newer version of the cross tools (I
think the last email I saw to the list was 03.66).  The newer one is here:

https://sourcery.mentor.com/GNUToolchain/package10967


> I did have some problems implementing vmwait, which I assume saves
> some power. Perhaps someone here knows how the wait(Rs) instruction
> works. I have no idea what the register argument is doing.  Analysis
> of the Q6 firmware was not clear. Sometimes it uses the thread id,
> sometimes all of ssr, and other times some strange magic numbers. It
> also appears that wait is run with exception bit cleared and
> interrupts enabled. Which seems like a bad idea since vmwait is called
> with interrupts disabled.

It does save some power; the source register Rs isn't used anymore in the
instruction.

A (working) implementation of vmwait would do something like save the
return address, enable the interrupts, then hit the wait.  And then you'd
have to check that you interrupted waitmode on the entry...


Regards,
Richard Kuo


--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
