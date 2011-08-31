From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 00/35] Hexagon: Add support for Qualcomm Hexagon architecture
Date: Wed, 31 Aug 2011 17:08:08 +0200
Message-ID: <201108311708.08757.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190729.923334292@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> 
> This is the second version of the patchset to the Linux kernel to support
> the Qualcomm Hexagon architecture.  These patches have been organized like
> the last time, in a somewhat logically grouped fashion.
> 
> A summary of changes from the last patchset:
> 
> * use Kbuild method for strictly asm-generic headers
> * clean up dma sync and implement clean/invalidate
> * bitops fl*/ff* cleanup
> * added inline assembly version of atomic_add_unless
> * removed deprecated syscalls/defines
> * call __vmyield for cpu_relax and fix cpu_idle
> * clean up thread_info; use arch allocator to allow kernel stack sizes
>   smaller than page size
> * implement read_timer_counter
> * changed checksum to pull non-asm functions from generic code
> * delete module functions which already have generic equivalents
> * cleaned up IO routines
> * reduced comet_defconfig
> * remove ugly platform code

Excellent work!

I've looked through it again and noticed a few things that I had
not seen in the first round and some that you changed but that I
still think need to be changed again.

On the whole, I think this is good to go into 3.2.

	Arnd
