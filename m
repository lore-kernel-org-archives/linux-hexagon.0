From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] char/misc patches for 3.10-rc1
Date: Mon, 29 Apr 2013 14:18:55 -0700
Message-ID: <CA+55aFxaMP+=uMLLvnLHz_E0GStrDf_zO3XhVCDGHbk=tV6CqA@mail.gmail.com>
References: <20130429162115.GA6893@kroah.com>
	<CA+55aFwU-bXZ7wn2dOcLNfPMcjDv3Jvqx_LTt7B+-tj4WcP8Mg@mail.gmail.com>
	<CA+55aFzLtBwsvVrnT2DrUOU+eYrQ5eiKeamRb4Y5+-TVgbuM5Q@mail.gmail.com>
	<201304292154.15920.arnd@arndb.de>
	<CA+55aFzefpRz2Y8oW9q0ArrR=XW0POBhy8NSNJ3DrCh9EowLqg@mail.gmail.com>
	<8yafvy92gfs.fsf@huya.qualcomm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=hYNBNJUMsUCFPWkovlk4/iz2EKc5PPwlHtx1rmjNPEk=;
        b=QYVvKE7bofY74pceDscVmtKz9+WsG8QUEGb3L6OugQduRQA4Vx/WvXfkFcDYap3YbJ
         aJiDPdw+PCDWzkjdVjSSMknG4APoTMmMV4X1EAOzBa6SQppEAEzF39NjwmZXf3irmbUW
         kloURyvg0VRkaNB2DSnDKW5+8DWVrYltZrpopZ6kLyxN7Mz3RYKWaHAGtc7QR0idHpdx
         //ImwGQBbEPxsQmKYg3UyfC9UqWvDwsmUAdTqjkOO+H5v6anSHKU0xgRneh+em9zi2+c
         3gPrx4RtBO9h7/pJ9JVgcyIssdtmGgwpLHa3BV1mlhm5P9sLqH6CFXucjNn9nXmfy9qz
         eylA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=hYNBNJUMsUCFPWkovlk4/iz2EKc5PPwlHtx1rmjNPEk=;
        b=ENw84ORmsTC96nDTaMStZeMDH2ZauWhMl/9FJDArtBg0KIQ79I8o5xZlvlNUnBKznq
         NeDeTt2cQW4GUzVuDE0Frhh70L69Vn2pcFTYj1Vp7SzXlBgYUltpkByi7+g9OAbSubma
         uuGbH2IRzDmg/et1vHbZeLThUJkvz0Y6zCQmM=
In-Reply-To: <8yafvy92gfs.fsf@huya.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brown <davidb@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On Mon, Apr 29, 2013 at 2:08 PM, David Brown <davidb@codeaurora.org> wrote:
>
> So, what is this saner place?  The hardware is theoretically shared
> between ARM and Hexagon, but I don't know the hexagon plans to support
> it, I've added them to the CC.

So I actually wouldn't have complained about it in drivers/misc/ssbi/
or something like that. I don't think that's necessarily the best
place for it, and maybe somebody can come up with better places. But
even just in drivers/misc, at least you've moved it away to the point
that it doesn't potentially compete with the pathname auto-completion
of the fifty million other drivers we have under drivers/.

Or maybe "drivers/platform/something-or-other" if there are possible
other things that get shared together with this thing? I don't care
that deeply, as long as it's just off in a little corner of the
universe, rather than smack-dab in the middle.

              Linus
