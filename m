From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 01/11] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Mon, 10 Oct 2022 08:17:02 +0800
Message-ID: <Y0NkfggJTI1q/Yvy@MiWiFi-R3L-srv>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-2-bhe@redhat.com>
 <83f292b8-0639-56b2-6dac-0475c34f623c@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665362538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDShjrzwK1jKnCnAs96UVbaV43RvPyzhTgdsrfXV+I8=;
        b=I22ABh3APGFcbDIJU8poyJ54tCLaX6DIh7KLj+nULmZwQMWuMQ6SQQHHn1A7Z3+tATG2zI
        wTi9Yvp/dactxKX7Z+sjjnjr5EQtA22jEhoBxvVA0/KceK2RYqCci3Xi/dTG317+0e4woS
        Ilusxu7jcHHzmNVwC9J0HqzcQOSSbXE=
Content-Disposition: inline
In-Reply-To: <83f292b8-0639-56b2-6dac-0475c34f623c@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hch@infradead.org" <hch@infradead.org>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>, "David.Laight@ACULAB.COM" <David.Laight@aculab.com>, "shorne@gmail.com" <shorne@gmail.com>, Brian Cain <bcain@quicinc.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>

On 10/09/22 at 04:39pm, Christophe Leroy wrote:
>=20
>=20
> Le 09/10/2022 =E0 12:31, Baoquan He a =E9crit=A0:
> > By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
> > iounmap() are visible and available to arch. Arch only needs to
> > provide implementation of arch_ioremap() or arch_iounmap() if there's
> > arch specific handling needed in its ioremap() or iounmap(). This
> > change will simplify implementation by removing duplicated codes with
> > generic ioremap() and iounmap(), and has the equivalent functioality.
> >=20
> > For hexagon, the current ioremap() and iounmap() are the same as
> > generic version. After taking GENERIC_IOREMAP way, the old ioremap()
> > and iounmap() can be completely removed.
> >=20
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Brian Cain <bcain@quicinc.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: linux-hexagon@vger.kernel.org
> > ---
> > v2->v3:
> >    Rewrite patch log.
> >    Put it at the beginning of patchset since it doesn't introduce new
> >    arch_ioremap()/arch_iounmap().
> >=20
> >   arch/hexagon/Kconfig          |  1 +
> >   arch/hexagon/include/asm/io.h |  9 +++++--
> >   arch/hexagon/mm/ioremap.c     | 44 -----------------------------------
> >   3 files changed, 8 insertions(+), 46 deletions(-)
> >   delete mode 100644 arch/hexagon/mm/ioremap.c
> >=20
> > diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> > index 54eadf265178..17afffde1a7f 100644
> > --- a/arch/hexagon/Kconfig
> > +++ b/arch/hexagon/Kconfig
> > @@ -25,6 +25,7 @@ config HEXAGON
> >   	select NEED_SG_DMA_LENGTH
> >   	select NO_IOPORT_MAP
> >   	select GENERIC_IOMAP
> > +	select GENERIC_IOREMAP
> >   	select GENERIC_SMP_IDLE_THREAD
> >   	select STACKTRACE_SUPPORT
> >   	select GENERIC_CLOCKEVENTS_BROADCAST
> > diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/i=
o.h
> > index 46a099de85b7..dcd9cbbf5934 100644
> > --- a/arch/hexagon/include/asm/io.h
> > +++ b/arch/hexagon/include/asm/io.h
> > @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void =
__iomem *addr)
> >   #define writew_relaxed __raw_writew
> >   #define writel_relaxed __raw_writel
> >  =20
> > -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> > -#define ioremap_uc(X, Y) ioremap((X), (Y))
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> > +		       (__HEXAGON_C_DEV << 6))
> > +
> > +#define ioremap_uc(addr, size) ioremap((addr), (size))
>=20
> Why do you need to change this macro ?

I don't like the X, Y since they look meaningless. I can change back if
you like the old one. Thanks for checking.

