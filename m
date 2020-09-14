From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 08/13] sched: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:17 +0200
Message-ID: <20200914204441.794954043@linutronix.de>
References: <20200914204209.256266093@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Subject:To:From:Date:
	Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=LliDEPZe44VCihoXSlWrMrTxWi/FYHlTB5WVpg//vrA=; b=UF2/BwAzjZz+rWWcuRbfd6g4t
	7/89Zu2WwXzOMhsAIIRrVE3us8Y/79nDKRkuW9CjzCjTAeZveDMdOiJ6RrmuMZiRty/pAEe7QHZmq
	ZPcEDivLcZ+S8/b0zC20WkQS80Rmk09QYQVJaTTXywogRTqWVkwuFEGimbn2jZJZPsnC8z3M7lYiY
	zucydHH1UrBSH7wGcPLcvoWcF8krmA2Nz9+4poyT08pNNZ5S58L3UJpPA4mpOm2NfkoVrlLMG+G2A
	8sdV/Qh8j2qKo2FNx6jDmK1qc2HATabT8H99YbyTK/8de68nZqWlh3q7mAeYggDXdL7ZEU1LOQ7gY
	cJJf3V7qw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=7peXevktBYsFk34wm8L75T0nsPk5gnSvk+DWEgeI/Vw=;
 b=A1nP+uNHxXIHRSaQfo4YEEBXkNc5lEKqsa3e9ZF16Mjxoy2hyJe3jYIclstpFysB9+yhkl
 6BJmX4d0VGhUHfrqZ99YiKgnDDEKF/0G47GYpaJrPGTpN/QZTYqN5RoutXNpp3V1eagHEd
 1I8+FvO96pkUL+g/chBpkTP2STb2Yp9k9TlY1hsvNnP+5yKkzdcMXCCT5WYR0aFvr/f5Gb
 v882kTY7TgtIhZxNAl+4R3t6wwqFtSFu6vh6GWbJdLdgHmEJejAg+EXh6pguxew3F9cvUQ
 J0Q+f/McALfJaEP6IOZ2Ph7YeDaVLv5ly5xuP3c0lVjGvOu5v8C7SFXEDbJ1bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=7peXevktBYsFk34wm8L75T0nsPk5gnSvk+DWEgeI/Vw=;
 b=zdd/Mm/JBQah2WSeC3g/P4gSriHqu9VTmesvYkyojBCblFCX+/r8LrnQYIfLtLeNfYCVhp
 m1SdTR/ofp2HUZDQ==
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

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/sched/core.c |    6 +-----
 lib/Kconfig.debug   |    1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3706,8 +3706,7 @@ asmlinkage __visible void schedule_tail(
 	 * finish_task_switch() for details.
 	 *
 	 * finish_task_switch() will drop rq->lock() and lower preempt_count
-	 * and the preempt_enable() will end up enabling preemption (on
-	 * PREEMPT_COUNT kernels).
+	 * and the preempt_enable() will end up enabling preemption.
 	 */
 
 	rq = finish_task_switch(prev);
@@ -7311,9 +7310,6 @@ void __cant_sleep(const char *file, int
 	if (irqs_disabled())
 		return;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return;
-
 	if (preempt_count() > preempt_offset)
 		return;
 
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1320,7 +1320,6 @@ config DEBUG_LOCKDEP
 
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
-	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, various routines which may sleep will become very
