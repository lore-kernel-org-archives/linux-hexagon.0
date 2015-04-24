From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] Revert "Hexagon: fix signal.c compile error"
Date: Thu, 23 Apr 2015 23:59:25 -0400
Message-ID: <20150424035925.GU12496@vapier>
References: <1429752484-14499-1-git-send-email-vapier@gentoo.org>
 <20150423204036.GA5404@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O9T4zNOkGnr0n+A/"
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150423204036.GA5404@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org


--O9T4zNOkGnr0n+A/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23 Apr 2015 15:40, rkuo wrote:
> On Wed, Apr 22, 2015 at 09:28:04PM -0400, Mike Frysinger wrote:
> > This reverts commit f3f601c1d2728f02544cfd143eaa82e5398b3e9b.
> >=20
> > UAPI headers cannot use "uapi/" in their paths by design -- when they're
> > installed, they do not have the uapi/ prefix.  Otherwise doing so breaks
> > userland badly.
> >=20
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
> >  arch/hexagon/include/uapi/asm/signal.h | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/arch/hexagon/include/uapi/asm/signal.h b/arch/hexagon/incl=
ude/uapi/asm/signal.h
> > index 98106e5..24b9988 100644
> > --- a/arch/hexagon/include/uapi/asm/signal.h
> > +++ b/arch/hexagon/include/uapi/asm/signal.h
> > @@ -19,8 +19,6 @@
> >  #ifndef _ASM_SIGNAL_H
> >  #define _ASM_SIGNAL_H
> > =20
> > -#include <uapi/asm/registers.h>
> > -
> >  extern unsigned long __rt_sigtramp_template[2];
> > =20
> >  void do_signal(struct pt_regs *regs);
> > --=20
> > 2.3.5
> >=20
>=20
> I'll need to actually fix the thing the original commit was trying to fix,
> but I can follow up with another patch.

i was throwing the revert up as a straw man of sorts.  i've never used hexa=
gon=20
myself, so if someone wants to put together a better fix, then by all means.
-mike

--O9T4zNOkGnr0n+A/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVOb+dAAoJEEFjO5/oN/WBcS0P/iVOJYUoT5MUOitSo80MiIhm
omovtd0j2KtyAtY6NPKaFxvUPU4APhxLIVA0Is+/lqeUM/sfcJDxQkjzEXV7HyJW
zYOfOMrMqEboWerxOvmkcZfvkYz3dHuX7ehFm/q8Boi47RxsVDWOfStXrep+qssD
eoGkjGhAzbQzrxLV0//o/BzMhLGvGlMYd0B/eSzH4hefZaEVt1yrXDJo0MhIjPaL
rZP9tqXB44u9ylnybBOjmAw2SDvSVCHa9ZiI9bmOCT95gkny2SvjWKdYmgiDQUkU
IX1hW7PhtfwqoxRy7SP9g9zx47EByN6oB7MiTkpsF8l6Gkt+1pnv06b4SnunWOIK
jHQS2Jwa4gX1cCZdWnQViXJtKukySo6AWTzn56O2u6Ev3T4usQ938iEHjuI8H6TR
hS36nsHXd1CakQMwWf6N7I/bOKbYzisgqSduXxZ755q3xR0its7q1V8LGPKqYULb
Wip6+uIpLUuK3nksb3RmWN1Xxwqj7zHThulpixOjO8EvMpODOBC/BEf0mBXlLnb8
ZWsTClUsxUluTm8Rf6uTC0EYnG8GsY3kkuXcFdtAtKliHPUzWJDjZ16GFhMSzo28
c3NSgng0COAeceLIbmZD4CiZMQBUCIJ3vRx/0286Ec7iWwk2DLVfuak9r4iqVCxz
+GoVOPNlQZB7r/1Jryri
=+15w
-----END PGP SIGNATURE-----

--O9T4zNOkGnr0n+A/--
