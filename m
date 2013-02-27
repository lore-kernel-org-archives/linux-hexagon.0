From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Wed, 27 Feb 2013 16:35:42 +0400
Message-ID: <905091361968542@web30f.yandex.ru>
References: <CAHrUA3646S2JBOQ6sYh29EgzF6Fcp2acgkV3bHUVN21qwd09Yw@mail.gmail.com>
	(from linasvepstas@gmail.com on Tue Feb 26 19:30:23 2013) <1361934205.18483.4@driftwood>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361968542; bh=KstkvpA79y5/ZSqle4qDL9+46g9O4jFGXJAY4fmLZaU=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=T5JUqaXn8aCIdYE7FYvO01oQuwBUMWmId1BuwKXR0DCJkJkAFvFnkkTyEVRwpkkFn
	 IPNbYC+LTQUKRLrgCvW2W2LAY5dORkWKlycKiXsj666kz3URY8b2tTzRYm9XZkKcRP
	 UGuQdXYcZa7xHd5ozq1W9vBjbSSXDoICWKH0SCJ4=
In-Reply-To: <1361934205.18483.4@driftwood>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9AWhat would be some good models to try? (I dunno what has v3 or v4 =
in
> =9Ait, not everything's got a qualcomm chipset...)
>

It's hard to advice.=20
MSM8660/APQ8060 contains V3;
MSM8960/APQ8064 contains V4;
It also must be unlocked to run unsigned code. Most of modern phones ar=
e locked and it's rather hard to unlock that.
Note that some SoC contains QDSP5, not QDSP6.


> What I _do_ remember is that each instruction is 32 bits, and that on=
e
> of those bits is the grouping bit which is either on or off (I forget
> which) to indicate the end of a packet.

Yea, same thing makes it hard to disassemble - it's hard to know where =
packet starts. And program flow is working only on packet edges.


>
> I really want qemu support for this. Sigh. Are there public assembly
> docs anywhere? (I had a giant printout brick circa 2010 but remember
> almost nothing from it and gave it back when I left...)

You can google for:
80-NB419-1_A_hexagon_v2_programmers_ref.pdf
80-NB419-2_A_hexagon_abi_spec.pdf


>
> If you poke Thomas Gleixner, he _might_ be able to help. (He did work
> under NDA, but some of the restrictions may have been relaxed when th=
e
> code went upstream. If he can't help, he'll say so.)
>
> You won't get a lot of time out of him, but he may be able to answer
> questions about where code lives in various public trees...
>
I think it's just question of work ;)
It just need a some time to make it work.

Actually my device doesn't support USB OTG fully, ID pin is not used ri=
ght as well no internal VBUS.
So I need change it to be able specify UDC or UHC mode manually by hand=
s.


-Cotulla
