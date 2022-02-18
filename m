From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
Date: Fri, 18 Feb 2022 08:10:25 +0100
Message-ID: <CAK8P3a3ac9Wo6fs+Wbdw3-WHfzF9vu_CZs5EUUTX-1iALUr54w@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-19-arnd@kernel.org>
 <20220218063714.GL22576@lst.de>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645168243;
        bh=U1L1tXaxAPzHw25B4dwwR3MsazfLjv3b5y7cZc7Ajbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j/ULvY2AEs1Y/Cc/kxwc99BmTDI+sKjegZezPUNxSiAEgZoi3zk3NcwNR6gaBuKas
         ddOX6bcsBLpCq/CBjJ7fKtrT9/0HR0zijquw1D+JV3/CePEugqsvEvUkh3c2rryUAn
         iGdWuSivzeB2X8B9lLMG5e/Ou+Jo88syE3wWjxK1CzqmTDy9Kpz5pQaOvGvZ4Wakvb
         r2oj8Wg46rfzApWhTiI1Sn7A5OPlL8MF46bCOLGSHQojALsR9kKZLx5uSZ2etiSHig
         HpB0AaGds98PKUvmte4NxXYBZGTza7B9MIYk8zB/lrmjqqbOX6/VfwhTTbMSwZXuXj
         no9lcx5EiWBUg==
In-Reply-To: <20220218063714.GL22576@lst.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.i>

On Fri, Feb 18, 2022 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> s/maining/remaining/ ?
>
> Or maybe rather:
>
> uaccess: remove CONFIG_SET_FS
>
> because it is all gone now.
>
> > With CONFIG_SET_FS gone, so drop all remaining references to
> > set_fs()/get_fs(), mm_segment_t and uaccess_kernel().
>
> And this sentence does not parse.

Both fixed now, thanks!

       Arnd
