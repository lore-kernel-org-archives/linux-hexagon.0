From: Zan Lynx <zlynx@acm.org>
Subject: Re: [patch 00/36] Hexagon: Add support for Qualcomm Hexagon
 architecture
Date: Wed, 17 Aug 2011 13:00:44 -0600
Message-ID: <1313607653.7431.3.camel@knife>
References: <20110817163457.878854582@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-VFpadi6cgDfbD80bpLr5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163457.878854582@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org


--=-VFpadi6cgDfbD80bpLr5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-08-17 at 11:34 -0500, Richard Kuo wrote:
> The following patch set is intended to add support for the Qualcomm Hexag=
on
> architecture to the Linux kernel.
>=20
> The Hexagon architecture is designed to deliver performance with low powe=
r
> over a variety of applications.  It has features such as multithreading,
> privilege levels, VLIW, and instructions geared toward efficient signal
> processing.  The port of Linux for Hexagon runs under a hypervisor layer.

I am curious about the hypervisor layer.

I can guess that it's an attempt to abstract away low level hardware
changes, a sort of software version of CPU microcode.

Or maybe it's a Transmeta kind of thing with dynamic recompilation into
a quickly evolving VLIW instruction set.

But what's the real reason?
--=20
Knowledge Is Power
Power Corrupts
Study Hard
Be Evil

--=-VFpadi6cgDfbD80bpLr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5MD9wACgkQ1IRuMHS+h7GFJQCffkjluJPTH1n+kN16LXh0r9DR
MxUAn2Jvv/zo7tPsxd0Bn+nd6aTrxFES
=8UrT
-----END PGP SIGNATURE-----

--=-VFpadi6cgDfbD80bpLr5--
