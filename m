From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 07/13] powerpc: add support for folded p4d page tables
Date: Wed, 19 Feb 2020 14:24:20 +0100
Message-ID: <20200219132420.GA5559@hump>
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216081843.28670-8-rppt@kernel.org>
 <5b7c3929-5833-8ceb-85c8-a8e92e6a138e@c-s.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-ppc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582118681;
        bh=WeK8iDiz+u7KGQl8xdyYvIuPvj8pRW13k3gZGmGmUOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrDKTg0KsoKO1U07yyagx89/mJ6hieOjLuM/lo6w3mB9Y9R+aQAidXZSv/ywuM3au
         r4bYkFE2ZGGFM/SSIBeOb3LJun+6yquvbVIUq2PH+U+U65CCtHToRoSUxXZ4LnlfNf
         XO/4CZv966+4qxBk+L+tbRqcMNDfbzR2x3+83oH0=
Content-Disposition: inline
In-Reply-To: <5b7c3929-5833-8ceb-85c8-a8e92e6a138e@c-s.fr>
Sender: kvm-ppc-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guan Xuetao <gxt@pku.edu.cn>, James Morse <james.morse@arm.com>, Jonas Bonn <jonas@southpole.se>, Julien Thierry <julien.thierry.kdev@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristian>

On Wed, Feb 19, 2020 at 01:07:55PM +0100, Christophe Leroy wrote:
>=20
> Le 16/02/2020 =E0 09:18, Mike Rapoport a =E9crit=A0:
> > diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/p=
tdump.c
> > index 206156255247..7bd4b81d5b5d 100644
> > --- a/arch/powerpc/mm/ptdump/ptdump.c
> > +++ b/arch/powerpc/mm/ptdump/ptdump.c
> > @@ -277,9 +277,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pu=
d, unsigned long start)
> >   	}
> >   }
> > -static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long st=
art)
> > +static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long st=
art)
> >   {
> > -	pud_t *pud =3D pud_offset(pgd, 0);
> > +	pud_t *pud =3D pud_offset(p4d, 0);
> >   	unsigned long addr;
> >   	unsigned int i;
> > @@ -293,6 +293,22 @@ static void walk_pud(struct pg_state *st, pgd_t *p=
gd, unsigned long start)
> >   	}
> >   }
> > +static void walk_p4d(struct pg_state *st, pgd_t *pgd, unsigned long st=
art)
> > +{
> > +	p4d_t *p4d =3D p4d_offset(pgd, 0);
> > +	unsigned long addr;
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < PTRS_PER_P4D; i++, p4d++) {
> > +		addr =3D start + i * P4D_SIZE;
> > +		if (!p4d_none(*p4d) && !p4d_is_leaf(*p4d))
> > +			/* p4d exists */
> > +			walk_pud(st, p4d, addr);
> > +		else
> > +			note_page(st, addr, 2, p4d_val(*p4d));
>=20
> Level 2 is already used by walk_pud().
>=20
> I think you have to increment the level used in walk_pud() and walk_pmd()
> and walk_pte()

Thanks for catching this!
I'll fix the numbers in the next version.
=20
> > +	}
> > +}
> > +
> >   static void walk_pagetables(struct pg_state *st)
> >   {
> >   	unsigned int i;
> > @@ -306,7 +322,7 @@ static void walk_pagetables(struct pg_state *st)
> >   	for (i =3D pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr +=3D =
PGDIR_SIZE) {
> >   		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
> >   			/* pgd exists */
> > -			walk_pud(st, pgd, addr);
> > +			walk_p4d(st, pgd, addr);
> >   		else
> >   			note_page(st, addr, 1, pgd_val(*pgd));
> >   	}
>=20
> Christophe

--=20
Sincerely yours,
Mike.
