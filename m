From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 00/36] Hexagon: Add support for Qualcomm Hexagon architecture
Date: Wed, 17 Aug 2011 22:34:38 +0200
Message-ID: <5653962.eQPS9muPhD@wuerfel>
References: <20110817163457.878854582@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163457.878854582@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Wednesday 17 August 2011 11:34:57 Richard Kuo wrote:
> The following patch set is intended to add support for the Qualcomm Hexagon
> architecture to the Linux kernel.
> 
> The Hexagon architecture is designed to deliver performance with low power
> over a variety of applications.  It has features such as multithreading,
> privilege levels, VLIW, and instructions geared toward efficient signal
> processing.  The port of Linux for Hexagon runs under a hypervisor layer.
> 
> I realize we are not currently in a merge window, but I felt it would be best
> to go ahead and send it out so that the community gets an ample chance to
> review it.  This is a very large patch set, but we've tried to break it up
> into functional pieces to make review easier.

Hi Richard and Linas,

It's good to finally see the source for this, and I have a good feeling
about the quality of the code, so it should not be a problem to resolve
the remaining issues in time to get it into the next merge window.

I have gone over all patches once now and commented about everything
that looked odd or wrong. Most of the issues are really just small
changes. Removing support for the legacy syscalls is an easy change
in the kernel but it might require significant changes in the libc
implementation. It's not a big problem if your libc still requires the
old interfaces at the time the architecture gets merged upstream,
that will just mean that you have to have a small kernel patch to add
them back in while transitioning to the new libc.

As I commented on patch 33, I think the platform specific patches should
not get merged before everything is converted to device tree based
probing. This should also not keep the rest from going in. I think it
would be good to do the conversion together with the ARM-MSM platform
that seems to share a lot of the device specific code, and it would
be bad to end up with duplicate work here or (worse) with incompatible
DT bindings.

	Arnd
