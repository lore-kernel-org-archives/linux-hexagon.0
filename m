From: Rob Landley <rob@landley.net>
Subject: Re: Hobbyist hexagon?
Date: Mon, 05 Mar 2012 22:16:57 -0600
Message-ID: <4F558FB9.5000700@landley.net>
References: <4F5035A2.7070805@landley.net> <20120306025821.GC2855@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20120306025821.GC2855@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

On 03/05/2012 08:58 PM, Richard Kuo wrote:
> On Thu, Mar 01, 2012 at 08:51:14PM -0600, Rob Landley wrote:
>> I'd like to play with Hexagon Linux.  I'm told there's such a chip in my
>> old Nexus One, at at one point there was mention of potential QEMU
>> support for the thing?
>>
>> Assuming I just wanted to boot Linux to a shell prompt with an
>> initramfs, do I have any options?
>>
>> Rob
> 
> 
> Hi again, Rob!

Hi Richard!  Long time no see.

> I think there is certainly the desire to enable other people to work
> on Hexagon Linux, but unfortunately there's nothing externally available
> as of yet.

I have noticed this thing.  I would like to fix this thing, if I can.

There are a gazillion Nexus variants out there, and they're starting to
get old enough to be replaced. This means there are a gazillion _old_
nexus variants out there, some going cheap on ebay, which can become
reasonable development systems with minimal prompting...

> We haven't really done anything with QEMU,

Which is a pity.  Now that instruction set has been released, is there
something on codeaurora I can point the qemu guys at?

> and I don't have
> the support for any other external hardware.  There may be some stuff in
> the works for the public, but I don't have a timetable for any of it.

I have an old Nexus One, which I've replaced with a Nexus Black Thing
From Sprint (which may or may not be a "galaxy S", it doesn't say).  I'm
assured my old phone has a snapdragon-with-hexagon in it.  All I need to
play with it is the bootloader bit I can run on android to quiesce the
Scorpion and boot the Hexagon via the boot processor.  I can put an
initramfs in the kernel image to avoid even needing to read from flash
initially.

This means I _specifically_ need:

A) The armv5l code to run on the boot processor, halting the scorpion
and starting the hexagon.

B) That magic software mmu binary blob the hexagon kernel won't run without.

C) The usb serial driver for hexagon so I can get a serial console by
plugging the hexagon into my laptop.

D) A working example of all this fitting together, giving me a serial
console with kernel boot messages.

Rob

(P.S. It would be really realy nice if I could get that old uClibc
0.9.30 tarball, I could forward port it to current myself. But that's
not strictly required to make this usable outside qualcomm if the
existing cross compiler toolchains have a working libc in them.)
