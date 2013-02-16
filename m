From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Fri, 15 Feb 2013 20:34:23 -0600
Message-ID: <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com> <1433341360978513@web2h.yandex.ru>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zwEy7hOJX58Ud7pLQL5QDQSfgiDoFJLkB7JR7WJ1hIc=;
        b=smCHiiKT1lXnUyWIoEof3XhEdwoBwaAO0lWES0jnIo+Byc7yUPEDQSD2CkFVjwFwzK
         GzGxw4A18xCt4d0W7HI06pNTQdEoyfsjTd6fBezJ6oFSTLzcYYg0TCRMQ8+eyV4Vmv7t
         C7XZAIWNlAJGZLUvPiYZ9wQSdDYNQiGWyTI9LaM88cuMjuxU/1gQuIsNCq1f9LbA8jP9
         zHdLEmvTwoxr+JEa3rRSpWNK74j/PFpYYPV1lsAjXAN/vvXjsO3GRegxtk/SiD5lgzxO
         Tfz6ytIK2ht+iBPhqIC2y1Q9VQPuHmAdLX2bD0O6qLbYPrpfOGC43rE6FaPXo5mFZTSN
         VDOw==
In-Reply-To: <1433341360978513@web2h.yandex.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 15 February 2013 19:35,  <cotulla@yandex.ua> wrote:

>>  Its far more
>>  power-efficient than even the most efficient ARM's (I'm guessing it might be
>>  the most power-efficient (32/64-bit) processor ever?), and that was going to
>>  be its selling point.  I think they could not figure out how to sell
>>  it, or to whom.
>
> Interesting. But is it rather slow?

For the qdsp6v3 the effective clock rate was 300MHz per core, so yes.
It might be even slower for v2, not sure.  (the chip clock rate is 1.8
GHz, there are 6 interleaved cores, so 1.8/6 = 300  The power savings
are not from the clock rate, but from the tiny transistor count. The
performance efficiency is from keeping all of those transistors
constantly wiggling, which is what the interleaved pipeline does.)

> Especially a memory access?

Noo .. in fact, that slow clock rate meant it's more or less the same
speed as DRAM.  So low penalty for cache miss.  But there's also a bus
between here and there, and I think it was selected for simplicity not
speed...

> No, it doesn't present in any ROM. I already checked that.
> As well as it is useless inside without actual Linux image.

Oh, well, no, the VM wasn't created for linux, it was created for all
the other junk they try to run on there (eg audio processing, noise
cancellation, etc.), so that there would be a forward migration path
for that software with each new chip generation.  Whether those other
software parts actually used the thing, and in what time-frame or
release .. hey .. typical big-company inter-divisional politics,
bickering, etc.  The truly daring wanted all those other parts to run
on the linux kernel.  The old-school was like "hell no we don't need
no stinkin OS, we'll hand code everything in assembly" which sounds
great until you have ten support staff helping them kludge up a really
really badly designed home-grown linker/loader/scheduler/irq-handler.
Sometimes, really smart people just don't get it.

> One important part is a software MMU implementation, because Hexagon doesn't have hardware MMU, only standalone TLB entries.
> But HVM provides that functionality to the guest.

Don't know v2. But v3 had a 'real' MMU

> As well as most supervisor mode registers are not really defined, like "bit 18 of SSR is interrupt mask flag".

:-)

> I already can run QDSP6 code in polling-bootloader mode.

Good, because the bootloader was going to be the other issue.

> Well, it sounds well. But what reason to push code to _mainline_ before all that is done?
> Is it really good to include random bullshit into kernel to make it cluttered?

I'd done the patches for glibc (yes, they're publicly available on
some website, don't know if they got merged or not), got 98% of the
many hundreds of glibc unit tests to pass, including most or all of
the thread tests including TLS. Someone had bootstrapped hundreds of
.debs and both python and perl passed 100% of their tests.  I'm sure
no one cares, but even guile worked, and I was about to start fiddling
with haskell :-)

--linas
