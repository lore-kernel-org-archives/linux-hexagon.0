From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sat, 16 Feb 2013 05:35:13 +0400
Message-ID: <1433341360978513@web2h.yandex.ru>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com> <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1360978513; bh=udiA8kPVRe09QHo26lvmKDV/JLaDp9MOmGLWa7QMaC0=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=IWjpfdCal7IJpa14TzBqv4ptcUp2xs6ixqD6F2QYuW4nUApO/A/k3tVqPJWEu9QIR
	 mJkT54NlpV55MEfVIZhv2o7m7ebcI0W1z3H5Ja/8JTQPRw4XnEL+Acs+LSKH/32WIH
	 jEIVSs8Q1PZ2ANm3kTfLWSDOXyCnUNYQwKnKpAG0=
In-Reply-To: <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org

Hello,


> =9AIts documented at https://developer.qualcomm.com/hexagon-processor
> =9Ahttps://developer.qualcomm.com/download/80-nb419-3ahexagonvirtualm=
achinespec.pdf

Yes, I saw and active using that document. But it's only a specificatio=
n.
A lot of things are not really described there. And kernel implementati=
on is rather messy -=20
for example, in some places it's using HVM interface for cache operatio=
ns and in the another it is executing native commands.=20


> =9AI think it was supposed to be, I'm not sure why its not. =9AThere =
had been some
> =9Agrand plans for hexagon, but they never quite materialized. =9AIts=
 far more
> =9Apower-efficient than even the most efficient ARM's (I'm guessing i=
t might be
> =9Athe most power-efficient (32/64-bit) processor ever?), and that wa=
s going to
> =9Abe its selling point. =9AI think they could not figure out how to =
sell
> =9Ait, or to whom.

Interesting. But is it rather slow? Especially a memory access?


> =9AWell, I'm not sure, but I'm guessing that if you prowl around on t=
he ROM,
> =9Ayou'll find a copy of it in there somewhere.=20

No, it doesn't present in any ROM. I already checked that.
As well as it is useless inside without actual Linux image.


>=9AAnd if you don't, its actually a=9Amini-VM, its maybe a few hundred=
 lines of assembly. =9AIt really did very little
> =9Aother than enabling and dispatching first-level interrupts. Perhap=
s I'm not
> =9Athinking clearly, but I'm guessing that you can hack around having=
 it at all.
> =9AI don't remember if there's some must-use-it-or-die undocumented =9A=
register
> =9Ain there or not.

One important part is a software MMU implementation, because Hexagon do=
esn't have hardware MMU, only standalone TLB entries.
But HVM provides that functionality to the guest.
As well as most supervisor mode registers are not really defined, like =
"bit 18 of SSR is interrupt mask flag".

Of course it's not a problem for myself, I already researched most thin=
gs.
It should be enough to bring native Hexagon kernel instead of fake hype=
rvisor one.
I am working with HTC LEO which has QSD8250B/QDSP6v2.=20
I already can run QDSP6 code in polling-bootloader mode.


> =9AMost of the other vendors do it to. Certainly, most of the powerpc
> =9Acode requires
> =9Aan extremely large and complicated hypervisor -- something like mi=
llions of
> =9Alines of code -- and its extremely proprietary.
Well, I guess they provide those hypervisors with hardware kinda like B=
IOS?
In Hexagon case it's actually dead code.=20
What is the point to include such thing inside mainline kernel?


> =9AWhile I was at Qualcomm, I saw development boards that were suppos=
ed
> =9Ato be generally available for a few hundred $$. =9AThey were basic=
ally
> =9Acell-phones
> =9Awith the radio disabled (to avoid complications with the carriers)=
 and some
> =9Aextra headers soldered on for hardware debuggers. =9AQualcomm was =
even
> =9Afunding someone to build a very low-cost (sub $500) semi/mostly(?)=
 open-source
> =9Ahardware debugger, =9Asomething that could read the JTAG bits and
> =9Ahalt/single-step
> =9Athe CPU. =9A=9AThe point of the low-cost was to allow hobbyists to=
 get
> =9Ainto it .. =9Asince
> =9Apaying $5K to debug a $200 board only makes sense for NDA-signing =
corporations
> =9Awho can afford it.

Well, it sounds well. But what reason to push code to _mainline_ before=
 all that is done?
Is it really good to include random bullshit into kernel to make it clu=
ttered?
As well in the neighboring mail list people tells that QCT camera code =
can not be included to the mainline because it has private service for =
userspace.


-Cotulla
