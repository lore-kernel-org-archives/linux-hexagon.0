From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sat, 16 Feb 2013 23:21:40 +0400
Message-ID: <1568431361042500@web1g.yandex.ru>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
 <1433341360978513@web2h.yandex.ru> <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
 <1163031361018389@web26d.yandex.ru> <CAHrUA37eKrJXMQhgfNcZL5_Vdm0x=RGeH1q6ugWaJaCH7qZ-gg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361042500; bh=dggt/HVMvsVaIbF5a348ThUsxhnm0T7tgtcam9a0VMY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=OvHqDky7Q49BfH122mCX62295qdYaGBSd5S0yV/rpcPoAM8koVg+CinPsJKJ99EMl
	 eKhMtvKOuh94MtLHtgvFApLbNQ8XngKK4+GcSgVZHqxJSVmwhYK0MBzr9+EC0XU7U4
	 8dSpeqGUiz4+oHPu5xPW7hyBPIVzYwOrGaB8NOSc=
In-Reply-To: <CAHrUA37eKrJXMQhgfNcZL5_Vdm0x=RGeH1q6ugWaJaCH7qZ-gg@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9A! =9AI did not know that. =9ABTW, be aware that there are usually =
two
> =9Adifferent qdsp's on there. =9AThe smaller/older/slower one is runn=
ing
> =9Athe radio signal processing code and it is very locked down, as th=
at
> =9Acode is considered to be extremely valuable. =9A(Its also the one =
that
> =9Ahas total control over all the master interrupt masks, which not e=
ven
> =9Athe ARM can over-ride). =9AI'm not sure, the radio processor might=
 not
> =9Aeven be a qdsp6, it might be a qdsp5 or qdsp4, I never paid attent=
ion
> =9Ato that. =9ABut the point is: =9Aif it seems like its locked down,=
 make
> =9Asure you've got the right one, that there isn't another one sittin=
g
> =9Athere on the JTAG chain.
>

It depends from QCT chipset.
In old ones ARM + QDSP4 are used for modem operations.
And QDSP5 or QDSP6 for multimedia tasks.

New ones contains 2 x QDSP6 for modem usage and 1 x QDSP6 for audio.
So actually in some chipsets there are up to 3 QDSP6 instances nowdays.

But a problem that it's heavy locked nowdays. (signature checking, hard=
ware key + hardware crypto engine)
So it's hard task to load own code to QDSP6 :-(


So you worked primary on userland QDSP6 support?


-Cotulla
