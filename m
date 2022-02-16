From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
Date: Wed, 16 Feb 2022 14:07:00 +0100
Message-ID: <CAK8P3a30supB-MNzhoELOerOemxwTfDFFqZrzmNDQA=WW+VLbw@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-12-arnd@kernel.org>
 <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645016838;
        bh=1AijW/WQHr1DB1sxEAf5u6qv337FtGM78rBteqtJsFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iN729W8eTzLUmDGyJvEI0HE0OkfEC9ALEUXFXgdGhQXPvSwBAbGx4Bm4JUzW2PC8s
         BUMcbAlGBg1oLv2VeML280237jVmEo5gaC6UDs56p3vjvFXfFS/uKYdSKjDuePRk1L
         ktHY4DZBfIfbMM+DZtBJsD1tLcjqddiWlefZ3tjDhL0ZaU2r/dIUVsti11RXTBoqeV
         Fv+44VNG8OJe97by5ltQ4+nZVecfzeBcTyXFP1Nn1XVJH9wwXssVksGeqND4hscY9C
         RdLVWj/y1SlCH/eoBwY9xia343UtnPrsFJT6xH3Aw2TalwP1wcgKbcKqShewHfbFGA
         MgV75zhrtRvrQ==
In-Reply-To: <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.a>

On Tue, Feb 15, 2022 at 1:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:49PM +0100, Arnd Bergmann wrote:
>
> > -/*
> > - * Sparc64 is segmented, though more like the M68K than the I386.
> > - * We use the secondary ASI to address user memory, which references a
> > - * completely different VM map, thus there is zero chance of the user
> > - * doing something queer and tricking us into poking kernel memory.
>
> Actually, this part of comment probably ought to stay - it is relevant
> for understanding what's going on (e.g. why is access_ok() always true, etc.)

Ok, I've put it back now.

       Arnd
