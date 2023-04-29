From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Date: Sat, 29 Apr 2023 13:14:23 -0700 (PDT)
Message-ID: <mhng-7ec0443b-2201-41b7-996c-78c3a61f0230@palmer-ri-x1c9a>
References: <20230429063348.125544-1-npiggin@gmail.com>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682799264; x=1685391264;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvNXrGU7f9AyBgQxPAxIH8w5LQ2sGDY5VhYCeQmIsvg=;
        b=ztXNyujPGJ3TImj9rkWYO2n2FifWKitTQShNykqcCXMnlMDmDVUdGDZxkkAjoc2LxT
         wjlkNuWu5MpGZ0hx2IY/BfGicm00cVl+x8sMPYhvJYOTMhGVFNRcq+t2+IhK1Zbg1HBm
         TwPyb5IfXHXgdYm4kQQJO8mCutMWnoA0MAQG1HObQV2DkWdvKA82EPwFFy15NEoVvzDJ
         YaFLlQv2/hnRBo+Kg2l+LFcBMREq5GVfs5levwZlW+i9w9qFVpvKUrXtIKJRJqUd1KUC
         DRDHp5Z7Fs9kgbXLfeVSACxaLJ8vDKqbLXNf+pwsIg4BCZFLNo8FmqNy+hScbEds+O2l
         SL9w==
In-Reply-To: <20230429063348.125544-1-npiggin@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: Arnd Bergmann <arnd@arndb.de>, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, vgupta@kernel.org, linux-snps-arc@lists.infradead.org, bcain@quicinc.com, linux-hexagon@vger.kernel.org, chenhuacai@kernel.org, loongarch@lists.linux.dev, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, linux-openrisc@vger.kernel.org, James.Bottomley@HansenPartnership.com, deller@gmx.de, linux-parisc@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, li

On Fri, 28 Apr 2023 23:33:48 PDT (-0700), npiggin@gmail.com wrote:
> This option was created in commit 554b0004d0ec4 ("vtime: Add
> HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
> they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.
>
> The cputime_t type has since been removed, so this doesn't have any
> meaning. Remove it.
>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Hi,
>
> Could we tidy this? I don't know what tree it can go in, timers,
> sched, asm-generic, probably doesn't matter.
>
> The only thing this actually does is gate VIRT_CPU_ACCOUNTING_GEN and
> NO_HZ_FULL so if your arch has some other issue that requires this
> then the documentation needs to change. Any concerns from the archs?
> I.e., 32-bit that does *not* define HAVE_VIRT_CPU_ACCOUNTING_GEN
> which looks to be:
>
> arc
> hexagon
> loongarch 32-bit with SMP
> m68k
> microblaze
> mips 32-bit with SMP
> nios2
> openrisc
> parisc 32-bit
> riscv 32-bit

Nothing's jumping out, though I haven't tested this yet so I'm not 100%.  
I assume this isn't aimed for this merge window, given the timing?  
Probably best to give this sort of thing time to bake in linux-next, but 
I doubt anyone is even paying attention to rv32/NO_HZ_FULL so no big 
deal either way on my end.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

> sh
> sparc 32-bit
> um 32-bit
> x86 32-bit
>
> Thanks,
> Nick
