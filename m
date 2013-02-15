From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Fri, 15 Feb 2013 16:33:43 -0600
Message-ID: <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dKjnbVzAu7R4EN16MrY94W+7MpxbdfF2KLTOL2qbrYg=;
        b=0HkGvplDcKc6EtnIWhJuJEUISGYUBQkVNOner9NRL1JOmmeFgg0Mkb9t2SnCF7FBHc
         4U/ZDXwIkrvq/OfbdsPWjhuW0OPgCGWg7Q8x65LDM/MfL3z3ZA2wnJOk8y8hZ4jVFH12
         0g6W4vRYX1GQDoTrUrvtrzH3lK0CoyBudRoGnpIRhsVaF1KZ700G5gyo+j+2T6gfM5j+
         fSjG1M9lVDZUUsACGq+O16yY5chX4E1bUInTzZinptb7RHzHx66N1lh2SkeX5LrXvt25
         /qQyF0DqsfQFcs1ERcnq6o0baYMWci+mznAW2jsOlNiJ1dMnfVjYhe/lTqZe0g6B12/Q
         AlZQ==
In-Reply-To: <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org
Cc: cotulla <cotulla@yandex.ru>

Hi,

On 15 February 2013 08:28, <cotulla@yandex.ru> wrote:
>
> However after deep looking inside those patches I found that
> this code is only supposed to be run on top of some mythic "Hexagon Virtual Machine".


Its documented at https://developer.qualcomm.com/hexagon-processor
https://developer.qualcomm.com/download/80-nb419-3ahexagonvirtualmachinespec.pdf

> "Hexagon Virtual Machine" is not available for free download in source
> code or either in binary form.


I think it was supposed to be, I'm not sure why its not.  There had been some
grand plans for hexagon, but they never quite materialized.  Its far more
power-efficient than even the most efficient ARM's (I'm guessing it might be
the most power-efficient (32/64-bit) processor ever?), and that was going to
be its selling point.  I think they could not figure out how to sell
it, or to whom.

> I guess it's only available for Qualcomm customers by signing NDA.
> This prevents actually to run own home builded kernels on real QDSP6.

Well, I'm not sure, but I'm guessing that if you prowl around on the ROM,
you'll find a copy of it in there somewhere.  And if you don't, its actually a
mini-VM, its maybe a few hundred lines of assembly.  It really did very little
other than enabling and dispatching first-level interrupts. Perhaps I'm not
thinking clearly, but I'm guessing that you can hack around having it at all.
I don't remember if there's some must-use-it-or-die undocumented  register
in there or not.

> I think including of such code inside official open source kernel is nosense -

Most of the other vendors do it to. Certainly, most of the powerpc
code requires
an extremely large and complicated hypervisor -- something like millions of
lines of code -- and its extremely proprietary.

> And how kernel developers are going to support and test that architecture
> without actual running hardware?

While I was at Qualcomm, I saw development boards that were supposed
to be generally available for a few hundred $$.  They were basically
cell-phones
with the radio disabled (to avoid complications with the carriers) and some
extra headers soldered on for hardware debuggers.  Qualcomm was even
funding someone to build a very low-cost (sub $500) semi/mostly(?) open-source
hardware debugger,  something that could read the JTAG bits and
halt/single-step
the CPU.   The point of the low-cost was to allow hobbyists to get
into it ..  since
paying $5K to debug a $200 board only makes sense for NDA-signing corporations
who can afford it.

I left the company before this stuff was finalized, but they were very
excited to
get this stuff going.  I don't know what happened.

--Linas
