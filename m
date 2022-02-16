From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 15/18] sparc64: remove CONFIG_SET_FS support
Date: Wed, 16 Feb 2022 23:01:16 +0100
Message-ID: <CAK8P3a1kV=0G9WYkdjYCiBu=fuT1fbPGHVD9cgHX3ht6J3MFEw@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-16-arnd@kernel.org>
 <Yg1D08+olCSGmnYU@ravnborg.org> <Yg1FRZcrhlh5C//V@ravnborg.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645048894;
        bh=3GAgFKFSz4rrd4LtvDFKA/i0kbB+vNidxSnLES7CC90=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PmqZtAPQ8jm+06IO3B2Rv5fRROrQMNnQvWotR0srStYZ55QvmYnwNkxoJHkIp+2JO
         AVqNKyYOz3jKBBKy2IQjZi6kElAZ5xZKm4cstzsUcFi8OJbCDtXinwC+lBAG0Kspfv
         j4KEB/+z/qg5rsxzJPFnhxgZkp3vlZ87N7BmFP/KZojtrFxuhABgfVyssK+XTy50tx
         yIjZNZrmpv+d/GmxXVJtlcCXljyt9V2jjwg+cZzJg9AE7+KH14sNrO2oqwgGkshdJQ
         dwh+m0ZaItgHQ691RkIYXHtH9hK3sSviXzH3Xv6AyuPQdc48pm/GIV1nZ7hn73HjQ7
         oD/Q5Rjdb1ORw==
In-Reply-To: <Yg1FRZcrhlh5C//V@ravnborg.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>

On Wed, Feb 16, 2022 at 7:41 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Feb 16, 2022 at 07:34:59PM +0100, Sam Ravnborg wrote:

> >
> > I think you somehow missed the Kconfig change, and also the related
> > sparc32 change which continue to have set_fs() after this patch.

Right, thanks for pointing out the issue.

> I now notice the sparc32 bits are in the last patch.
> To avoid breaking bisect-ability on sparc64 I think you need to merge
> the sparc32 changes with this patch, unless the sparc64 changes can
> coexist with CONFIG_SET_FS continue to be set.

I originally had them in the reverse order and broke bisectability during my
rebase. The end result is still fine, but now I need to move the 'select
SET_FS' from CONFIG_SPARC to CONFIG_SPARC32 in this patch
and then remove it again from there in the last step.

I've done that in my local copy now.

         Arnd
