From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 10/21] csky: dma-mapping: skip invalidating before DMA
 from device
Date: Mon, 27 Mar 2023 21:37:22 +0800
Message-ID: <CAJF2gTT73KBZ01N2fr8z6=9XWFKo4D7cGKOtZLZeXN9NrscCXg@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-11-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679924255;
        bh=sKw5GnPYWTx1tEo+IYG63yzmzH5uUSkHi5W70RXeiXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=me5d4slZ7BQwLYQm0UbRAC2iVqyUYiUxghqwGTfCH/vpOgHLgDekGA1TBK2dJnpUc
         9WkLB4v/ufSmAfgCCV5YSuoaGaKiOwCqLyqumjx5XyRbF9dJBFFSs6HLt7PEmp891n
         XwMOQwvU37TpfHRmLM6F2Wu2rjJcr08TSj+OfMLw3e/eYNtc8Ff3gi22phENHfgyn4
         DNtHVC4q96uONAXntDKuUBjVgg2LmxrGjTx5EvWUGZrk2TnDCWrxinTYGMaEa37yw+
         smAD8fYPQMq6WbMRXe/30WkwvLcPhMLKpDQqlLl5O9Eqp+HZa9Zv6aqE9YRxyDLRSD
         1UErhgcXn+Ddg==
In-Reply-To: <20230327121317.4081816-11-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

On Mon, Mar 27, 2023 at 8:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> csky is the only architecture that does a full flush for the
> dma_sync_*_for_device(..., DMA_FROM_DEVICE) operation. The requirement
> is only make sure there are no dirty cache lines for the buffer,
> which can be either done through an invalidate operation (as on most
> architectures including arm32, mips and arc), or a writeback (as on
> arm64 and riscv). The cache also has to be invalidated eventually but
> csky already does that after the transfer.
>
> Use a 'clean' operation here for consistency with arm64 and riscv.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/mm/dma-mapping.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 82447029feb4..c90f912e2822 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -60,11 +60,9 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_=
t size,
>  {
>         switch (dir) {
>         case DMA_TO_DEVICE:
> -               cache_op(paddr, size, dma_wb_range);
> -               break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
> -               cache_op(paddr, size, dma_wbinv_range);
> +               cache_op(paddr, size, dma_wb_range);
Reviewed-by: Guo Ren <guoren@kernel.org>


>                 break;
>         default:
>                 BUG();
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
