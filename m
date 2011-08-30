From: Richard Kuo <rkuo@codeaurora.org>
Subject: [patch v2 00/35] Hexagon: Add support for Qualcomm Hexagon architecture
Date: Tue, 30 Aug 2011 14:07:29 -0500
Message-ID: <20110830190729.923334292@codeaurora.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

This is the second version of the patchset to the Linux kernel to support
the Qualcomm Hexagon architecture.  These patches have been organized like
the last time, in a somewhat logically grouped fashion.

A summary of changes from the last patchset:

* use Kbuild method for strictly asm-generic headers
* clean up dma sync and implement clean/invalidate
* bitops fl*/ff* cleanup
* added inline assembly version of atomic_add_unless
* removed deprecated syscalls/defines
* call __vmyield for cpu_relax and fix cpu_idle
* clean up thread_info; use arch allocator to allow kernel stack sizes
  smaller than page size
* implement read_timer_counter
* changed checksum to pull non-asm functions from generic code
* delete module functions which already have generic equivalents
* cleaned up IO routines
* reduced comet_defconfig
* remove ugly platform code

These patches are available on Code Aurora as well as git:

https://www.codeaurora.org/patches/quic/hlk/hexagon-linux-20110830.tar.gz

git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon.git hexagon

Thanks to everyone for their comments/feedback!  If I missed anything
or there's something else that needs cleanup, please let me know.


-Richard Kuo

--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
