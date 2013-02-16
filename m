From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sat, 16 Feb 2013 16:39:49 +0400
Message-ID: <1163031361018389@web26d.yandex.ru>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com> <1433341360978513@web2h.yandex.ru> <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361018389; bh=RvUemFU9dQ0hfmjrUXp0Ji8QkP2DjMdLlceED/UNWMY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=jGBiSNuudDGknljvcUdVMhSNe9+la600FjZUfBa93MmIpVydmX9YYYK3wzFzABPGu
	 gk5FB+mLgrclsUojolMgTnUAZx9RIe4YtKbVuTxV2nd1pGMAwuq+5owW8EwjOFRZlT
	 6DdViKQas9O87PPuRcpyqgK0huguJ9Isq0Mb4wGQ=
In-Reply-To: <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org

Hi,

> =9AFor the qdsp6v3 the effective clock rate was 300MHz per core, so y=
es.
> =9AIt might be even slower for v2, not sure. =9A(the chip clock rate =
is 1.8
> =9AGHz, there are 6 interleaved cores, so 1.8/6 =3D 300 =9AThe power =
savings
> =9Aare not from the clock rate, but from the tiny transistor count. T=
he
> =9Aperformance efficiency is from keeping all of those transistors
> =9Aconstantly wiggling, which is what the interleaved pipeline does.)

Hm, I thought the maximum clock rate is 595.2 Mhz?
Or 1.8 is another clock?
But by changing this clock rate I can get different Q6 performance.

> =9ANoo .. in fact, that slow clock rate meant it's more or less the s=
ame
> =9Aspeed as DRAM. =9ASo low penalty for cache miss. =9ABut there's al=
so a bus
> =9Abetween here and there, and I think it was selected for simplicity=
 not
> =9Aspeed...
I thought that it can be bus arbiter setting, but other masters like MO=
DEM and APPS were almost idle during test.
I think in that case Q6 can take whole bandwidth or is it still limited=
 somehow?


> =9AOh, well, no, the VM wasn't created for linux, it was created for =
all
> =9Athe other junk they try to run on there (eg audio processing, nois=
e
> =9Acancellation, etc.), so that there would be a forward migration pa=
th
> =9Afor that software with each new chip generation. =9AWhether those =
other
> =9Asoftware parts actually used the thing, and in what time-frame or
> =9Arelease .. hey .. typical big-company inter-divisional politics,
> =9Abickering, etc. =9AThe truly daring wanted all those other parts t=
o run
> =9Aon the linux kernel. =9AThe old-school was like "hell no we don't =
need
> =9Ano stinkin OS, we'll hand code everything in assembly" which sound=
s
> =9Agreat until you have ten support staff helping them kludge up a re=
ally
> =9Areally badly designed home-grown linker/loader/scheduler/irq-handl=
er.
> =9ASometimes, really smart people just don't get it.

Well, sometimes such code becomes too large and slow, while doesn't pro=
vide universal solution for all cases.
As well as more code =3D=3D more bugs inside and harder to follow logic=
 inside.=20

> =9ADon't know v2. But v3 had a 'real' MMU
Hm, are you sure in that?=20
I had never seen any usage of it. As well as binutils registers definit=
ion doesn't include any suitable registers for that.=20

> =9AGood, because the bootloader was going to be the other issue.
Yes, in my case it's working :)
But another guys who also want participate in this project with MSM8960=
/APQ8064 they still can't run any unsigned code on Q6.
In modern phones it's often locked from changes :(

> =9AI'd done the patches for glibc (yes, they're publicly available on
> =9Asome website, don't know if they got merged or not), got 98% of th=
e
> =9Amany hundreds of glibc unit tests to pass, including most or all o=
f
> =9Athe thread tests including TLS. Someone had bootstrapped hundreds =
of
> =9A.debs and both python and perl passed 100% of their tests. =9AI'm =
sure
> =9Ano one cares, but even guile worked, and I was about to start fidd=
ling
> =9Awith haskell :-)
Good to hear that. Good job!
So userspace support is rather good in common.
Maybe we will try to compile and run Android on that 6 cores pff hardwa=
re threads :D


-Cotulla
