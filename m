From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Date: Fri, 13 Jan 2023 10:06:36 -0800
Message-ID: <20230113180636.GA4028633@paulmck-ThinkPad-P17-Gen-1>
References: <20230112194314.845371875@infradead.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673633197;
        bh=9JM2l3wQvAeTEYaZAWr5I3gZoNrgDAq2iaamsrQXne0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d/TyPrfu3TMN3RDQxpqP5fajACgLxUzrO1o0lviquPae0CCREqyfMhbNaFpmIDnAD
         gc9rcn8tXi7SZ4Sa6feTIN2Ae1ZeCBFbV5dmTzybf+txFmSo/tzOIYxAQ5C/w8Dqvn
         lUFscWLbHB7PxSvBS0qnt6QQanZXshhTtjgmZdd4dd7UYrIROlbOAFQjGgiw28eaXg
         ZWAP2DT2ukYPCwIGpUnzoCfZFD2NIBDmWoE7vSQ2LoozWiuoZLz82Zhhis8k4Jr+Bj
         yNgUqYimkNr/a2hjrvrPsnsWtLyOCrg7bz13Vy3HC3zIgb+UrU6VBUs4Zs2yFiDWYy
         hI2RWs0YaghDg==
Content-Disposition: inline
In-Reply-To: <20230112194314.845371875@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au

On Thu, Jan 12, 2023 at 08:43:14PM +0100, Peter Zijlstra wrote:
> Hi All!
> 
> The (hopefully) final respin of cpuidle vs rcu cleanup patches. Barring any
> objections I'll be queueing these patches in tip/sched/core in the next few
> days.
> 
> v2: https://lkml.kernel.org/r/20220919095939.761690562@infradead.org
> 
> These here patches clean up the mess that is cpuidle vs rcuidle.
> 
> At the end of the ride there's only on RCU_NONIDLE user left:
> 
>   arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());
> 
> And I know Mark has been prodding that with something sharp.
> 
> The last version was tested by a number of people and I'm hoping to not have
> broken anything in the meantime ;-)
> 
> 
> Changes since v2:

150 rcutorture hours on each of the default scenarios passed.  This
is qemu/KVM on x86:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

