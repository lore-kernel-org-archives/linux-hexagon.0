From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 00/17] -Wmissing-prototype warning fixes
Date: Wed, 16 Aug 2023 07:38:47 -0700 (PDT)
Message-ID: <mhng-ce493a2d-71e9-440f-84d0-522a4f694bbe@palmer-ri-x1c9>
References: <20230810141947.1236730-1-arnd@kernel.org>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To:
	Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=GvX49tcbPSCVEBBS9oLI8yW9FtnCS3+mfK8x+YdPzgQ=; b=CARw1ap5vD6wIwWHU51Q1BlyiC
	dihXSuBJ8ZOIQgqABiiqkc6fO02PNb+gYG+EmUMKnRKUuSBxZjvvZVvzBIAqqkN/r7PL4szOb/YKN
	hkE9EY+O8NHR4goFCNabYzOf80ZBUbCjGSXkEj4GMN3JezTDsElFcz1nM9Lw5NT0IMZnNTjxl3Ds8
	ChO5mIw76CZGRDCOdZYfYKXsQAcY872D90qVPhi7dPx2WAm6PPw67luwwARSfoEy/D5rn7BLXMWTW
	c5cGbRRtX0+4dKAg0tMsGmmXJgtXGh4wHaPlaEXO07QXvefO14/IPFbIRyxg4Du2iXv2FtHntNDDm
	tt1X1TfQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1692196728; x=1692801528;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7kyCuHl1t/gCCGpNTbA3hwFj/lf6SuaKvtbsxGuDBs=;
        b=dZxL0Ptmo/RfqSZAnaNdMqEON3wvqTtz9rCCZbGwRlxrXd7njXeZ9MC0HoDMQnzbMm
         Mbp7gkbEr8As7DndYa19Nv36eYd2hToSSCFzF826MiTxJFQPanB3TDkisU5ug1n2xO0x
         lqvfBU8gjYGcjvzm7z1KhnYi76zAKQMvLjSkKN8VKcgO7yrfcLxnnczFGmL7s8fYvGKe
         iupXY/7su7eB4Qp8Ot15WegMitq0aXkC7C2B4amBqtpQq9iCTqbSvz7oVYvokSqAF4SL
         qE7Cmnt2iThlim9z5xca3mEZ27llu2nfrUpa7hwX8WY7UkN0OSfjH/LjoRTW/fMpY9+M
         GNdA==
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: arnd@kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, christophe.leroy@csgroup.eu, hca@linux.ibm.com, glaubitz@physik.fu-berlin.de, x86@kernel.org, bp@alien8.de, jcmvbkbc@gmail.com, axboe@kernel.dk, sudipm.mukherjee@gmail.com, martin.petersen@oracle.com, richard@nod.at, bhelgaas@google.com, masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com, linux@roeck-us.net, Stephen

