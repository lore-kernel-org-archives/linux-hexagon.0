From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Wed, 20 Feb 2013 05:17:26 +0400
Message-ID: <726431361323046@web23g.yandex.ru>
References: <1093431360938494@web22d.yandex.ru>
 <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
 <1433341360978513@web2h.yandex.ru>
 <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
 <1163031361018389@web26d.yandex.ru> <20130219043605.GB12127@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361323047; bh=3ujcxp/h+Bo4dw9UUAmBN8ZobsFhhQzfD+Nxkx9I3dY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=uraCtUp9ljzDhpomegMdoYtpfhu6fOAHepMvJRlnUTafhe+V30wewmMl2duge4ZjI
	 M0o0Sp/mXceaVpbigy1wp4qgEOMRVVen9KbAu4y2lnTZi7Fch3UwLf/q6od4rfIM4V
	 EappCzuKxR6XR6nkHXQMrfRy4cyw0DdIOwPaVluk=
In-Reply-To: <20130219043605.GB12127@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9ABoth have an MMU, but both are software managed. =9AThat's one of =
the
> =9Afunctions that the hypervisor provides for us.

Yes, like MIPS one :)

> =9ACongrats on getting the bootloader working.
>

We bring kernel already up to timers init :)
It was rather hard task to add support for PHYS_OFFSET, HVM kernel assu=
med that physical memory started at 0x00000000 always.

But some things are not really clear:
1. How hardware define which SMP core takes interrupt if all iassign bi=
ts are set (0x3F)?
Does every thread starts execute exception handler or only one, selecte=
d by hardware?=20
How preemtion is disabled in that case?

2. What difference between ciad and cswi?=20
I guess ciad is "Clear Interrupt Ask Done" and cswi is "Clear SoftWare =
Interrupt"?

3. How preemtion can be done during exception handlers execution?
Exception bit in SSR disallows to enter new exception handler?
I assume it's possible to clear exception bit and continue execution in=
 normal mode.

If it's possible, can a bit explain/help with those things?


> =9AHexagon Linux so far has been just used on internal projects; it's
> =9Anot a part of any products even though the processor itself is. =9A=
A
> =9Anon-hypervisor port is certainly possible, but for our purposes
> =9Aaround here, it's always running under the hypervisor.
>
But some comments inside code tells that it was native at the start ;)


-Cotulla
