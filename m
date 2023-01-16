From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Date: Mon, 16 Jan 2023 16:59:04 +0000
Message-ID: <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1AB140308
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F2794091F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44839813ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CEFC813AF
Content-Disposition: inline
In-Reply-To: <20230112194314.845371875@infradead.org>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, nsekhar@ti.com, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com

On Thu, Jan 12, 2023 at 08:43:14PM +0100, Peter Zijlstra wrote:
> Hi All!

Hi Peter,

> The (hopefully) final respin of cpuidle vs rcu cleanup patches. Barring any
> objections I'll be queueing these patches in tip/sched/core in the next few
> days.

I'm sorry to have to bear some bad news on that front. :(

I just had a go at testing this on a Juno dev board, using your queue.git
sched/idle branch and defconfig + CONFIG_PROVE_LOCKING=y +
CONFIG_DEBUG_LOCKDEP=y + CONFIG_DEBUG_ATOMIC_SLEEP=y.

With that I consistently see RCU at boot time (log below).

| =============================
| WARNING: suspicious RCU usage
| 6.2.0-rc3-00051-gced9b6eecb31 #1 Not tainted
| -----------------------------
| include/trace/events/ipi.h:19 suspicious rcu_dereference_check() usage!
| 
| other info that might help us debug this:
| 
| 
| rcu_scheduler_active = 2, debug_locks = 1
| RCU used illegally from extended quiescent state!
| no locks held by swapper/0/0.
| 
| stack backtrace:
| CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc3-00051-gced9b6eecb31 #1
| Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II May 16 2021
| Call trace:
|  dump_backtrace.part.0+0xe4/0xf0
|  show_stack+0x18/0x30
|  dump_stack_lvl+0x98/0xd4
|  dump_stack+0x18/0x34
|  lockdep_rcu_suspicious+0xf8/0x10c
|  trace_ipi_raise+0x1a8/0x1b0
|  arch_irq_work_raise+0x4c/0x70
|  __irq_work_queue_local+0x48/0x80
|  irq_work_queue+0x50/0x80
|  __wake_up_klogd.part.0+0x98/0xe0
|  defer_console_output+0x20/0x30
|  vprintk+0x98/0xf0
|  _printk+0x5c/0x84
|  lockdep_rcu_suspicious+0x34/0x10c
|  trace_lock_acquire+0x174/0x180
|  lock_acquire+0x3c/0x8c
|  _raw_spin_lock_irqsave+0x70/0x150
|  down_trylock+0x18/0x50
|  __down_trylock_console_sem+0x3c/0xd0
|  console_trylock+0x28/0x90
|  vprintk_emit+0x11c/0x354
|  vprintk_default+0x38/0x4c
|  vprintk+0xd4/0xf0
|  _printk+0x5c/0x84
|  lockdep_rcu_suspicious+0x34/0x10c
|  printk_sprint+0x238/0x240
|  vprintk_store+0x32c/0x4b0
|  vprintk_emit+0x104/0x354
|  vprintk_default+0x38/0x4c
|  vprintk+0xd4/0xf0
|  _printk+0x5c/0x84
|  lockdep_rcu_suspicious+0x34/0x10c
|  trace_irq_disable+0x1ac/0x1b0
|  trace_hardirqs_off+0xe8/0x110
|  cpu_suspend+0x4c/0xfc
|  psci_cpu_suspend_enter+0x58/0x6c
|  psci_enter_idle_state+0x70/0x170
|  cpuidle_enter_state+0xc4/0x464
|  cpuidle_enter+0x38/0x50
|  do_idle+0x230/0x2c0
|  cpu_startup_entry+0x24/0x30
|  rest_init+0x110/0x190
|  arch_post_acpi_subsys_init+0x0/0x18
|  start_kernel+0x6f8/0x738
|  __primary_switched+0xbc/0xc4

IIUC what's happenign here is the PSCI cpuidle driver has entered idle and RCU
is no longer watching when arm64's cpu_suspend() manipulates DAIF. Our
local_daif_*() helpers poke lockdep and tracing, hence the call to
trace_hardirqs_off() and the RCU usage.

I think we need RCU to be watching all the way down to cpu_suspend(), and it's
cpu_suspend() that should actually enter/exit idle context. That and we need to
make cpu_suspend() and the low-level PSCI invocation noinstr.

I'm not sure whether 32-bit will have a similar issue or not.

I'm surprised no-one else who has tested has seen this; I suspect people
haven't enabled lockdep and friends. :/

Thanks,
Mark. 
