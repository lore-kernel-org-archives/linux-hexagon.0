From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH] init: consolidate trap_init()
Date: Wed, 14 Apr 2021 17:27:57 +0800
Message-ID: <20210414172757.3ebfaa4c@xhacker.debian>
References: <20210414165808.458a3d11@xhacker.debian>
        <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGn6HpN6f+b3HanJnFxiW4e/ZPzZpDDHYpCx/0xUmrs=;
 b=gCK3WosoSkUVj9o0NyAZtww7Lm4CfCxWPidNUpYLeMu6Sx5UhkNxCg24QQa67fD0uHkCEMHNTnFVZcOjBaa2cCpUBa9PoaEBFqfxPsW/Vf07Wth9USxbPqE0dTb/45+WUEE7s4KKB8aP3OTsrqTP+9NQk8lspmbrQc12JcEMy0s=
In-Reply-To: <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>

On Wed, 14 Apr 2021 11:10:42 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

>=20
> Le 14/04/2021 =C3=A0 10:58, Jisheng Zhang a =C3=A9crit :
> > Many architectures implement the trap_init() as NOP, since there is
> > no such default for trap_init(), this empty stub is duplicated among
> > these architectures. Provide a generic but weak NOP implementation
> > to drop the empty stubs of trap_init() in these architectures. =20
>=20
> You define the weak function in the __init section.
>=20
> Most but not all architectures had it in __init section.
>=20
> And the remaining ones may not be defined in __init section. For instance=
 look at the one in alpha
> architecture.
>=20
> Have you checked that it is not a problem ? It would be good to say somet=
hing about it in the commit
> description.

For those non-nop platforms, I can only test x86/arm64/, but both has
__init mark. I'm not sure whether this is a problem for alpha etc. Maybe
I can check which section the trap_init() sits. Or to avoid any possible
regression, I can add __init mark to those remaining ones without it in
preparation patches.

>=20
>=20
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >   arch/arc/kernel/traps.c      |  5 -----
> >   arch/arm/kernel/traps.c      |  5 -----
> >   arch/h8300/kernel/traps.c    | 13 -------------
> >   arch/hexagon/kernel/traps.c  |  4 ----
> >   arch/nds32/kernel/traps.c    |  5 -----
> >   arch/nios2/kernel/traps.c    |  5 -----
> >   arch/openrisc/kernel/traps.c |  5 -----
> >   arch/parisc/kernel/traps.c   |  4 ----
> >   arch/powerpc/kernel/traps.c  |  5 -----
> >   arch/riscv/kernel/traps.c    |  5 -----
> >   arch/um/kernel/trap.c        |  4 ----
> >   init/main.c                  |  2 ++
> >   12 files changed, 2 insertions(+), 60 deletions(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 53b278845b88..4bdbe2928530 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -790,6 +790,8 @@ static inline void initcall_debug_enable(void)
> >   }
> >   #endif
> >
> > +void __init __weak trap_init(void) { }
> > + =20
>=20
> I think in a C file we don't try to save space as much as in a header fil=
e.
>=20

This is to follow most weak NOP implementations in init/main.c to make
the style unified in the same file. I'm not sure which is better.

> I would prefer something like:
>=20
>=20
> void __init __weak trap_init(void)
> {
> }
>=20
>=20
> >   /* Report memory auto-initialization states for this boot. */
> >   static void __init report_meminit(void)
> >   {
> > =20

