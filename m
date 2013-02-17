From: Rob Landley <rob@landley.net>
Subject: Re: [DISCUSSION] Running linux-hexagon on the Qualcomm Galaxy S3?
Date: Sat, 16 Feb 2013 21:37:57 -0600
Message-ID: <1361072277.11760.2@driftwood>
References: <loom.20130214T082052-714@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <loom.20130214T082052-714@post.gmane.org> (from
	erappleman@gmail.com on Thu Feb 14 01:29:14 2013)
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: Eric Appleman <erappleman@gmail.com>
Cc: linux-hexagon@vger.kernel.org

On 02/14/2013 01:29:14 AM, Eric Appleman wrote:
> Good idea? Bad idea?
> 
> A bunch of people Freenode (#d2common and #htc-linux) have begun a  
> port.
> 
> https://github.com/detule/linux-hexagon
> 
> Thoughts?

Please keep me in the loop!

The trick is:

A) Getting a bootloader that runs hexagon code. In snapdragon there are  
4 processors, and the "boot processor" is actually an old armv5l that  
bogs off to run radio code after initial boot. It has to hand off  
control to another processor, by default this is the Scorpion Armv7, it  
has to be reprogrammed to instead wake up the hexagon and give it  
control.

2) Last I checked some of the Snapdragon SoC drivers were only in the  
Android tree, under arch/arm. The hexagon will need these moved to a  
generic directory in the vanilla tree so hexagon can find the USB port  
and stick a serial console on it. (USB gadget for the win!)

III) Qualcomm's soft MMU code is binary-only because their lawyers  
think nobody's ever done a soft MMU before and thus their patents on it  
won't be invalidated if it's a secret what they are. (Last I checked  
objdump could disassemble the magic instructions, there was just no  
documentation on TLB loading and such.)

Also, back in 2010 there was a brief effort to get hexagon support in  
QEMU (just one thread, but it had to do the 4-issue VLIW since the  
different cores run different instructions and there's synchronization  
issues with jumps and such), which would simplify open source  
development _enormously_. Alas, it did not bear fruit that I'm aware  
of. Adding Hexagon support to TCG would be awesome.

Rob