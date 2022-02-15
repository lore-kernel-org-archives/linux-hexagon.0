From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 05/14] uaccess: add generic __{get,put}_kernel_nofault
Date: Tue, 15 Feb 2022 14:16:50 +0100
Message-ID: <CAK8P3a2+qG=Q9Si_2D7wjM7Qao2JCnYqKgU=W-SFwoG+fT-U3A@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-6-arnd@kernel.org>
 <Ygr0eAA+ZR1eX0wb@zeniv-ca.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644931028;
        bh=yV4ORJd5b6IZao4Zu1H2u9bAD/0nkvfeGMC8j+boEO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1UbQDYKVd/W55uCfVo2WGlgo3dfDZUC0yTFtlZUY0DOBzt83pgV9/7gMxh05e3AH
         lgukd8DqmxPwxja7mK4vtMYnDC6X4AvagIoktla5uPG7vSSfPBtEQFLrXn9FMcdgHH
         E1qEJeHLjvJUuBL6dqkrwsbxdH4jW8atiF/scjZBMC9lLF7Ype1WGnPRnqUer24JD8
         tu4gGKuwZtD0+Nibza1Ys9PPtyZzsqg7g90GGNebDRKc+NU4HRCxVmDtvM0+9S5mSP
         qhfZT5HIgJ8aWSTxW8hfUnfgxShZHe3y/AzzhEX87Jyr/ToKwZr4yc1EXWSuI0q6BQ
         u0/dxkrR5dDfA==
In-Reply-To: <Ygr0eAA+ZR1eX0wb@zeniv-ca.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.a>

On Tue, Feb 15, 2022 at 1:31 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:43PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > All architectures that don't provide __{get,put}_kernel_nofault() yet
> > can implement this on top of __{get,put}_user.
> >
> > Add a generic version that lets everything use the normal
> > copy_{from,to}_kernel_nofault() code based on these, removing the last
> > use of get_fs()/set_fs() from architecture-independent code.
>
> I'd put the list of those architectures (AFAICS, that's alpha, ia64,
> microblaze, nds32, nios2, openrisc, sh, sparc32, xtensa) into commit
> message - it's not that hard to find out, but...

done.

> And AFAICS, you've missed nios2 - see
> #define __put_user(x, ptr) put_user(x, ptr)
> in there.  nds32 oddities are dealt with earlier in the series, this
> one is not...

Ok, fixed my bug in nios2 __put_user() as well now. This one is not nearly
as bad as nds32, at least without my patches it should work as expected.

Unfortunately I also noticed that __get_user() on microblaze and nios2
is completely broken for 64-bit arguments, where these copy eight bytes
into a four byte buffer. I'll try to come up with a fix for this as well then.

         Arnd
