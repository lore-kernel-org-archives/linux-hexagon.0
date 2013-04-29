From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PATCH] char/misc patches for 3.10-rc1
Date: Mon, 29 Apr 2013 23:16:28 +0200
Message-ID: <201304292316.28464.arnd@arndb.de>
References: <20130429162115.GA6893@kroah.com> <CA+55aFzefpRz2Y8oW9q0ArrR=XW0POBhy8NSNJ3DrCh9EowLqg@mail.gmail.com> <8yafvy92gfs.fsf@huya.qualcomm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <8yafvy92gfs.fsf@huya.qualcomm.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: David Brown <davidb@codeaurora.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On Monday 29 April 2013, David Brown wrote:
> I'm not sure why this shouldn't be in the drivers/mfd directory
> alongside the various pm*.c drivers that use it.  It isn't going to be
> used for anything else.
> 
> Given the bikeshedding that happened when Ken pushed the driver out last
> time, though, I'm sure this will create a firestorm of disagreement over
> its location.

Well, the only reason I see against putting it into drivers/mfd is that
this place is becoming a dumping ground for stuff that doesn't have a
real home anywhere else. On the other hand, this one would fit better
than a lot of drivers that are already there, and it would actually remove
the need for a global include/linux/*.h header file as the interface.

	Arnd
