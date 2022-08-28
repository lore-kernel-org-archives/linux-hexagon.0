From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Sun, 28 Aug 2022 23:12:07 +0800
Message-ID: <YwuFx8S13bkfpqao@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
 <f7642f34-80a8-3215-b441-b7432f6a22b1@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661699535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpY/8AdUR+vNQIgjLclSZmI7zrqsvBcdHsK7fFs0Xqc=;
        b=XWvSKpHkFX6/mHb19Rh53mdYfOzQ8f23LA59d7Tur+JxeG2SPOJq0naxuVg+0tWBans/qE
        Y8ZzRO9ewUzK/hWtOk0HDTzSTJsSJHe32OpMHIObK+b3fcB1eADxKMD9pEWJPFw3mthXbf
        blC+I5g9QTUx7aG1ONzGgddkWKlNT5E=
Content-Disposition: inline
In-Reply-To: <f7642f34-80a8-3215-b441-b7432f6a22b1@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hch@infradead.org" <hch@infradead.org>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Cain <bcain@quicinc.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>

On 08/22/22 at 06:38am, Christophe Leroy wrote:
>=20
>=20
> Le 20/08/2022 =E0 02:31, Baoquan He a =E9crit=A0:
> > With it, the old ioremap() and iounmap() can be perfectly removed
> > since they are duplicated with the standard functions.
>=20
> I see nothing related to the preparation patches. Could this have been=20
> converted without all previous patches ? In that case I think this one=20
> should go in the begining of the series, it would help see which=20
> architectecture really needs the changes to the generic parts.

You are right. Hexagon basically has the same implementation as standard
ioremap and iounmap code. I will move this at the beginning of patch
series in next round of post. Thanks for point this out.

>=20
> >=20
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Brian Cain <bcain@quicinc.com>
> > Cc: linux-hexagon@vger.kernel.org
> > ---
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
> > index c33241425a5c..e2d3091ec9d6 100644
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
> >  =20
> >  =20
> >   #define __raw_writel writel
> > diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
> > deleted file mode 100644
> > index 255c5b1ee1a7..000000000000
> > --- a/arch/hexagon/mm/ioremap.c
> > +++ /dev/null
> > @@ -1,44 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * I/O remap functions for Hexagon
> > - *
> > - * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> > - */
> > -
> > -#include <linux/io.h>
> > -#include <linux/vmalloc.h>
> > -#include <linux/mm.h>
> > -
> > -void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
> > -{
> > -	unsigned long last_addr, addr;
> > -	unsigned long offset =3D phys_addr & ~PAGE_MASK;
> > -	struct vm_struct *area;
> > -
> > -	pgprot_t prot =3D __pgprot(_PAGE_PRESENT|_PAGE_READ|_PAGE_WRITE
> > -					|(__HEXAGON_C_DEV << 6));
> > -
> > -	last_addr =3D phys_addr + size - 1;
> > -
> > -	/*  Wrapping not allowed  */
> > -	if (!size || (last_addr < phys_addr))
> > -		return NULL;
> > -
> > -	/*  Rounds up to next page size, including whole-page offset */
> > -	size =3D PAGE_ALIGN(offset + size);
> > -
> > -	area =3D get_vm_area(size, VM_IOREMAP);
> > -	addr =3D (unsigned long)area->addr;
> > -
> > -	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
> > -		vunmap((void *)addr);
> > -		return NULL;
> > -	}
> > -
> > -	return (void __iomem *) (offset + addr);
> > -}
> > -
> > -void iounmap(const volatile void __iomem *addr)
> > -{
> > -	vunmap((void *) ((unsigned long) addr & PAGE_MASK));
> > -}

