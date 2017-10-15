From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/3] ARM, hexagon, c6x: build: fix usage of CFLAGS_MODULE, LDFLAGS_MODULE
Date: Sun, 15 Oct 2017 16:47:16 +0900
Message-ID: <CAK7LNATsU=tfgDJ6KjmqK7DwcKRL3DrvOPhP9Umn81zRKEO73g@mail.gmail.com>
References: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com v9F7lvfs005829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1508053678;
        bh=nFGaADYIvlx9urDO3ulHk9uIwBL0DMdjtGeMjA8T2Zo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=zWurdsg4BEhXViL7hZLXSUSMMRiTb8p1sU/+/+aG4dqKq1mYqk/lNCcOT5Y1IDDdg
         gNa52bvJO8Z7TWObwCeHhDMXGNRxs0MHNhxs1qpXwZuQlHvBhi2ehu4Fi0OCnVhRON
         d0NQ7zBKi55Ne70Itmycd3v0p6LcejSoee35wxuaT8Hk/m0OYSsNZWpgjLlq+KNLfq
         FZRLIOse+69fPpvm0PpJClWMqIKCIVU2FSCGAumjr/aO6/pp/MZmU315/RP/qK6+vt
         r2YEg74vngz5zWoF6GxY/Bw134HwLkLA9/BZFgmN6pJ8r31tTUEr6oebJoFkK0vLV1
         k8H6RDWwJMY8A==
In-Reply-To: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

2017-10-09 23:35 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> CFLAGS_MODULE, AFLAGS_MODULE, and LDFLAGS_MODULE are supposed
> to be set by users.
>
> In-kernel Makefile must use KBUILD_ prefixed variables.
>
> This is explained in Documentation/kbuild/{kbuild.txt, makefiles.txt}
>
> Most of architectures follow the rule, but I found violations
> in ARM, hexagone, and c6x.
>
> Fix them.
>
>
>
> Masahiro Yamada (3):
>   ARM: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
>   hexagon: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
>   c6x: add KBUILD_ prefix to CFLAGS_MODULE
>
>  arch/arm/Makefile     | 6 +++---
>  arch/c6x/Makefile     | 2 +-
>  arch/hexagon/Makefile | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
>

Series, applied to linux-kbuild/kbuild.



-- 
Best Regards
Masahiro Yamada
