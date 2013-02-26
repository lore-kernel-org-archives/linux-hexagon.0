From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 26 Feb 2013 13:59:54 -0600
Message-ID: <CAHrUA35uwyu5mX3MPxC7AV6qWZ_R6DdBJLp=s78m-1hd3S2RCg@mail.gmail.com>
References: <1163031361018389@web26d.yandex.ru> <1361593470.29465.17@driftwood>
 <1982671361708622@web15h.yandex.ru> <1361861719.15497.0@driftwood> <195171361907160@web18e.yandex.ru>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fIMmjKyx0tNPwJZJFbSUGaodLG8aDwSgnHL1eSN/fds=;
        b=PAj9f9VU1zGnMnoD7bYk+0Z0b2e5lTm8NyFBJ6fBltHi3N7QTi8gdlNXiJNW6I6tmf
         H5/rhzZmHwKuqxfDBv85iu1TKsLSCz25jmVrIqeBP3gxGtbvzxMjQrBu19gm2EaCg5bt
         wg+b+ZEWdHQIXs5QFEN98cz5XC5Z3XKFNzrWyKhsszJUchn53qi8QuRC4m56qhG703DN
         CNemw2zIgs99xmrMtjxIHdyBD7zyjhUIl/AGbdBokPcRtE9df2zhUjn1Gx5dZ5GB9wuo
         C50yxm0nYcsnjzVoPdchU9IDPCgNDapySYyqATG+YDhPxy44ZVHOxXav/zrjNC8fJlCe
         Sl8Q==
In-Reply-To: <195171361907160@web18e.yandex.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 26 February 2013 13:32,  <cotulla@yandex.ua> wrote:
> I am trying to bring up USB garget driver now.
> Already found that arm/mach-msm is also nosense. In common it's bad, ugly code for something mythic.

Yeah.

One of the worst design errors in that code is that base addresses
were made into compile-time constants, and then, to add serious injury
to insult, a lot of complicated macros were written to obtain various
relative offsets.  The problem being that the hexagon uses exactly the
same offsets, but just different base addresses -- and they're
run-time configurable, e.g. by bootloader or by device tree.  Device
tree support for hexagon was planned, not sure about ARM.

I had started work on this, but I don't remember that I ever got it
clean enough to submit upstream.  That plus the fact that interrupt
routing was different:  hexagon has both second and third-level
interrupt controllers, with ethernet being on a third-level
controller.  I'd gotten much/most of the 2nd-level code done, and some
of the 3rd-level code done, and I think its in the mainline kernel
now, although I remember planning to do some more simplification and
cleanup.

> Also I found that adding "volatile" to variable declaration puts all accesses to it as not grouped into packets.

Yes, that sounds right.  Sorry, forgot about that.

> So it can be easy workaround for uncached memory access problem, instead of replacing everything to ioread32 and iowrite32.

Hmm. Either that or volatile needs to be added to the upstream
drivers: this is an issue for a variety of arches, not just hexagon.
Certainly powerpc treats treats uncached and i/o access in a very
different way than memory access, and if you don't do it right, life
will be painful.

--linas
