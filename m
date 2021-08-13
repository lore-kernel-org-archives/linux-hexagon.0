From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH -next] trap: Cleanup trap_init()
Date: Fri, 13 Aug 2021 12:27:58 +1000
Message-ID: <87czqim635.fsf@mpe.ellerman.id.au>
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1628821695;
        bh=jlHWtsgYmZ30B2WJN0Jw5XD8BZs0Z7qm5rWOQviWRxQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iQqdFqNsp0RRZI3qzmEc8DvXwIl+xP6sqn6MkAu1yNyVEEqSByPkt7fyHM+X9Mkc1
         H5RsYWUWRX8EIeuJJ4pqVwfnttonPEDoUI6iLblU3xQm7I/dYs830ptXGtqFnm8msw
         bQaEGG6Y/DzH1CN1Mvvb00KGwJKu//Dz61HaxwsLpsn/iRop+KxRmApjk7hRSxfG8F
         cG79DxTOVkrHCCl0Z+JjvfFI1Us2ePvxaJcd/q1n8XQPkD29Snt/5eadLOKqEw4s5I
         wyuWWaQ6HM0csDFNLWQbGqs6kWuET5VesHnFV3cwA2hGTS/6dU1L+U6SqYdZgv1Mhm
         jRnaImnD2vgxw==
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <palmerdabbelt@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> There are some empty trap_init() in different ARCHs, introduce
> a new weak trap_init() function to cleanup them.
>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <palmerdabbelt@google.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arc/kernel/traps.c      | 5 -----
>  arch/arm/kernel/traps.c      | 5 -----
>  arch/h8300/kernel/traps.c    | 4 ----
>  arch/hexagon/kernel/traps.c  | 4 ----
>  arch/nds32/kernel/traps.c    | 5 -----
>  arch/nios2/kernel/traps.c    | 5 -----
>  arch/openrisc/kernel/traps.c | 5 -----
>  arch/parisc/kernel/traps.c   | 4 ----
>  arch/powerpc/kernel/traps.c  | 5 -----

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
