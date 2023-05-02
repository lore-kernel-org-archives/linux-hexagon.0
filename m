From: "Nicholas Piggin" <npiggin@gmail.com>
Subject: Re: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Date: Wed, 03 May 2023 00:24:24 +1000
Message-ID: <CSBUZL6M3MSS.316JRNGXVMLB@wheely>
References: <20230429063348.125544-1-npiggin@gmail.com>
 <mhng-7ec0443b-2201-41b7-996c-78c3a61f0230@palmer-ri-x1c9a>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683037483; x=1685629483;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1aeen3ZK+Eot6IC/oOTAkZg5Jx6a7diThkYUUdZei0=;
        b=o7eV6bV5rpKciv6EIj9ga4Omoc8JiajzV/SXD9s6GTpCIHwLsqIeUrnFZuC+xAIaiW
         WjEsJu1B2GKv/VlyiP9foiCAZE6F++nD+BWDCHQtjX8GXp25FXxTTDqEhJfEaCmCRZnW
         r/TojnhdtU1uIxMuMFFOdIT7Ow7MxYnqTZbrKtm4QgaRKGsCrFqUlZThCmVisJrJf8LM
         /bNVZ2wUIhggAaUQvPy2HmP3xLnCZxM2nh9Oy/B1JiqMdIiCPGs2rAsKMpXcHd+3R9I1
         ZjnOJ4VKyNowo/00zxs8soF2kfewUpLu4llf08zWCp8MVLdUhOzj6mQ/SdBcj0q0dUoG
         ml+g==
In-Reply-To: <mhng-7ec0443b-2201-41b7-996c-78c3a61f0230@palmer-ri-x1c9a>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, vgupta@kernel.org, linux-snps-arc@lists.infradead.org, bcain@quicinc.com, linux-hexagon@vger.kernel.org, chenhuacai@kernel.org, loongarch@lists.linux.dev, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, linux-openrisc@vger.kernel.org, James.Bottomley@HansenPartnership.com, deller@gmx.de, linux-parisc@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, ysato@users.sourceforge.jp, dalias@libc.org

On Sun Apr 30, 2023 at 6:14 AM AEST, Palmer Dabbelt wrote:
> On Fri, 28 Apr 2023 23:33:48 PDT (-0700), npiggin@gmail.com wrote:
> > This option was created in commit 554b0004d0ec4 ("vtime: Add
> > HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
> > they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.
> >
> > The cputime_t type has since been removed, so this doesn't have any
> > meaning. Remove it.
> >
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Vineet Gupta <vgupta@kernel.org>
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: Brian Cain <bcain@quicinc.com>
> > Cc: linux-hexagon@vger.kernel.org
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: loongarch@lists.linux.dev
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: linux-mips@vger.kernel.org
> > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: linux-openrisc@vger.kernel.org
> > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-parisc@vger.kernel.org
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: linux-sh@vger.kernel.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: linux-um@lists.infradead.org
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Hi,
> >
> > Could we tidy this? I don't know what tree it can go in, timers,
> > sched, asm-generic, probably doesn't matter.
> >
> > The only thing this actually does is gate VIRT_CPU_ACCOUNTING_GEN and
> > NO_HZ_FULL so if your arch has some other issue that requires this
> > then the documentation needs to change. Any concerns from the archs?
> > I.e., 32-bit that does *not* define HAVE_VIRT_CPU_ACCOUNTING_GEN
> > which looks to be:
> >
> > arc
> > hexagon
> > loongarch 32-bit with SMP
> > m68k
> > microblaze
> > mips 32-bit with SMP
> > nios2
> > openrisc
> > parisc 32-bit
> > riscv 32-bit
>
> Nothing's jumping out, though I haven't tested this yet so I'm not 100%. =
=20
> I assume this isn't aimed for this merge window, given the timing? =20

No, maybe the next one though.

> Probably best to give this sort of thing time to bake in linux-next, but=
=20
> I doubt anyone is even paying attention to rv32/NO_HZ_FULL so no big=20
> deal either way on my end.
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

Thanks,
Nick
