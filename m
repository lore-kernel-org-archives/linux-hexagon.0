From: Jon Pry <jonpry@gmail.com>
Subject: Re: [Q] Guest mode in HVM
Date: Wed, 6 Mar 2013 15:48:28 -0500
Message-ID: <CA+3xLx6zQK81t83vhzafJ=OpFmh19NjUHQ-1Fe_KtThA7GjODw@mail.gmail.com>
References: <48b776bf823f2b3c978065ccc6bce7b0.squirrel@www.codeaurora.org>
	<1362595316.2980.0@driftwood>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SVSpVpI/p+bDzOOSxuOPdz0wyfIt9Dae5fpi6asXs6k=;
        b=gxeqqAY/phwAmpOw3ToQg6RmUVluV1a7fEwkrdGrMgFQ2OgMZXrbKyQni5Dwp79sfW
         WSO1gR2wDzJ9FdZ7v608XlGKw8u5oH110ovquR2jKX67U/BDnAnzagIJj0lN6P6r0vjT
         LII1XzkTu5Wgaqlt9A7syGte5y2F5yHavjEBX20NixlDuSV0dRKj1RuHkqMPGKAROCHQ
         404qwSkIGkSp4czstEJxqbaugcm0UAGZEevKl+69Uqd0g3NMIrTWENa57AXXB7bAUBR1
         rPnFj/JbEY2eRuEmRJfKCFjDA7ZqY+Y+WCigGGpjbqPgWvntiE1WBX7PM4pskFAbDE9r
         wo0A==
In-Reply-To: <1362595316.2980.0@driftwood>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: linux-hexagon@vger.kernel.org

> I would very much like to test this once you can boot a shell prompt on it.
> Is there some kind of README about what hardware to try to snag off ebay or
> prospects for getting support in qemu? (If there's a prebuilt toolchain an
> actual URL to that would be great too.)
>
> Rob

In theory we can run a shell prompt now. However the only console
driver is a ram console type thing, so output only. Cotulla also has
some kind of screen driver working which has the same problem.
The big issue with these devices is getting access to the registers
required to cause the processor to boot. This is not only dependent on
the processor model, but the specific version of the baseband software
installed. Really more so on the latter since any processor could at
least in theory provide access. My HP touchpad just happens to use
unsigned firmware for the Hexagon. Not many people have tried, so
there is no data on other devices with support. At this moment. the
touchpad is the only device known to have unlocked access to the DSP
boot registers.

If your really inspired it is possible to figure out if a given
android device can run unsigned firmware by examining the
/lib/firmware/Q6.mdt file on the device. Location kind of varies, but
it's somewhere. That file is an ELF header, and if you open it up in a
hex editor it will either have a couple thousand bytes of certificate
stuff at the end or not.  The NSA would be proud to see how well these
Hexagons are protected from their owners.

There may be some devices that have firmware signatures but still
allow access to the registers. Some modification to the arm side
kernel is probably required to prevent it from trying to use the DSP
for audio stuff.  I have patches for doing that on the touchpad.

There is a toolchain here:
https://www.codeaurora.org/patches/quic/hexagon/4.0/

That toolchain is horrible, and it can't compile anything except the
kernel. However it is the only one that can compile the kernel for >V2

Mentor graphics makes one that can actually build programs, what a
concept. LD is kind of messed up for greater than > V2 so whatever
your building must use gcc to do the linking.

https://sourcery.mentor.com/GNUToolchain/release2194

I used that for making userland stuff like busybox.

Cheers,

Jon
