From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 26 Feb 2013 22:54:21 +0400
Message-ID: <5251361904861@web14e.yandex.ru>
References: <CAHrUA36YTCfedZGxBa+Vgzvz=DBR=PJhcPHe0aZegQiD79gHXQ@mail.gmail.com>
	(from linasvepstas@gmail.com on Sun Feb 24 15:03:37 2013) <1361813206.27287.1@driftwood>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361904861; bh=vLCV4nvVOeJbTBixoLsWRYuGTLfEvdI+Q+FJcIiFDcM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=opNIbR8UsYk62CtNVX8BWTAYzBryOrTKO9QeescVjxFHYPhVuxGo82VB8y0FKxJJN
	 LYn1JGjcNlfWN8K7bjkrkDtRJCmK7C/57rY8YvWusvRvl/x5T5TbVteHi7v8yWCmcx
	 /izRN+vEENVsoAtbtTIRP7KIKwdwBQaSZnMXuQoQ=
In-Reply-To: <1361813206.27287.1@driftwood>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9AYou're comparing arm performance with QDSP6 by writing pessimal QD=
SP6
> =9Acode that does single-byte moves and keeps half the execution unit=
s
> =9Aidle. You're going to get some extremely useful numbers out of tha=
t,
> =9Aaren't you? (Even their uClibc port had an assembly optimized
> =9Amemmove().)
Well, is it simular to usual C/C++ code task and results of compilation=
?
Until you will do a manual assembler optimization.

> =9AIs your arm code also doing single byte moves, with the requisite
> =9Abit-shifting and masking that doing that on arm entails (since las=
t I
> =9Achecked arm hasn't actually _got_ instructions that handle bytes,
> =9Aalthough maybe it went into thumb2 or v7 or v8 when I wasn't
> =9Alooking...)?
ARM has LDRB and STRB instructions long time ago (ever in ARMv4)

Okay, seems this is really bad test.


> =9ASpecifically, the v2 hardware (in the snapdragon chipset in the Ne=
xus
> =9AOne) has 6 register profiles (for the 6 pipeline stages, acting as
> =9A6-way SMP) but performance peaked at "make -j 3" which ran very
> =9Aslightly faster than "make -j 4", and then -j 5 and -j 6 were each
> =9Anoticeably slower (due to TLB thrashing).
Intersting to know that.=20
I want to get SSH access to got console and interaction with system.


> =9AI believe that v3 had already taped out by then (late 2010, but it=
 had
> =9Afewer pipeline stages and thus register profiles anyway), and then=
 v4
> =9Awas going to increase the TLB entries. What actually shipped was a=
fter
> =9Amy time, dunno the details.
v3 should be rather close to v2, but v4 seems to have few new features.
At the current moment all v2 source code works on v3.


-Cotulla
