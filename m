From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 02/13] preempt: Make preempt count unconditional
Date: Mon, 14 Sep 2020 22:42:11 +0200
Message-ID: <20200914204441.115488215@linutronix.de>
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
	 bh=yxbr15Nis8wlWo8pP/ziPYyT8fAvINf08wqJD8aWJ20=; b=AaJPkwqUt9/BbFYfC1smgV1yr
	GRzz1tcb9K0lqt+0Uplfnt5ahyQNyfJgYaXum7hF7S+CP/hnExEog5x907QsXX+eptBe5m0j3qcc+
	mqJ09ccyqSdPyep7gX4svw1sqNoOlKFJzhO3YtA8yp5MU5pqFAedflqF2cQoOsBHNESZW0sNXtupB
	ozNpQtQIQnFP1Y8jpRIsKV/ltaNJsW02yL+F8W5Fbd8SfUUbiUsGhKp28ebvbu+MAPHiv8HqB5dzd
	cEogDGC4OWgKFAdgMdqgs21dhv1Cv6v0eUxkIKtYcsq7MPF+/xcwqnSSfVzJ02PXm7aznii9GHeWE
	di8YCrXcg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=+wlx0B5bXFGE1ZqmF2GOQz7Vu5f4dOGKH6MLdtZ/des=;
 b=FKqpL2700K2KI8YRyNg486WotbPXB8OPjTNR7CD6hpf4WOsECuFHsf9Fl7xQ/njOCC4us1
 V7/8dgt2Y8Q5bsUgPdX3cx6XhZz7xzGxkW9H08+RkTCs1S3zZRCuJ6BO6NdCa1sGP2ZZpX
 3bB1p3j0W8RPnI56xz7EqLgYOttnzUhttUOz6CqCP4LTLNoe43UQ+fBcsmVdaPtzMUWgf2
 T1f1tMxghsrPiIICkGbkbj/aNUjRjRxUCjZE6DU4Hd0Nghaw+wzNONpacrfVovmhca4M2C
 rQnc8p8FaD3ZJfM8rRAgyRFUboeWQsqzuPbUDTsqtxOETbLcX/pUl6ZnCc32nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=+wlx0B5bXFGE1ZqmF2GOQz7Vu5f4dOGKH6MLdtZ/des=;
 b=3ZJjdClz5oMHjfFfg9NKeHYyaj0Ejpc30NZ9Tracs4udi2vCXYHDiLEh6EZOsJaUpk6Jwn
 e+AMA/J0ha4T1+Bg==
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

Enable CONFIG_PREEMPT_COUNT unconditionally. Follow up changes will remove
the #ifdeffery and remove the config option at the end.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/Kconfig.preempt |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -75,8 +75,7 @@ config PREEMPT_RT
 endchoice
 
 config PREEMPT_COUNT
-       bool
+       def_bool y
 
 config PREEMPTION
        bool
-       select PREEMPT_COUNT
