From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH] init: consolidate trap_init()
Date: Wed, 14 Apr 2021 17:38:32 +0800
Message-ID: <20210414173832.52bc3ddb@xhacker.debian>
References: <20210414165808.458a3d11@xhacker.debian>
        <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
        <20210414172757.3ebfaa4c@xhacker.debian>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1zZJXr025wCYwZ03VgZPHTWfFdwlmtq4D6SWbnexTA=;
 b=M6SH2r//uRhJor0lzgJmoIeFfIb0I0l8XmqZWqkyWyNt74wIDeuZYSt5ErscuH9jqngrUtzrobE+Deib0ozGSKkum7z8XML/6PBurUhXCxCSWJpIsy9YDbwCknFb+D3CUH8xjcvnPanVC9BzFJ4RbCgHVaVORD1XcszpkFUq184=
In-Reply-To: <20210414172757.3ebfaa4c@xhacker.debian>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>

On Wed, 14 Apr 2021 17:27:57 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> CAUTION: Email originated externally, do not click links or open attachme=
nts unless you recognize the sender and know the content is safe.
>=20
>=20
> On Wed, 14 Apr 2021 11:10:42 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>=20
> >
> > Le 14/04/2021 =C3=A0 10:58, Jisheng Zhang a =C3=A9crit : =20
> > > Many architectures implement the trap_init() as NOP, since there is
> > > no such default for trap_init(), this empty stub is duplicated among
> > > these architectures. Provide a generic but weak NOP implementation
> > > to drop the empty stubs of trap_init() in these architectures. =20
> >
> > You define the weak function in the __init section.
> >
> > Most but not all architectures had it in __init section.
> >
> > And the remaining ones may not be defined in __init section. For instan=
ce look at the one in alpha
> > architecture.
> >
> > Have you checked that it is not a problem ? It would be good to say som=
ething about it in the commit
> > description. =20
>=20
> For those non-nop platforms, I can only test x86/arm64/, but both has
> __init mark. I'm not sure whether this is a problem for alpha etc. Maybe
> I can check which section the trap_init() sits. Or to avoid any possible
> regression, I can add __init mark to those remaining ones without it in
> preparation patches.
>=20

Hi,

I found only three platforms don't have the __init marker for trap_init(), =
I
will add the __init marker in three preparation patches in new version.

thanks
