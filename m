From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Wed, 27 Feb 2013 00:25:50 +0400
Message-ID: <9881361910350@web24g.yandex.ru>
References: <1163031361018389@web26d.yandex.ru> <1361593470.29465.17@driftwood>
 <1982671361708622@web15h.yandex.ru> <1361861719.15497.0@driftwood> <195171361907160@web18e.yandex.ru> <CAHrUA35uwyu5mX3MPxC7AV6qWZ_R6DdBJLp=s78m-1hd3S2RCg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361910350; bh=m/UNyU2nKE0588X9OGtQ9k0FhyEtJsWjm1i701N2Vqw=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=jlKA1du+FGa+/XElAy/eGm84sKxn6V3Tm8h1KExO0WraTfUZ7cIJmT7NBQJGOedJq
	 1ckXYw1om09fi//zurmdjQq7ol1Uih9ISLiKXee8ETMxK3qT4AONA1y51GwFHkrrMi
	 gi67VY21Kww57+6ApmXYm3ZjLj2SIGgVSgufaW6w=
In-Reply-To: <CAHrUA35uwyu5mX3MPxC7AV6qWZ_R6DdBJLp=s78m-1hd3S2RCg@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org

>
> =9AOne of the worst design errors in that code is that base addresses
> =9Awere made into compile-time constants, and then, to add serious in=
jury
> =9Ato insult, a lot of complicated macros were written to obtain vari=
ous
> =9Arelative offsets. =9AThe problem being that the hexagon uses exact=
ly the
> =9Asame offsets, but just different base addresses -- and they're
> =9Arun-time configurable, e.g. by bootloader or by device tree. =9ADe=
vice
> =9Atree support for hexagon was planned, not sure about ARM.
>
for me it's normal to have hardcoded base addresses. it's not so bad.
I am talking about more general problems like useless code or code with=
out enough data checks in my opinion.


Hexagon has same addresses for most shared devices except the private o=
nes - like timers and second level interrupt controller.
=46or example, I am using exactly same base address for USB and it work=
s.

> =9AI had started work on this, but I don't remember that I ever got i=
t
> =9Aclean enough to submit upstream. =9AThat plus the fact that interr=
upt
> =9Arouting was different: =9Ahexagon has both second and third-level
> =9Ainterrupt controllers, with ethernet being on a third-level
> =9Acontroller. =9AI'd gotten much/most of the 2nd-level code done, an=
d some
> =9Aof the 3rd-level code done, and I think its in the mainline kernel
> =9Anow, although I remember planning to do some more simplification a=
nd
> =9Acleanup.
Hm it seems dependent from SoC.
In QDS8250B there are two second level interrupt controllers (SIRC)
In common it can handle (32 - 2) + 2 * 32 interrupts.
I already got SIRC to work and receive USB interrupts without problems.

> =9AYes, that sounds right. =9ASorry, forgot about that.
> =9AHmm. Either that or volatile needs to be added to the upstream
> =9Adrivers: this is an issue for a variety of arches, not just hexago=
n.
> =9ACertainly powerpc treats treats uncached and i/o access in a very
> =9Adifferent way than memory access, and if you don't do it right, li=
fe
> =9Awill be painful.
Probably. It's just a thing which should be extremely careful looked du=
ring low level development for Hexagon - I am already few times was "ca=
tched" by that rule :-P


-Cotulla
