From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean() helper
Date: Mon, 3 Jul 2023 09:54:46 +0200
Message-ID: <CAMuHMdW5bXeE=nr7+hHxL+xhm2q05udkJpMBM-BG7g9S7Nt7Zg@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-21-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20230327121317.4081816-21-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

Hi Arnd,

On Mon, Mar 27, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The arm version of the arch_sync_dma_for_cpu() function annotates pages as
> PG_dcache_clean after a DMA, but no other architecture does this here. On
> ia64, the same thing is done in arch_sync_dma_for_cpu(), so it makes sense
> to use the same hook in order to have identical arch_sync_dma_for_cpu()
> semantics as all other architectures.
>
> Splitting this out has multiple effects:
>
>  - for dma-direct, this now gets called after arch_sync_dma_for_cpu()
>    for DMA_FROM_DEVICE mappings, but not for DMA_BIDIRECTIONAL. While
>    it would not be harmful to keep doing it for bidirectional mappings,
>    those are apparently not used in any callers that care about the flag.
>
>  - Since arm has its own dma-iommu abstraction, this now also needs to
>    call the same function, so the calls are added there to mirror the
>    dma-direct version.
>
>  - Like dma-direct, the dma-iommu version now marks the dcache clean
>    for both coherent and noncoherent devices after a DMA, but it only
>    does this for DMA_FROM_DEVICE, not DMA_BIDIRECTIONAL.
>
> [ HELP NEEDED: can anyone confirm that it is a correct assumption
>   on arm that a cache-coherent device writing to a page always results
>   in it being in a PG_dcache_clean state like on ia64, or can a device
>   write directly into the dcache?]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch, which is now commit 322dbe898f82fd8a
("ARM: dma-mapping: split out arch_dma_mark_clean() helper") in
esmil/jh7100-dmapool.

If CONFIG_ARM_DMA_USE_IOMMU=3Dy, the build fails.

> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c

> @@ -1294,6 +1298,17 @@ static int arm_iommu_map_sg(struct device *dev, st=
ruct scatterlist *sg,
>         return -EINVAL;
>  }
>
> +static void arm_iommu_sync_dma_for_cpu(phys_addr_t phys, size_t len,
> +                                      enum dma_data_direction dir,
> +                                      bool dma_coherent)
> +{
> +       if (!dma_coherent)
> +               arch_sync_dma_for_cpu(phys, s->length, dir);

s/s->length/len/

> +
> +       if (dir =3D=3D DMA_FROM_DEVICE)
> +               arch_dma_mark_clean(phys, s->length);

Likewise.

> +}
> +
>  /**
>   * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
>   * @dev: valid struct device pointer

> @@ -1425,9 +1438,9 @@ static void arm_iommu_unmap_page(struct device *dev=
, dma_addr_t handle,
>         if (!iova)
>                 return;
>
> -       if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> +       if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))

Missing opening curly brace.

>                 phys =3D iommu_iova_to_phys(mapping->domain, handle);
> -               arch_sync_dma_for_cpu(phys, size, dir);
> +               arm_iommu_sync_dma_for_cpu(phys, size, dir, dev->dma_cohe=
rent);
>         }
>
>         iommu_unmap(mapping->domain, iova, len);

With the above fixed, it builds and boots fine (on R-Car M2-W).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
