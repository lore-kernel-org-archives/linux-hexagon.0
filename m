From: Richard Kuo <rkuo@codeaurora.org>
Subject: [patch 00/36] Hexagon: Add support for Qualcomm Hexagon architecture
Date: Wed, 17 Aug 2011 11:34:57 -0500
Message-ID: <20110817163457.878854582@codeaurora.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

The following patch set is intended to add support for the Qualcomm Hexagon
architecture to the Linux kernel.

The Hexagon architecture is designed to deliver performance with low power
over a variety of applications.  It has features such as multithreading,
privilege levels, VLIW, and instructions geared toward efficient signal
processing.  The port of Linux for Hexagon runs under a hypervisor layer.

I realize we are not currently in a merge window, but I felt it would be best
to go ahead and send it out so that the community gets an ample chance to
review it.  This is a very large patch set, but we've tried to break it up
into functional pieces to make review easier.

These changes are available in patch form on the Code Aurora Forum:

https://www.codeaurora.org/patches/quic/hlk/hexagon-linux-20110817.tar.gz

and will also be available via git:

git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon.git hexagon

Any feedback will be greatly appreciated.

Thanks,
Richard Kuo


Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
