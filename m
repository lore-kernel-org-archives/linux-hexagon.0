From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PATCH] char/misc patches for 3.10-rc1
Date: Mon, 29 Apr 2013 23:29:14 +0200
Message-ID: <201304292329.14295.arnd@arndb.de>
References: <20130429162115.GA6893@kroah.com> <8yafvy92gfs.fsf@huya.qualcomm.com> <CA+55aFxaMP+=uMLLvnLHz_E0GStrDf_zO3XhVCDGHbk=tV6CqA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxaMP+=uMLLvnLHz_E0GStrDf_zO3XhVCDGHbk=tV6CqA@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Brown <davidb@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On Monday 29 April 2013, Linus Torvalds wrote:
> Or maybe "drivers/platform/something-or-other" if there are possible
> other things that get shared together with this thing? I don't care
> that deeply, as long as it's just off in a little corner of the
> universe, rather than smack-dab in the middle.

I usually try to prevent ARM platform specific code to go into
drivers/platform, because of fear that this might become the place
that people use to sneak in code we would not allow them to add
to arch/arm/ for one reason or another. Based on David's explanation,
I think drivers/mfd makes the most sense. I'll follow up with a patch.

	Arnd