On Thu, 10 Aug 2023 07:19:18 PDT (-0700), arnd@kernel.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most of the patches I sent so far for the -Wmissing-prototype warnings
> have made it into linux-next now. There are a few that I'm resending
> now as nobody has picked them up, and then a number of fixes that I
> found while test-building across all architectures rather than just the
> ones I usually test.
>
> The first 15 patches in this series should be uncontroversial, so
> I expect that either a subsystem maintainer or Andrew Morton can
> apply these directly.
>
> For the last two patches, these might still need some debate about how
> to handle them. I added a Kconfig option to turn off most of the missing
> prototype warnings in the architectures that nobody has fixed yet,
> see patch 16 for those. The last patch does cause some known warnings
> and likely unknown ones for architectures other than x86 and arm,
> so applying it now will bring new problems, but not applying it also
> means that new warnings creep in, so I think this is mainly a question
> of what the best timing is for having this in linux-next.
>
> Arnd Bergmann (17):
>   [RESEND] jffs2: mark __jffs2_dbg_superblock_counts() static
>   [RESEND] irq_work: consolidate arch_irq_work_raise prototypes
>   [RESEND] ida: make 'ida_dump' static
>   pci: sysfs: move declarations to linux/pci.h
>   swim3: mark swim3_init() static
>   macintosh/ams: mark ams_init() static
>   scsi: qlogicpti: mark qlogicpti_info() static
>   microblaze: mark flush_dcache_folio() inline
>   parport: gsc: mark init function static
>   zorro: include zorro.h in names.c
>   scsi: gvp11: remove unused gvp11_setup() function
>   time: make sysfs_get_uname() function visible in header
>   stackleak: add declarations for global functions
>   kprobes: unify kprobes_exceptions_nofify() prototypes
>   arch: fix asm-offsets.c building with -Wmissing-prototypes
>   [RFC] arch: turn -Wmissing-prototypes off conditionally
>   [RFC] Makefile.extrawarn: turn on missing-prototypes again
>
>  arch/alpha/Kbuild                        |  2 ++
>  arch/alpha/include/asm/pci.h             |  3 ---
>  arch/alpha/kernel/asm-offsets.c          |  2 +-
>  arch/alpha/lib/Makefile                  |  1 +
>  arch/arc/Kbuild                          |  2 ++
>  arch/arc/include/asm/kprobes.h           |  3 ---
>  arch/arm/include/asm/irq_work.h          |  2 --
>  arch/arm/include/asm/kprobes.h           |  2 --
>  arch/arm64/include/asm/irq_work.h        |  2 --
>  arch/arm64/include/asm/kprobes.h         |  2 --
>  arch/csky/Kbuild                         |  2 ++
>  arch/csky/include/asm/irq_work.h         |  2 +-
>  arch/hexagon/Kbuild                      |  2 ++
>  arch/ia64/Kbuild                         |  2 ++
>  arch/ia64/include/asm/kprobes.h          |  2 --
>  arch/ia64/kernel/asm-offsets.c           |  2 +-
>  arch/ia64/lib/Makefile                   |  1 +
>  arch/loongarch/Kbuild                    |  2 ++
>  arch/loongarch/kernel/asm-offsets.c      | 12 ++++++++++++
>  arch/m68k/Kbuild                         |  2 ++
>  arch/m68k/lib/Makefile                   |  1 +
>  arch/microblaze/Kbuild                   |  2 ++
>  arch/microblaze/include/asm/cacheflush.h |  2 +-
>  arch/mips/Kbuild                         |  2 ++
>  arch/mips/boot/compressed/Makefile       |  3 ++-
>  arch/mips/include/asm/kprobes.h          |  2 --
>  arch/nios2/Kbuild                        |  2 ++
>  arch/nios2/lib/Makefile                  |  1 +
>  arch/openrisc/Kbuild                     |  2 ++
>  arch/parisc/Kbuild                       |  2 ++
>  arch/parisc/lib/Makefile                 |  1 +
>  arch/powerpc/include/asm/irq_work.h      |  1 -
>  arch/powerpc/include/asm/kprobes.h       |  2 --
>  arch/riscv/include/asm/irq_work.h        |  2 +-
>  arch/s390/include/asm/irq_work.h         |  2 --
>  arch/s390/include/asm/kprobes.h          |  2 --
>  arch/sh/Kbuild                           |  2 ++
>  arch/sh/boot/compressed/Makefile         |  1 +
>  arch/sh/include/asm/kprobes.h            |  2 --
>  arch/sparc/Kbuild                        |  2 ++
>  arch/sparc/include/asm/kprobes.h         |  2 --
>  arch/sparc/kernel/asm-offsets.c          | 13 ++-----------
>  arch/sparc/lib/Makefile                  |  1 +
>  arch/sparc/prom/Makefile                 |  1 +
>  arch/x86/include/asm/irq_work.h          |  1 -
>  arch/x86/include/asm/kprobes.h           |  2 --
>  arch/xtensa/Kbuild                       |  2 ++
>  arch/xtensa/boot/lib/Makefile            |  2 ++
>  drivers/block/swim3.c                    |  2 +-
>  drivers/macintosh/ams/ams-core.c         |  2 +-
>  drivers/parport/parport_gsc.c            |  2 +-
>  drivers/scsi/gvp11.c                     |  5 -----
>  drivers/scsi/qlogicpti.c                 |  2 +-
>  drivers/zorro/names.c                    |  1 +
>  fs/jffs2/debug.c                         |  2 +-
>  include/linux/irq_work.h                 |  3 +++
>  include/linux/kprobes.h                  |  4 ++++
>  include/linux/pci.h                      |  5 +++++
>  include/linux/stackleak.h                |  6 ++++++
>  init/Kconfig                             | 10 ++++++++++
>  kernel/time/tick-internal.h              |  3 ++-
>  lib/test_ida.c                           |  2 +-
>  scripts/Makefile.extrawarn               |  5 +++--
>  63 files changed, 101 insertions(+), 63 deletions(-)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V
