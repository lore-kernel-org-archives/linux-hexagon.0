From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 00/44] cpuidle,rcu: Clean up the mess
Date: Mon, 19 Sep 2022 11:59:39 +0200
Message-ID: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A7C56FB9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 954776FB82
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 457EF424D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFD3E4259C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=D+MsKiHRvmSvqyjrleqvhdKjdXvjkJhvT05d1tF3TYc=; b=UQsvU8nlB76xZeTRu6KbAZ5g4A
 v21ezpBG4aDzfKkxxCb9GpmlADJppCf+KVyodO/TEoyudKbqBLCyLdtwrbFAxb0aJ5fwHbEPQQ1N5
 EmuvzVJrRo7TykFnlJ+oN15NWd2VLfXjixEytfV45kWCvhMnssNkUfZVmK3eHsT83TmhrkAy+1rWL
 dSaGj0mA5cA9DiUGq8Uf3dsk4uEicB4ZuKl7D0T57Yf0eK8IdpHZoEAhNRMLiW4K3HehEHlB8w53i
 worbn3yXyIb3FqjM/nTkOkRImrnF50v+k8ux+BswwsADI0NLv4ntoM+CNvwAF6XnPH12b3dM+N70J
 YkBwTAqw==;
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <a>

Hi All!

At long last, a respin of the cpuidle vs rcu cleanup patches.

v1: https://lkml.kernel.org/r/20220608142723.103523089@infradead.org

These here patches clean up the mess that is cpuidle vs rcuidle.

At the end of the ride there's only on RCU_NONIDLE user left:

  arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());

and 'one' trace_*_rcuidle() user:

  kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
  kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
  kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
  kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
  kernel/trace/trace_preemptirq.c:                trace_preempt_enable_rcuidle(a0, a1);
  kernel/trace/trace_preemptirq.c:                trace_preempt_disable_rcuidle(a0, a1);

However this last is all in deprecated code that should be unused for GENERIC_ENTRY.

I've touched a lot of code that I can't test and I might've broken something by
accident. In particular the whole ARM cpuidle stuff was quite involved.

Please all; have a look where you haven't already.


New since v1:

 - rebase on top of Frederic's rcu-context-tracking rename fest
 - more omap goodness as per the last discusion (thanks Tony!)
 - removed one more RCU_NONIDLE() from arm64/risc-v perf code
 - ubsan/kasan fixes
 - intel_idle module-param for testing
 - a bunch of extra __always_inline, because compilers are silly.

---
 arch/alpha/kernel/process.c               |  1 -
 arch/alpha/kernel/vmlinux.lds.S           |  1 -
 arch/arc/kernel/process.c                 |  3 ++
 arch/arc/kernel/vmlinux.lds.S             |  1 -
 arch/arm/include/asm/vmlinux.lds.h        |  1 -
 arch/arm/kernel/process.c                 |  1 -
 arch/arm/kernel/smp.c                     |  6 +--
 arch/arm/mach-gemini/board-dt.c           |  3 +-
 arch/arm/mach-imx/cpuidle-imx6q.c         |  4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c        |  5 ++-
 arch/arm/mach-omap2/common.h              |  6 ++-
 arch/arm/mach-omap2/cpuidle34xx.c         | 16 +++++++-
 arch/arm/mach-omap2/cpuidle44xx.c         | 29 +++++++-------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 12 +++++-
 arch/arm/mach-omap2/pm.h                  |  2 +-
 arch/arm/mach-omap2/pm24xx.c              | 51 +-----------------------
 arch/arm/mach-omap2/pm34xx.c              | 14 +++++--
 arch/arm/mach-omap2/pm44xx.c              |  2 +-
 arch/arm/mach-omap2/powerdomain.c         | 10 ++---
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
 arch/mips/kernel/idle.c                   |  8 ++--
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
 arch/x86/coco/tdx/tdx.c                   | 25 ++++--------
 arch/x86/events/amd/brs.c                 | 13 +++----
 arch/x86/include/asm/fpu/xcr.h            |  4 +-
 arch/x86/include/asm/irqflags.h           | 11 ++----
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
 arch/x86/kernel/process.c                 | 65 +++++++++++++++----------------
 arch/x86/kernel/vmlinux.lds.S             |  1 -
 arch/x86/lib/memcpy_64.S                  |  5 +--
 arch/x86/lib/memmove_64.S                 |  4 +-
 arch/x86/lib/memset_64.S                  |  4 +-
 arch/x86/xen/enlighten_pv.c               |  2 +-
 arch/x86/xen/irq.c                        |  2 +-
 arch/xtensa/kernel/process.c              |  1 +
 arch/xtensa/kernel/vmlinux.lds.S          |  1 -
 drivers/acpi/processor_idle.c             | 36 ++++++++++-------
 drivers/base/power/runtime.c              | 24 ++++++------
 drivers/clk/clk.c                         |  8 ++--
 drivers/cpuidle/cpuidle-arm.c             |  1 +
 drivers/cpuidle/cpuidle-big_little.c      |  8 +++-
 drivers/cpuidle/cpuidle-mvebu-v7.c        |  7 ++++
 drivers/cpuidle/cpuidle-psci.c            | 10 +++--
 drivers/cpuidle/cpuidle-qcom-spm.c        |  1 +
 drivers/cpuidle/cpuidle-riscv-sbi.c       | 10 +++--
 drivers/cpuidle/cpuidle-tegra.c           | 21 +++++++---
 drivers/cpuidle/cpuidle.c                 | 21 +++++-----
 drivers/cpuidle/dt_idle_states.c          |  2 +-
 drivers/cpuidle/poll_state.c              | 10 ++++-
 drivers/idle/intel_idle.c                 | 19 +++++----
 drivers/perf/arm_pmu.c                    | 11 +-----
 drivers/perf/riscv_pmu_sbi.c              |  8 +---
 include/asm-generic/vmlinux.lds.h         |  9 ++---
 include/linux/compiler_types.h            |  8 +++-
 include/linux/cpu.h                       |  3 --
 include/linux/cpuidle.h                   | 34 ++++++++++++++++
 include/linux/cpumask.h                   |  4 +-
 include/linux/percpu-defs.h               |  2 +-
 include/linux/sched/idle.h                | 40 ++++++++++++++-----
 include/linux/thread_info.h               | 18 ++++++++-
 include/linux/tracepoint.h                | 13 ++++++-
 kernel/cpu_pm.c                           |  9 -----
 kernel/printk/printk.c                    |  2 +-
 kernel/sched/idle.c                       | 47 +++++++---------------
 kernel/time/tick-broadcast-hrtimer.c      | 29 ++++++--------
 kernel/time/tick-broadcast.c              |  6 ++-
 kernel/trace/trace.c                      |  3 ++
 lib/ubsan.c                               |  5 ++-
 mm/kasan/kasan.h                          |  4 ++
 mm/kasan/shadow.c                         | 38 ++++++++++++++++++
 tools/objtool/check.c                     | 17 ++++++++
 121 files changed, 511 insertions(+), 420 deletions(-)
