From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 04/13] lockdep: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:13 +0200
Message-ID: <20200914204441.375753691@linutronix.de>
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
	 bh=wSVwpnVFOXGt7n7iPDPKtrd3tpenCd/S0fBGzDMnhaQ=; b=voJAJyG4/5RVjO1I8x7jK+Yzf
	7z6K6HQjpvKWIUHuJXSDxyEE6jEsbpIi2Sb7IqiNEVddvnhh58ZbQrq3okl7KcEYCD2oczZEKKgFN
	WE6crssYMqlE/5WyNVTHfl2eLyWr31gb8w9retCtu1Eww/rqf3kFfGnh12qzcv+RoaYKiwmN4oDMQ
	zJFPqQropEPqNckPhU2jAn1mV9OoZ6oAOkXxebRhuD4rVfUSKC8PClU40Vuxyu42nVXZxRs4lvDPf
	9/EfapOG+7zjQyw4Pql6HFk6U5RldyKFtOOaOIvczBxLeWHtPtmg1U9Ub4svidOW1rLPi9Jik84Z9
	dCa0XHeyg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=rLyqvXX8ykRDikewrjB+k5sQeB3vmoPh6IJL9FYNd5E=;
 b=0l+YgFUMwvopub406qnKsr3dUzMW5NPZcFv6G4XvOZEQ88/olItKzVOA4C3bYkFUtxUTsb
 d6v+xvHY0Cf0pFi1XJzwPekHutxMnxoSPZyRNSusdIzlgBLEkcIcT5ez6oqXXsfXE4RpVG
 z8jA+tpUmSkmgzrIuoELC0Qs0HIQUSZ+ThJunQNfgd64d5ALlWCN7spWOTKewPGG//X5uW
 SDnsdlTigGEpi0Yk5N8j2gX8QGJXem5Feo6hcxV45cAdC1ZglVX7WyKso58nhlsjDukKbG
 5B5Dq7tjsGgdcRn9YcRdYTN6CFERdRtNhn2Rq0CHP4BBToJrIEpQLMh/myq27w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=rLyqvXX8ykRDikewrjB+k5sQeB3vmoPh6IJL9FYNd5E=;
 b=279035DbbzR5rrA/oYFZOR6A7RqYHpogOyqAAY71fcsTyj3GPke7oTdjeG6zebT9b9iXf2
 aR4ImfvLkgSxNvBg==
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/lockdep.h |    6 ++----
 lib/Kconfig.debug       |    1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -585,16 +585,14 @@ do {									\
 
 #define lockdep_assert_preemption_enabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+	WARN_ON_ONCE(debug_locks			&&		\
 		     (preempt_count() != 0		||		\
 		      !raw_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+	WARN_ON_ONCE(debug_locks			&&		\
 		     (preempt_count() == 0		&&		\
 		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1161,7 +1161,6 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT
 	select TRACE_IRQFLAGS
 	default n
 	help
