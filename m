From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 07/18] nios2: drop access_ok() check from __put_user()
Date: Thu, 24 Feb 2022 08:05:48 +0100
Message-ID: <CAK8P3a34OBFhncvg32hO3qb1uH8cvwFb0ro1jEMT4bdOLrtfdw@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-8-arnd@kernel.org>
 <c6f461f1-1dd9-aec1-2c85-a3eda478a1be@kernel.org>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645686366;
        bh=d3iTCnmjiWI2WfX8T3i0lRHp9N81t6Yh8Z7V7FwGN/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d9kZ0BbVkyCyNqDMbIIl+9W1OVaOiHcqpofy9Tv0x+jjG5DysO9+U6Q2K4lcdfFyH
         fai03dHJQzajxq5x8dD/JFbdF1zJckhozUk8lR9cVmlk5bBWd0W6ERB7Zbxdjefy3a
         B8/SUsADYD0SQguWOueuCsugHgBSJ8wqUkSLkiLSqKWedW5ys5Z7/z6mU2vQUHnHJ6
         T4vRyvf7dvKpTRGhlcWD3SzP2O+MDfjLinnJiEst0s0apfF0uwuaENIe6tuGMnmiQ2
         f1b6FsJH1WZrXXQHaNQBk/Ix0arInQgA572KGEYojkJ/0uUcVIi+T6URqFtcgb3eKx
         YzcfTkJH+KZ5w==
In-Reply-To: <c6f461f1-1dd9-aec1-2c85-a3eda478a1be@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.a>

On Thu, Feb 24, 2022 at 12:30 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
> On 2/16/22 07:13, Arnd Bergmann wrote: From: Arnd Bergmann <arnd@arndb.de>
> >
> > Unlike other architectures, the nios2 version of __put_user() has an
> > extra check for access_ok(), preventing it from being used to implement
> > __put_kernel_nofault().
> >
> > Split up put_user() along the same lines as __get_user()/get_user()
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Thanks! Could you also have a look at patch 2 (uaccess: fix nios2 and
microblaze get_user_8)? That one is actually more critical, and should
be backported to stable kernels.

       Arnd
