From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/13] preempt: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:12 +0200
Message-ID: <20200914204441.268144917@linutronix.de>
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
	 bh=qtNZ6aJZzsDTR3sIWljsSOhmFC6KCl8JltrOG1zSjmU=; b=mHrutIlxZxs7OZKvoGYCy5EXh
	Vhg8hw/N9jOJWBGiTFbwuG9KO8HoaTEqEVevaUPbkKjYMy7ec5fTWR/hOZBRIx8zHt7KCc1gPFwVa
	1PQPTQqkrgj2GvNVLKRdF91wsfjY2Qi1kuYjAhhNw2wJIsPOxI9fJmHj7K6yIKPsrf7q1DcbRrR4d
	apqeTycTDmFtPcG7FDsS6K63yHlP6nQeYHt2DdwY5OSKqYXLujiCeOOVJ5UilDp3s+bC2kULM66MQ
	J2PvwPk1pnr4ZGOxz4pVCnDnpWFRijqO8A5iW0okxyIkP2h5oTqGnvLCPo1ip03x31Bkqy5QH1WlF
	UG1yGc9pg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=ajWUogX9TC/RhWUhRjsoMZCVU/A2PO+1RO8AbyH0tUg=;
 b=RAb00UkvZ+1mWj/+2gg0IPuBWdTR5Qbi+PQESZyHXv1CItmopUrZlAq9TSJHNYfojgGSdR
 5BE+RuwGi8NmBr2Uw0WAJiRD0XDvAGH4BH29hgBFptKvSMxgM8BhYnqVkeljZe18eS8Ed5
 j+wrWel9v3p5Pl/2zo/iLWFZpL8ffLCpF0hxbDL1lhhrvHtpVYUFVon3VNC3R9byNCimCH
 MTjQQNKWVR8cL03iEEhtjiXUOaaZS+ZBFeiRO3utQHEcD8qTjabtmfx5AFc6r3X1IC6UeD
 rfuYAssuCjUUppwvqtWIseLtNqUKUpCUGw2/twhDQc4NjP7+Ta76nsTyO4rvQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=ajWUogX9TC/RhWUhRjsoMZCVU/A2PO+1RO8AbyH0tUg=;
 b=oQ2vMxxQ1S8jokngl4Em2aMbT6mff6jhwsdggEzoGhrKVDyfNVUrlVeH//sWkf+ZmBUC+x
 4p1R9v6zXDc5VBCw==
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
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 include/linux/preempt.h |   37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -56,8 +56,7 @@
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
- * Disable preemption until the scheduler is running -- use an unconditional
- * value so that it also works on !PREEMPT_COUNT kernels.
+ * Disable preemption until the scheduler is running.
  *
  * Reset by start_kernel()->sched_init()->init_idle()->init_idle_preempt_count().
  */
@@ -69,7 +68,6 @@
  *
  *    preempt_count() == 2*PREEMPT_DISABLE_OFFSET
  *
- * Note: PREEMPT_DISABLE_OFFSET is 0 for !PREEMPT_COUNT kernels.
  * Note: See finish_task_switch().
  */
 #define FORK_PREEMPT_COUNT	(2*PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
@@ -106,11 +104,7 @@
 /*
  * The preempt_count offset after preempt_disable();
  */
-#if defined(CONFIG_PREEMPT_COUNT)
-# define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
-#else
-# define PREEMPT_DISABLE_OFFSET	0
-#endif
+#define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
 
 /*
  * The preempt_count offset after spin_lock()
@@ -122,8 +116,8 @@
  *
  *  spin_lock_bh()
  *
- * Which need to disable both preemption (CONFIG_PREEMPT_COUNT) and
- * softirqs, such that unlock sequences of:
+ * Which need to disable both preemption and softirqs, such that unlock
+ * sequences of:
  *
  *  spin_unlock();
  *  local_bh_enable();
@@ -164,8 +158,6 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_COUNT
-
 #define preempt_disable() \
 do { \
 	preempt_count_inc(); \
@@ -231,27 +223,6 @@ do { \
 	__preempt_count_dec(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT_COUNT */
-
-/*
- * Even if we don't have any preemption, we need preempt disable/enable
- * to be barriers, so that we don't have things like get_user/put_user
- * that can cause faults and scheduling migrate into our preempt-protected
- * region.
- */
-#define preempt_disable()			barrier()
-#define sched_preempt_enable_no_resched()	barrier()
-#define preempt_enable_no_resched()		barrier()
-#define preempt_enable()			barrier()
-#define preempt_check_resched()			do { } while (0)
-
-#define preempt_disable_notrace()		barrier()
-#define preempt_enable_no_resched_notrace()	barrier()
-#define preempt_enable_notrace()		barrier()
-#define preemptible()				0
-
-#endif /* CONFIG_PREEMPT_COUNT */
-
 #ifdef MODULE
 /*
  * Modules have no business playing preemption tricks.
