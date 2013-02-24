From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sun, 24 Feb 2013 16:00:35 +0400
Message-ID: <171311361707235@web14d.yandex.ru>
References: <1163031361018389@web26d.yandex.ru> (from cotulla@yandex.ua on
	Sat Feb 16 06:39:49 2013) <1361593470.29465.17@driftwood>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361707235; bh=LhEh+/f40IMlfUSd87/+XRmOWl6na+0nkuOuqdvt+HY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=w/uLNFD49PktqEyrz0JSsxBTJq3fMqkgN4WQKaIL+EqJo8PuMU2BbUGUyVyVRYuEC
	 YaZ4Qv857fnKfjudIV4PT/jj/2G5Wr7gxJat65cUYscu8eoFpRrPJrfzv9rGRxZpaQ
	 gy7/VgbYjZ1e9y4d4K7SiR+U2MNTLVRPRAnqmYxA=
In-Reply-To: <1361593470.29465.17@driftwood>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org

> =9AThe clever thing hexagon did was avoid any pipeline interlocks. In=
stead
> =9Athey had as many register profiles as pipeline stages, and they
> =9Around-robined them down the pipeline. So the v2 processor ran at 6=
00
> =9Amhz but presented to Linux as a 6-way SMP chip each running at 100=
 mhz.
>
> =9AThis meant there were 6 clock cycles between each memory access, s=
o the
> =9ADRAM had no trouble keeping up. There was no speculative execution=
, no
> =9Abranch prediction, it never did wasted work and any pipeline stage=
 that
> =9Ahad nothing to do powered down completely for that clock cycle. Th=
ey
> =9Agot performance out of it via massive parallelism: each instructio=
n was
> =9Aa 4-issue VLIW, and the latter two cores were 4-way SIMD vector
> =9Athingies, so if you could break your task into 6 chunks (4 graphic=
s
> =9Aprocesses, an audio process, and a control process) it could do so=
me
> =9Aquite heavy lifting.
>
Good to know.
During tests I got around 90 Mbytes/sec RAM access in simple memcpy on =
256Mhz, while ARM got around 880 Mbytes/sec.
Do you think it's normal or maybe something configured wrong?
memcpy is done via simpliest way:
Memory is L1WB L2C. I & D prefetchings are enabled.

memcpy:
{=20
    loop0 (memcpy+0x10, r2)
    p0 =3D cmp.eq (r2, #0)
    r3 =3D r0=20
}
if (p0) jumpr r31
r2 =3D memb (r1 ++ #1)
{=20
    nop
    memb (r3 ++ #1) =3D r2=20
}:endloop0
jumpr r31


> =9AThe version I saw (v2) had a software loaded TLB which a binary bl=
ob
> =9Amade act like an MMU. It had too few TLB slots and kept thrashing =
them
> =9Awhen running a real OS, so they were going to add more in a future
> =9Aversion.
>
Yes, like MIPS. Intersting how many TLBs ARM processors have?


> =9ASo it's realy cool technology, fairly widely deployed, and if you =
want
> =9Ato make use of it I'd recommend reverse engineering it. (You can l=
ook
> =9Aaround the code aurora forum pages and download the toolchains the=
y
> =9Agive to the android guys; those binary blobs get built with modifi=
ed
> =9Agcc+binutils and the lawyers scrupulously obey the letter of the l=
aw as
> =9Athey understand it; the code is published at an obscure URL somewh=
ere.)
>
> =9AThe fun part is that "objdump" can decode the magic instructions, =
even
> =9Ain the binary blob. Because it has to be able to compile them, you=
 see.
> =9A(They're working on Hexagon support for Open64 and LLVM, but gcc's
> =9Astill a more mature compiler. Google for "hexagon open64" and simi=
lar
> =9Afinds interesting stuff, by the way.)
Yes.=20
Actually we got kernel to work up to userland init process!
Ofcourse there are still some not done things like SMP support or not o=
ptimized things (like it's flushing always full TLB instead of parts)
But it's already look rather well.

One of the problems - seems CONFIG_PREEMT is not supported with HVM cod=
e.
Maybe it's good idea to look at ARM or MIPS implementation and reimplem=
ent it from scratch.


> =9AThat was using... comet boards, I think? (Those hacked up phone
> =9Amotherboards Linas was talking about. The "snapdragon" SoC, QDSP6v=
2
> =9Achips plus a Scorpion plus an armv5 plus a QDSP4, all in a big bal=
l
> =9Awith USB and a serial port and an ethernet device and 256 megs of
> =9Amemory and I forget what else. We had a small number of them becau=
se
> =9Athey never made that many. Not a mass produced product, semi-obsol=
ete
> =9Aat the time, but the linux porting effort scrounged what resources=
 it
> =9Acould...)
Yea. QDS8x50B. My platform (HTC HD2) has exactly same SoC :-)


-Cotulla