>  - rebased to v6.2-rc3; as available at:
>      git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
> 
>  - folded: https://lkml.kernel.org/r/Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net
>    which makes the ARM cpuidle index 0 consistently not use
>    CPUIDLE_FLAG_RCU_IDLE, as requested by Ulf.
> 
>  - added a few more __always_inline to empty stub functions as found by the
>    robot.
> 
>  - Used _RET_IP_ instead of _THIS_IP_ in a few placed because of:
>    https://github.com/ClangBuiltLinux/linux/issues/263
> 
>  - Added new patches to address various robot reports:
> 
>      #35:  trace,hardirq: No moar _rcuidle() tracing
>      #47:  cpuidle: Ensure ct_cpuidle_enter() is always called from noinstr/__cpuidle
>      #48:  cpuidle,arch: Mark all ct_cpuidle_enter() callers __cpuidle
>      #49:  cpuidle,arch: Mark all regular cpuidle_state::enter methods __cpuidle
>      #50:  cpuidle: Comments about noinstr/__cpuidle
>      #51:  context_tracking: Fix noinstr vs KASAN
> 
> 
> ---
>  arch/alpha/kernel/process.c               |  1 -
>  arch/alpha/kernel/vmlinux.lds.S           |  1 -
>  arch/arc/kernel/process.c                 |  3 ++
>  arch/arc/kernel/vmlinux.lds.S             |  1 -
>  arch/arm/include/asm/vmlinux.lds.h        |  1 -
>  arch/arm/kernel/cpuidle.c                 |  4 +-
>  arch/arm/kernel/process.c                 |  1 -
>  arch/arm/kernel/smp.c                     |  6 +--
>  arch/arm/mach-davinci/cpuidle.c           |  4 +-
>  arch/arm/mach-gemini/board-dt.c           |  3 +-
>  arch/arm/mach-imx/cpuidle-imx5.c          |  4 +-
>  arch/arm/mach-imx/cpuidle-imx6q.c         |  8 ++--
>  arch/arm/mach-imx/cpuidle-imx6sl.c        |  4 +-
>  arch/arm/mach-imx/cpuidle-imx6sx.c        |  9 ++--
>  arch/arm/mach-imx/cpuidle-imx7ulp.c       |  4 +-
>  arch/arm/mach-omap2/common.h              |  6 ++-
>  arch/arm/mach-omap2/cpuidle34xx.c         | 16 ++++++-
>  arch/arm/mach-omap2/cpuidle44xx.c         | 29 +++++++------
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c | 12 +++++-
>  arch/arm/mach-omap2/pm.h                  |  2 +-
>  arch/arm/mach-omap2/pm24xx.c              | 51 +---------------------
>  arch/arm/mach-omap2/pm34xx.c              | 14 +++++--
>  arch/arm/mach-omap2/pm44xx.c              |  2 +-
>  arch/arm/mach-omap2/powerdomain.c         | 10 ++---
>  arch/arm/mach-s3c/cpuidle-s3c64xx.c       |  5 +--
>  arch/arm64/kernel/cpuidle.c               |  2 +-
>  arch/arm64/kernel/idle.c                  |  1 -
>  arch/arm64/kernel/smp.c                   |  4 +-
>  arch/arm64/kernel/vmlinux.lds.S           |  1 -
>  arch/csky/kernel/process.c                |  1 -
>  arch/csky/kernel/smp.c                    |  2 +-
>  arch/csky/kernel/vmlinux.lds.S            |  1 -
>  arch/hexagon/kernel/process.c             |  1 -
>  arch/hexagon/kernel/vmlinux.lds.S         |  1 -
>  arch/ia64/kernel/process.c                |  1 +
>  arch/ia64/kernel/vmlinux.lds.S            |  1 -
>  arch/loongarch/kernel/idle.c              |  1 +
>  arch/loongarch/kernel/vmlinux.lds.S       |  1 -
>  arch/m68k/kernel/vmlinux-nommu.lds        |  1 -
>  arch/m68k/kernel/vmlinux-std.lds          |  1 -
>  arch/m68k/kernel/vmlinux-sun3.lds         |  1 -
>  arch/microblaze/kernel/process.c          |  1 -
>  arch/microblaze/kernel/vmlinux.lds.S      |  1 -
>  arch/mips/kernel/idle.c                   | 14 +++----
>  arch/mips/kernel/vmlinux.lds.S            |  1 -
>  arch/nios2/kernel/process.c               |  1 -
>  arch/nios2/kernel/vmlinux.lds.S           |  1 -
>  arch/openrisc/kernel/process.c            |  1 +
>  arch/openrisc/kernel/vmlinux.lds.S        |  1 -
>  arch/parisc/kernel/process.c              |  2 -
>  arch/parisc/kernel/vmlinux.lds.S          |  1 -
>  arch/powerpc/kernel/idle.c                |  5 +--
>  arch/powerpc/kernel/vmlinux.lds.S         |  1 -
>  arch/riscv/kernel/process.c               |  1 -
>  arch/riscv/kernel/vmlinux-xip.lds.S       |  1 -
>  arch/riscv/kernel/vmlinux.lds.S           |  1 -
>  arch/s390/kernel/idle.c                   |  1 -
>  arch/s390/kernel/vmlinux.lds.S            |  1 -
>  arch/sh/kernel/idle.c                     |  1 +
>  arch/sh/kernel/vmlinux.lds.S              |  1 -
>  arch/sparc/kernel/leon_pmc.c              |  4 ++
>  arch/sparc/kernel/process_32.c            |  1 -
>  arch/sparc/kernel/process_64.c            |  3 +-
>  arch/sparc/kernel/vmlinux.lds.S           |  1 -
>  arch/um/kernel/dyn.lds.S                  |  1 -
>  arch/um/kernel/process.c                  |  1 -
>  arch/um/kernel/uml.lds.S                  |  1 -
>  arch/x86/boot/compressed/vmlinux.lds.S    |  1 +
>  arch/x86/coco/tdx/tdcall.S                | 15 +------
>  arch/x86/coco/tdx/tdx.c                   | 25 ++++-------
>  arch/x86/events/amd/brs.c                 | 13 +++---
>  arch/x86/include/asm/fpu/xcr.h            |  4 +-
>  arch/x86/include/asm/irqflags.h           | 11 ++---
>  arch/x86/include/asm/mwait.h              | 14 +++----
>  arch/x86/include/asm/nospec-branch.h      |  2 +-
>  arch/x86/include/asm/paravirt.h           |  6 ++-
>  arch/x86/include/asm/perf_event.h         |  2 +-
>  arch/x86/include/asm/shared/io.h          |  4 +-
>  arch/x86/include/asm/shared/tdx.h         |  1 -
>  arch/x86/include/asm/special_insns.h      |  8 ++--
>  arch/x86/include/asm/xen/hypercall.h      |  2 +-
>  arch/x86/kernel/cpu/bugs.c                |  2 +-
>  arch/x86/kernel/fpu/core.c                |  4 +-
>  arch/x86/kernel/paravirt.c                | 14 ++++++-
>  arch/x86/kernel/process.c                 | 65 ++++++++++++++--------------
>  arch/x86/kernel/vmlinux.lds.S             |  1 -
>  arch/x86/lib/memcpy_64.S                  |  5 +--
>  arch/x86/lib/memmove_64.S                 |  4 +-
>  arch/x86/lib/memset_64.S                  |  4 +-
>  arch/x86/xen/enlighten_pv.c               |  2 +-
>  arch/x86/xen/irq.c                        |  2 +-
>  arch/xtensa/kernel/process.c              |  1 +
>  arch/xtensa/kernel/vmlinux.lds.S          |  1 -
>  drivers/acpi/processor_idle.c             | 28 ++++++++-----
>  drivers/base/power/runtime.c              | 24 +++++------
>  drivers/clk/clk.c                         |  8 ++--
>  drivers/cpuidle/cpuidle-arm.c             |  4 +-
>  drivers/cpuidle/cpuidle-big_little.c      | 12 ++++--
>  drivers/cpuidle/cpuidle-mvebu-v7.c        | 13 ++++--
>  drivers/cpuidle/cpuidle-psci.c            | 26 +++++-------
>  drivers/cpuidle/cpuidle-qcom-spm.c        |  4 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c       | 19 +++++----
>  drivers/cpuidle/cpuidle-tegra.c           | 31 +++++++++-----
>  drivers/cpuidle/cpuidle.c                 | 70 ++++++++++++++++++++++---------
>  drivers/cpuidle/dt_idle_states.c          |  2 +-
>  drivers/cpuidle/poll_state.c              | 10 ++++-
>  drivers/idle/intel_idle.c                 | 19 ++++-----
>  drivers/perf/arm_pmu.c                    | 11 +----
>  drivers/perf/riscv_pmu_sbi.c              |  8 +---
>  include/asm-generic/vmlinux.lds.h         |  9 ++--
>  include/linux/clockchips.h                |  4 +-
>  include/linux/compiler_types.h            | 18 +++++++-
>  include/linux/cpu.h                       |  3 --
>  include/linux/cpuidle.h                   | 32 ++++++++++++++
>  include/linux/cpumask.h                   |  4 +-
>  include/linux/percpu-defs.h               |  2 +-
>  include/linux/sched/idle.h                | 40 +++++++++++++-----
>  include/linux/thread_info.h               | 18 +++++++-
>  include/linux/tracepoint.h                | 15 ++++++-
>  kernel/context_tracking.c                 | 12 +++---
>  kernel/cpu_pm.c                           |  9 ----
>  kernel/printk/printk.c                    |  2 +-
>  kernel/sched/idle.c                       | 47 ++++++---------------
>  kernel/time/tick-broadcast-hrtimer.c      | 29 ++++++-------
>  kernel/time/tick-broadcast.c              |  6 ++-
>  kernel/trace/trace.c                      |  3 ++
>  kernel/trace/trace_preemptirq.c           | 50 ++++++----------------
>  lib/ubsan.c                               |  5 ++-
>  mm/kasan/kasan.h                          |  4 ++
>  mm/kasan/shadow.c                         | 38 +++++++++++++++++
>  tools/objtool/check.c                     | 17 ++++++++
>  131 files changed, 617 insertions(+), 523 deletions(-)
> 
