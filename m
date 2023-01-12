From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Date: Thu, 12 Jan 2023 20:43:14 +0100
Message-ID: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB31F60FAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 903F560F3F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C884417E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76C03416EE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=nVA2Mm1l3YORbADd6moHHe8hZRGP2vbv/t+d/ET+JHY=; b=TlaXG0UvI5/2makRvuA5VeDU0a
 4qRI7QdjL2xdYtQkDc8A2gDeJm4SgV/ZE4QRpV0RJDXMMB4Ses7eZGFiDTofTYDgr5hwzJFCgjN92
 vjbEtwgBXa7w8/R1TM/dXCqOwghJkDoeZQJX5TmGkr+c4V4wG8XOesTfWGNVPxDj+IWa66EcgnnI+
 N0h0XzCqzVIGmuy6C6fbFV000CEf+CbKGraRaRx5LgxRtmWU3UqYXBQJ9uTZWqnINayTTaNj6FBwG
 4DgvEy1EZkXwsa6PFe7gZwS9WdTNugjk+fRc/F3eGMFukmGi05t3vedt00SILqwwr57VstSzHs3kM
 kK9YAFjw==;
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: peterz@infradead.org
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, nsekhar@ti.com, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com

Hi All!

The (hopefully) final respin of cpuidle vs rcu cleanup patches. Barring any
objections I'll be queueing these patches in tip/sched/core in the next few
days.

v2: https://lkml.kernel.org/r/20220919095939.761690562@infradead.org

These here patches clean up the mess that is cpuidle vs rcuidle.

At the end of the ride there's only on RCU_NONIDLE user left:

  arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());

And I know Mark has been prodding that with something sharp.

The last version was tested by a number of people and I'm hoping to not have
broken anything in the meantime ;-)


Changes since v2:

 - rebased to v6.2-rc3; as available at:
     git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle

 - folded: https://lkml.kernel.org/r/Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net
   which makes the ARM cpuidle index 0 consistently not use
   CPUIDLE_FLAG_RCU_IDLE, as requested by Ulf.

 - added a few more __always_inline to empty stub functions as found by the
   robot.

 - Used _RET_IP_ instead of _THIS_IP_ in a few placed because of:
   https://github.com/ClangBuiltLinux/linux/issues/263

 - Added new patches to address various robot reports:

     #35:  trace,hardirq: No moar _rcuidle() tracing
     #47:  cpuidle: Ensure ct_cpuidle_enter() is always called from noinstr/__cpuidle
     #48:  cpuidle,arch: Mark all ct_cpuidle_enter() callers __cpuidle
     #49:  cpuidle,arch: Mark all regular cpuidle_state::enter methods __cpuidle
     #50:  cpuidle: Comments about noinstr/__cpuidle
     #51:  context_tracking: Fix noinstr vs KASAN


