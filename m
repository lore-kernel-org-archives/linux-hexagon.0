From: Rob Landley <rob@landley.net>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 26 Feb 2013 19:06:29 -0600
Message-ID: <1361927189.18483.2@driftwood>
References: <195171361907160@web18e.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <195171361907160@web18e.yandex.ru> (from cotulla@yandex.ua on
	Tue Feb 26 13:32:40 2013)
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; delsp="Yes	Format=Flowed"
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 02/26/2013 01:32:40 PM, cotulla@yandex.ua wrote:
>=20
> > =A0I think I've missed chunks of this conversation: what are you =20
> booting
> > =A0it on?
> >
> > =A0(Wondering if I can get a test environment together. I haven't h=
ad =20
> one
> > =A0since I left qualcomm in 2010.)
> >
>=20
> Actually at the current time two persons are did some work in that =20
> project:
> 0)Cotulla (me) - HTC HD2 (HTC LEO) QSD8250B QDSP6v2
> Image load done by custom MAGLDR bootloader.
>=20
> 1)jonpry - HP TouchPad (APQ8060) QDSP6v3
> Image load done from kernel via PIL AFAIK.
> He also tried it on APQ8064 with QDSP6v4 but no luck with loading =20
> unsigned LPASS images.
>=20
>=20
> Current kernel code located here in GIT:
> We took clear tree Linux 3.7.6 at the start and started to work with =
=20
> it.
> https://github.com/detule/linux-hexagon

Cool. I haven't got hardware to do anything with it at the moment. =20
(With the possible exception of my phone, but it's in use as a phone. =20
Haven't even put cyanogenmod on it.)

> I am trying to bring up USB garget driver now.
> Already found that arm/mach-msm is also nosense. In common it's bad, =
=20
> ugly code for something mythic.

If you poke Thomas Gleixner, he _might_ be able to help. (He did work =20
under NDA, but some of the restrictions may have been relaxed when the =
=20
code went upstream. If he can't help, he'll say so.)

You won't get a lot of time out of him, but he may be able to answer =20
questions about where code lives in various public trees...

> I was trying to use a built in chipidea driver, but it looks =20
> extremely overloaded and doesn't really fits for LEO hardware.
> I think I will try to port old msm7k_udc.c driver from 2.6.35. It's =20
> much more simple.

I really want qemu support for this. Sigh. Are there public assembly =20
docs anywhere? (I had a giant printout brick circa 2010 but remember =20
almost nothing from it and gave it back when I left...)

> Also I found that adding "volatile" to variable declaration puts all =
=20
> accesses to it
> as not grouped into packets.

What I _do_ remember is that each instruction is 32 bits, and that one =
=20
of those bits is the grouping bit which is either on or off (I forget =20
which) to indicate the end of a packet.

If you build -O0 it sets the bit on every instruction, _and_ I think =20
feeds in NOPS to position instructions to go to the "right" cores when =
=20
you need to do something the first or second core can't do. (I think #3=
 =20
and #4 are identical, but could easily be wrong.)

> So it can be easy workaround for uncached memory access problem, =20
> instead of replacing
> everything to ioread32 and iowrite32.

Oh there's a CPU cache. The problem is the instruction dispatch is a =20
fraction of the clock speed, and the clock speed's low to begin with =20
(both to keep power consumption down). The speed comes entirely from =20
parallelism, you really need to take advantage of that on this chip or =
=20
performance is going to suck.

Rob--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
