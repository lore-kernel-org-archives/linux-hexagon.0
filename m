From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 21/21] dma-mapping: replace custom code with generic implementation
Date: Tue, 27 Jun 2023 18:52:22 +0200
Message-ID: <CAMuHMdV5gT1GDLODsUe0XibPRsRHazF4K-UhxTOQCjtC9Ba4mQ@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-22-arnd@kernel.org>
 <OS0PR01MB5922EDAFCD6DA0313DB99C5E86989@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <66899d69-1339-4a61-8612-6f8e452b0b26@app.fastmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <66899d69-1339-4a61-8612-6f8e452b0b26@app.fastmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@arndb.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer

On Thu, Apr 13, 2023 at 2:52=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 13, 2023, at 14:13, Biju Das wrote:
> > FYI, this patch breaks on RZ/G2L SMARC EVK board and Arnd will send V2
> > for fixing this issue.
> >
> > [10:53] <biju> [    3.384408] Unable to handle kernel paging request at
> > virtual address 000000004afb0080
>
> Right, sorry about this, I accidentally removed the 'phys_to_virt()'
> conversion on arm64.

Meh, I missed that, so I ended up bisecting this same failure...

This patch is now commit 801f1883c4bb70cc ("dma-mapping: replace
custom code with generic implementation") in esmil/jh7100-dmapool,
and broke booting on R-Car Gen3.

The following gmail-whitespace-damaged patch fixes that:

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 97b7cea5eb23aedd..77e0b68b43e5849a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -15,17 +15,23 @@

 static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
 {
-       dcache_clean_poc(paddr, paddr + size);
+       unsigned long start =3D (unsigned long)phys_to_virt(paddr);
+
+       dcache_clean_poc(start, start + size);
 }

 static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
 {
-       dcache_inval_poc(paddr, paddr + size);
+       unsigned long start =3D (unsigned long)phys_to_virt(paddr);
+
+       dcache_inval_poc(start, start + size);
 }

 static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
-       dcache_clean_inval_poc(paddr, paddr + size);
+       unsigned long start =3D (unsigned long)phys_to_virt(paddr);
+
+       dcache_clean_inval_poc(start, start + size);
 }

 static inline bool arch_sync_dma_clean_before_fromdevice(void)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
