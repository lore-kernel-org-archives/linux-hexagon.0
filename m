From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
Date: Wed, 23 Feb 2022 10:26:49 +0100
Message-ID: <CAK8P3a1nM3yPhjhMtUQyd5srgB99OkUvmapWv13KCuJXsf=euw@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-10-arnd@kernel.org>
 <20220223074127.GA8287@alpha.franken.de>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645608427;
        bh=D2jUPs6ryRSFqPbSylqUkNdDZuOthbzsmeMEmvziyjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qprkztvt/vehYNHRcEK8aqRshRS+P9DBpcRom+Ea4pnSLocGv1eBVL2v483vi1brP
         yniMjXK/S41L4Xb5GxmMolqLanH2PfdtLhr4aslEr3qRf3FRgZXiElzFJkvdC4w2nN
         JS6y8Uxpo3q6QV2cYcl6Kk1+VLa3u1w7dstKq6JdbSKRuvb7qsDfR1olUXgTRiM4lW
         h9gXptbf8SQ/Kn95+tqUCiEvk6NU1742fRGNTdgV5FXZ+Nd86Q2w5JlwL02OxgP5C1
         +ol87y0DUBe7bzeKEkX3OWQML5KSSUNMqefzAhTnHd6BCu3L5B6sV9dAoeIrCnSrMr
         hGVco4bZ15heQ==
In-Reply-To: <20220223074127.GA8287@alpha.franken.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Pe

On Wed, Feb 23, 2022 at 8:41 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> > diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> > index db9a8e002b62..d7c89dc3426c 100644
> > --- a/arch/mips/include/asm/uaccess.h
> > +++ b/arch/mips/include/asm/uaccess.h
> > @@ -19,6 +19,7 @@
> >  #ifdef CONFIG_32BIT
> >
> >  #define __UA_LIMIT 0x80000000UL
> > +#define TASK_SIZE_MAX        __UA_LIMIT
>
> using KSEG0 instead would IMHO be the better choice. This gives the
> chance to remove __UA_LIMIT completly after cleaning up ptrace.c

Ok, changed now.

      Arnd
