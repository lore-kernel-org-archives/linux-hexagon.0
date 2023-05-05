From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before
 bidirectional DMA
Date: Fri, 5 May 2023 13:47:03 +0800
Message-ID: <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-10-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683265636;
        bh=TmEJ43a9wRyU79Q4Z9WHv4VZR6aLeCdSzDRMZZtHgkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I2g+vyhe1hoLtc3xpRjAc9BU/OAumbEN1B7Qbc0uCZJ6vm38izq9WxgG6TDQIw9Cn
         gtD6rIxqmEHNa8rMU8v/ldvTpcVtaEF3DSdJwkdOmvdfZad8eHH3pZuMYUuPnRHXOF
         aYYdetp0cJMW6mFI28DiTiu7OK1/suDqFmm+PnshMDcFrjGxdV75SdkN4eyVXeCkzW
         HSaITHGNl7LHZa0zreUIjIqZKUUeH1GUas9yTSfl5gIOK4Nx3H8cZuqGu0g7MQUCMn
         LcnwJPgGPB8cca2qNfnc8SP0goqQZTmJ1qZnOLhwiQAwrnHXfTiUVeCmF7841pmmh4
         RSuO/9+XH4fLg==
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <>

On Mon, Mar 27, 2023 at 8:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
> first to let the device see data written by the CPU, and invalidated
> after the transfer to let the CPU see data written by the device.
>
> riscv also invalidates the caches before the transfer, which does
> not appear to serve any purpose.
Yes, we can't guarantee the CPU pre-load cache lines randomly during
dma working.

But I've two purposes to keep invalidates before dma transfer:
 - We clearly tell the CPU these cache lines are invalid. The caching
algorithm would use these invalid slots first instead of replacing
valid ones.
 - Invalidating is very cheap. Actually, flush and clean have the same
performance in our machine.

So, how about:

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoheren=
t.c
index d919efab6eba..2c52fbc15064 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -22,8 +22,6 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t s=
ize,
                ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
                break;
        case DMA_FROM_DEVICE:
-               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-               break;
        case DMA_BIDIRECTIONAL:
                ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
                break;
@@ -42,7 +40,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size=
,
                break;
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
                /* I'm not sure all drivers have guaranteed cacheline
alignment. If not, this inval would cause problems */
-               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+               ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
                break;
        default:
                break;

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index 640f4c496d26..69c80b2155a1 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t=
 size,
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         case DMA_BIDIRECTIONAL:
> -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         default:
>                 break;
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
