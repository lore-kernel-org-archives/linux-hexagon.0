From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sun, 24 Feb 2013 21:29:27 +0400
Message-ID: <2140201361726967@web5h.yandex.ru>
References: <1163031361018389@web26d.yandex.ru> <1361593470.29465.17@driftwood>
 <171311361707235@web14d.yandex.ru> <CAHrUA34oWaQvVwWk7cCcYmh188pv=vNCZnXWvn4sDJN0k-QEaA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361726967; bh=KUOVEDfnReDgaD0t6CBpdmbwXOx9zcySfw8WI6YhGJw=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=rrgIhhkzsw1BUk9Ya1QJoa/Xn5eTQnvTz6HUi6/qphQdx2HCNcuCpDD0NqSY5lgBe
	 MioD/MGz13DElD8nG8/ak4Kkw4bxc536QAEoz72nHsEmPNsw9aZ0Wp/jV7gPfhsU9+
	 1fzC1+0TGzXFHMOsUMQYdcK1RzgpToT/62fKeGSI=
In-Reply-To: <CAHrUA34oWaQvVwWk7cCcYmh188pv=vNCZnXWvn4sDJN0k-QEaA@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9AWell.... you are using memb to copy one byte at a time, instead of
> =9Amemd which will copy 8 bytes at a time. =9A=9ASo that change alone=
 should
> =9Amultiply performance by 8.
>
> =9AYou can almost surely be more clever, and move the if statement an=
d
> =9Athe increment into a packet, so that they execute in parallel. =9A=
Its a
> =9Avliw, its very parallel, that needs to be exploited. =9AFor exampl=
e, (if
> =9AI remember correctly (?)) you can set and read r2 in the same pack=
et,
> =9Athe read will get the old value, the set will write the new value.
> =9AYou can move the jumpr into the next packet, if you don't mind cop=
ying
> =9Aone extra byte. =9A=9ASo there are many tricks like this.
>
> =9AI don't remember the details any longer, but there are cases where=
 the
> =9Acompiler would inline some fairly efficient memcpy code. =9A=9AAls=
o .. the
> =9Acompiler is smart, in general -- =9Ayou should try writing the loo=
p in C
> =9A(and using 64-bit words) and seeing what it generates.
>
> =9AAnd finally, aren't there some optimized memcpy assembly routines =
in
> =9Athe kernel? I know we kept talking about these...
>
> =9A--linas

Yes, there is an optimized memcpy version.
But my goal was to "compare" ARM performance with QDSP6 to know what to=
 wait from it.
So I made a simple C code and tested it on both processors.

And there is a difference between them. My question was in general: do =
you think it's normal or QDSP6 should work faster/slower?=20
Did you test performance inside Linux on Hexagon?


-Cotulla
