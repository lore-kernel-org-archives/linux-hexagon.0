From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MFD: move ssbi driver into drivers/mfd
Date: Tue, 30 Apr 2013 12:26:20 +0200
Message-ID: <201304301226.20462.arnd@arndb.de>
References: <20130429162115.GA6893@kroah.com> <201304300000.19488.arnd@arndb.de> <20130430101854.GI4563@zurbaran>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20130430101854.GI4563@zurbaran>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Brown <davidb@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On Tuesday 30 April 2013, Samuel Ortiz wrote:
> I suppose we don't expect any non MFD drivers to use this interface ?

Yes, that is correct.

> If that's so, I'll take it through mfd-next.

Ok, thanks!

	Arnd