---
 arch/alpha/kernel/process.c               |  1 -
 arch/alpha/kernel/vmlinux.lds.S           |  1 -
 arch/arc/kernel/process.c                 |  3 ++
 arch/arc/kernel/vmlinux.lds.S             |  1 -
 arch/arm/include/asm/vmlinux.lds.h        |  1 -
 arch/arm/kernel/cpuidle.c                 |  4 +-
 arch/arm/kernel/process.c                 |  1 -
 arch/arm/kernel/smp.c                     |  6 +--
 arch/arm/mach-davinci/cpuidle.c           |  4 +-
 arch/arm/mach-gemini/board-dt.c           |  3 +-
 arch/arm/mach-imx/cpuidle-imx5.c          |  4 +-
 arch/arm/mach-imx/cpuidle-imx6q.c         |  8 ++--
 arch/arm/mach-imx/cpuidle-imx6sl.c        |  4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c        |  9 ++--
 arch/arm/mach-imx/cpuidle-imx7ulp.c       |  4 +-
 arch/arm/mach-omap2/common.h              |  6 ++-
 arch/arm/mach-omap2/cpuidle34xx.c         | 16 ++++++-
 arch/arm/mach-omap2/cpuidle44xx.c         | 29 +++++++------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 12 +++++-
 arch/arm/mach-omap2/pm.h                  |  2 +-
 arch/arm/mach-omap2/pm24xx.c              | 51 +---------------------
 arch/arm/mach-omap2/pm34xx.c              | 14 +++++--
 arch/arm/mach-omap2/pm44xx.c              |  2 +-
 arch/arm/mach-omap2/powerdomain.c         | 10 ++---
 arch/arm/mach-s3c/cpuidle-s3c64xx.c       |  5 +--
 arch/arm64/kernel/cpuidle.c               |  2 +-
 arch/arm64/kernel/idle.c                  |  1 -
 arch/arm64/kernel/smp.c                   |  4 +-
 arch/arm64/kernel/vmlinux.lds.S           |  1 -
 arch/csky/kernel/process.c                |  1 -
 arch/csky/kernel/smp.c                    |  2 +-
 arch/csky/kernel/vmlinux.lds.S            |  1 -
 arch/hexagon/kernel/process.c             |  1 -
 arch/hexagon/kernel/vmlinux.lds.S         |  1 -
 arch/ia64/kernel/process.c                |  1 +
 arch/ia64/kernel/vmlinux.lds.S            |  1 -
 arch/loongarch/kernel/idle.c              |  1 +
 arch/loongarch/kernel/vmlinux.lds.S       |  1 -
 arch/m68k/kernel/vmlinux-nommu.lds        |  1 -
 arch/m68k/kernel/vmlinux-std.lds          |  1 -
 arch/m68k/kernel/vmlinux-sun3.lds         |  1 -
 arch/microblaze/kernel/process.c          |  1 -
 arch/microblaze/kernel/vmlinux.lds.S      |  1 -
 arch/mips/kernel/idle.c                   | 14 +++----
 arch/mips/kernel/vmlinux.lds.S            |  1 -
 arch/nios2/kernel/process.c               |  1 -
 arch/nios2/kernel/vmlinux.lds.S           |  1 -
 arch/openrisc/kernel/process.c            |  1 +
 arch/openrisc/kernel/vmlinux.lds.S        |  1 -
 arch/parisc/kernel/process.c              |  2 -
 arch/parisc/kernel/vmlinux.lds.S          |  1 -
 arch/powerpc/kernel/idle.c                |  5 +--
 arch/powerpc/kernel/vmlinux.lds.S         |  1 -
 arch/riscv/kernel/process.c               |  1 -
 arch/riscv/kernel/vmlinux-xip.lds.S       |  1 -
 arch/riscv/kernel/vmlinux.lds.S           |  1 -
 arch/s390/kernel/idle.c                   |  1 -
 arch/s390/kernel/vmlinux.lds.S            |  1 -
 arch/sh/kernel/idle.c                     |  1 +
 arch/sh/kernel/vmlinux.lds.S              |  1 -
 arch/sparc/kernel/leon_pmc.c              |  4 ++
 arch/sparc/kernel/process_32.c            |  1 -
 arch/sparc/kernel/process_64.c            |  3 +-
 arch/sparc/kernel/vmlinux.lds.S           |  1 -
 arch/um/kernel/dyn.lds.S                  |  1 -
 arch/um/kernel/process.c                  |  1 -
 arch/um/kernel/uml.lds.S                  |  1 -
 arch/x86/boot/compressed/vmlinux.lds.S    |  1 +
 arch/x86/coco/tdx/tdcall.S                | 15 +------
 arch/x86/coco/tdx/tdx.c                   | 25 ++++-------
 arch/x86/events/amd/brs.c                 | 13 +++---
 arch/x86/include/asm/fpu/xcr.h            |  4 +-
 arch/x86/include/asm/irqflags.h           | 11 ++---
 arch/x86/include/asm/mwait.h              | 14 +++----
 arch/x86/include/asm/nospec-branch.h      |  2 +-
 arch/x86/include/asm/paravirt.h           |  6 ++-
 arch/x86/include/asm/perf_event.h         |  2 +-
 arch/x86/include/asm/shared/io.h          |  4 +-
 arch/x86/include/asm/shared/tdx.h         |  1 -
 arch/x86/include/asm/special_insns.h      |  8 ++--
 arch/x86/include/asm/xen/hypercall.h      |  2 +-
 arch/x86/kernel/cpu/bugs.c                |  2 +-
 arch/x86/kernel/fpu/core.c                |  4 +-
 arch/x86/kernel/paravirt.c                | 14 ++++++-
 arch/x86/kernel/process.c                 | 65 ++++++++++++++--------------
 arch/x86/kernel/vmlinux.lds.S             |  1 -
 arch/x86/lib/memcpy_64.S                  |  5 +--
 arch/x86/lib/memmove_64.S                 |  4 +-
 arch/x86/lib/memset_64.S                  |  4 +-
 arch/x86/xen/enlighten_pv.c               |  2 +-
 arch/x86/xen/irq.c                        |  2 +-
 arch/xtensa/kernel/process.c              |  1 +
 arch/xtensa/kernel/vmlinux.lds.S          |  1 -
 drivers/acpi/processor_idle.c             | 28 ++++++++-----
 drivers/base/power/runtime.c              | 24 +++++------
 drivers/clk/clk.c                         |  8 ++--
 drivers/cpuidle/cpuidle-arm.c             |  4 +-
 drivers/cpuidle/cpuidle-big_little.c      | 12 ++++--
 drivers/cpuidle/cpuidle-mvebu-v7.c        | 13 ++++--
 drivers/cpuidle/cpuidle-psci.c            | 26 +++++-------
 drivers/cpuidle/cpuidle-qcom-spm.c        |  4 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c       | 19 +++++----
 drivers/cpuidle/cpuidle-tegra.c           | 31 +++++++++-----
 drivers/cpuidle/cpuidle.c                 | 70 ++++++++++++++++++++++---------
 drivers/cpuidle/dt_idle_states.c          |  2 +-
 drivers/cpuidle/poll_state.c              | 10 ++++-
 drivers/idle/intel_idle.c                 | 19 ++++-----
 drivers/perf/arm_pmu.c                    | 11 +----
 drivers/perf/riscv_pmu_sbi.c              |  8 +---
 include/asm-generic/vmlinux.lds.h         |  9 ++--
 include/linux/clockchips.h                |  4 +-
 include/linux/compiler_types.h            | 18 +++++++-
 include/linux/cpu.h                       |  3 --
 include/linux/cpuidle.h                   | 32 ++++++++++++++
 include/linux/cpumask.h                   |  4 +-
 include/linux/percpu-defs.h               |  2 +-
 include/linux/sched/idle.h                | 40 +++++++++++++-----
 include/linux/thread_info.h               | 18 +++++++-
 include/linux/tracepoint.h                | 15 ++++++-
 kernel/context_tracking.c                 | 12 +++---
 kernel/cpu_pm.c                           |  9 ----
 kernel/printk/printk.c                    |  2 +-
 kernel/sched/idle.c                       | 47 ++++++---------------
 kernel/time/tick-broadcast-hrtimer.c      | 29 ++++++-------
 kernel/time/tick-broadcast.c              |  6 ++-
 kernel/trace/trace.c                      |  3 ++
 kernel/trace/trace_preemptirq.c           | 50 ++++++----------------
 lib/ubsan.c                               |  5 ++-
 mm/kasan/kasan.h                          |  4 ++
 mm/kasan/shadow.c                         | 38 +++++++++++++++++
 tools/objtool/check.c                     | 17 ++++++++
 131 files changed, 617 insertions(+), 523 deletions(-)
