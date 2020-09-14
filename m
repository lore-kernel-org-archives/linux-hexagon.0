From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 00/13] preempt: Make preempt count unconditional
Date: Mon, 14 Sep 2020 22:42:09 +0200
Message-ID: <20200914204209.256266093@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:Message-Id:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Sm6/kSGAjdRA6usFlzB5rcVI0BK1qVSfybEcHTG6WKM=; b=nYCvp6IFhd5w2BDSw9cf5IsUQa
	NEivmHwGlww19YkRY8l52kqF5mQEI+yCS4GMZ0NmP9o2XCWc/IqM5oL/vBchSF4ccoygokhM/G1Ka
	akfdq/nuNYfS3jkcuwmuVmUGHMHAsm7DJu2GXKtR7TzagO1LHFDaRFDZq9GFQaetkYocBK6uxjoQ9
	GI/u1XQSrKYX0ouXS50zj9GkLjgggsAVIeZuxWCXnDnGgESCDgPDpVsZZPkdTiodUiA3vguLXOoQ1
	rl7GJwvuc0YKxEbAcX0AT2AG7A66cXzZ88wyWfAVOEpNo+++qt/d5Jd1CkYL2wIyVFZDEzMFKv39m
	HonUqctA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9WPslsayaKn9l4KRCy6vC0tA0OD05xl/cJA1zjQzh9Q=;
 b=JAPA/qzJzqHcag6qcakOZ9GWUXDKy6NtfE7r1NQIWc0gTSVI1iY9yrfWEOEFzix8pmbAuS
 MuaADNs3pSiCLAI4n+a3p1Yf/IWnvCFznqLXHdFbrDe3FVowlmnsdQrS2jaIRBADVVI35z
 w4z5EtbZ4BM+lDYkm4gbkp+SUGbQKvIrUNGyKtK0Iy+a2fNL9PfeIjhLDWq/Rh541SefY6
 UEZRJAC+1zAPbDuYa0LqAwZ3otlmljq7saTqU/AENBQStLBF6lG25DUU28wlzUFRs8NAHx
 Sc5WJ3V+SMr9bgVMgPIVxmsQXr7EAdha5VH1MxCb2AQt5zljIPUjkUY/FDZVaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9WPslsayaKn9l4KRCy6vC0tA0OD05xl/cJA1zjQzh9Q=;
 b=JVGAZSnCuZ9YvnhwM1nsyY3Yl860vCMg1V49xOerJHh7jF1cfp3RkRkcmNc+b0cld1O3y+
 vBmqvqKHtYT11hAw==
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>, Valentin

Folks!

While working on various preempt count related things, I stumbled (again)
over the inconsistency of our preempt count handling.

The handling of preempt_count() is inconsistent accross kernel
configurations. On kernels which have PREEMPT_COUNT=n
preempt_disable/enable() and the lock/unlock functions are not affecting
the preempt count, only local_bh_disable/enable() and _bh variants of
locking, soft interrupt delivery, hard interrupt and NMI context affect it.

It's therefore impossible to have a consistent set of checks which provide
information about the context in which a function is called. In many cases
it makes sense to have seperate functions for seperate contexts, but there
are valid reasons to avoid that and handle different calling contexts
conditionally.

The lack of such indicators which work on all kernel configuratios is a
constant source of trouble because developers either do not understand the
implications or try to work around this inconsistency in weird
ways. Neither seem these issues be catched by reviewers and testing.

Recently merged code does:

	 gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;

Looks obviously correct, except for the fact that preemptible() is
unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
that code use GFP_ATOMIC on such kernels.

Attempts to make preempt count unconditional and consistent have been
rejected in the past with handwaving performance arguments.

Freshly conducted benchmarks did not reveal any measurable impact from
enabling preempt count unconditionally. On kernels with CONFIG_PREEMPT_NONE
or CONFIG_PREEMPT_VOLUNTARY the preempt count is only incremented and
decremented but the result of the decrement is not tested. Contrary to that
enabling CONFIG_PREEMPT which tests the result has a small but measurable
impact due to the conditional branch/call.

It's about time to make essential functionality of the kernel consistent
accross the various preemption models.

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git preempt

That's the first part of a larger effort related to preempt count:

 1) The analysis of the usage sites of in_interrupt(), in_atomic(),
    in_softirq() is still ongoing, but so far the number of buggy users is
    clearly the vast majority. There will be seperate patch series
    (currently 46 and counting) to address these issues once the analysis
    is complete in the next days.

 2) The long discussed state tracking of local irq disable in preempt count
    which accounts interrupt disabled sections as atomic and avoids issuing
    costly instructions (sti, cli, popf or their non X86 counterparts) when
    the state does not change, i.e. nested irq_save() or irq_restore(). I
    have this working on X86 already and contrary to my earlier attempts
    this was reasonably straight forward due to the recent entry/exit code
    consolidation.

    What I've not done yet is to optimize the preempt count handling
    of the [un]lock_irq* operations so they handle the interrupt disabled
    state and the preempt count modification in one go. That's an obvious
    add on, but correctness first ...

 3) Lazy interrupt disabling as a straight forward extension to #2. This
    avoids the actual disabling at the CPU level completely and catches an
    incoming interrupt in the low level entry code, modifies the interrupt
    disabled state on the return stack, notes the interrupt as pending in
    software and raises it again when interrupts are reenabled. This has
    still a few issues which I'm hunting down (cpuidle is unhappy ...)

Thanks,

	tglx
---
 arch/arm/include/asm/assembler.h                                 |   11 --
 arch/arm/kernel/iwmmxt.S                                         |    2 
 arch/arm/mach-ep93xx/crunch-bits.S                               |    2 
 arch/xtensa/kernel/entry.S                                       |    2 
 drivers/gpu/drm/i915/Kconfig.debug                               |    1 
 drivers/gpu/drm/i915/i915_utils.h                                |    3 
 include/linux/bit_spinlock.h                                     |    4 -
 include/linux/lockdep.h                                          |    6 -
 include/linux/pagemap.h                                          |    4 -
 include/linux/preempt.h                                          |   37 +---------
 include/linux/uaccess.h                                          |    6 -
 kernel/Kconfig.preempt                                           |    4 -
 kernel/sched/core.c                                              |    6 -
 lib/Kconfig.debug                                                |    3 
 lib/Kconfig.debug.rej                                            |   14 +--
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t            |    1 
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u            |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TINY01            |    1 
 tools/testing/selftests/rcutorture/doc/TINY_RCU.txt              |    5 -
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt      |    1 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h |    1 
 21 files changed, 23 insertions(+), 92 deletions(-)
