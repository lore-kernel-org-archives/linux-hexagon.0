From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 01/13] lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
Date: Mon, 14 Sep 2020 22:42:10 +0200
Message-ID: <20200914204440.969090025@linutronix.de>
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
	 bh=O75cXnFiiK1lJCwGybv8NNwXqvJXzgu3fflMSemY8R4=; b=rZ+IN0fgA2m9QTyL6ykmidq7q
	LvIwLM/0uPDL4pZXeDjk9YzKp3+WA7JdrVwvWO6Chh+4J7pAAPSh2VtbRIUiTU4ngQUj0/Omlh52w
	fHssBm9TcS1tGkcmdPR1eIEFWRs1i2beYS0bqHQONx5hgYqRr8B2oyp2vebW5I1n8iBVORWJaDxT4
	hs53S7FeKY0mujjnej7abRpO3TywRmwK2RskMm4/ZcMDgfPh94MXj0hlHOhdO0SFVZg56lw2djW+j
	11dqS4KpCRd/BM0ZdK9abmZfDl4zRyYpzXJjSB01dFfHWS2ITjZgB09SqljVfPz0jxGUOQEXxO1IC
	Yo61qwtiQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=sKqpUZgQTSsofOfA1QdAWY2+LBfcprxU0W9PCOpQ7JY=;
 b=uO+ld7WSpQY4vI69jsCu6Pz2RE8hrYv0Gf5wXsXRpBHLrOwLdq1mTBXH5kF9EQzLVjQ8dE
 L9nryl5hXhHp4GAEJYk/MN1jCD5uAR0Lc9CYUCyrB5iaNdnDjumEicqwlc1xyf56QorUoO
 uuiL35aqGp53wHsl6QrGtxfrGdDGxJVoXaT9mQ9NIlwuCv++BBc71raPpS2ikuywEKDnnN
 zT0iPxwQe8ky13mLBUJaRhmhYsg+53xaAsyMbRHht54GnYUMN6nTgx9WKPIo86mWiJiR3V
 E0z51mP0R5IBbmjI9Fx+cm/iN3YTH1Tg0+XL+eAlcW12YKEEbMjB3cccf0P+yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=sKqpUZgQTSsofOfA1QdAWY2+LBfcprxU0W9PCOpQ7JY=;
 b=kFv5VCuwJvLbfOKz3oy8dhCG/DCPgG09EZhdEaXg5ZPKl5YxMOg851zb3lfo1duSkOyL7R
 vZCR4sfvPRoaC/AQ==
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

ARCH_NO_PREEMPT disables the selection of CONFIG_PREEMPT_VOLUNTARY and
CONFIG_PREEMPT, but architectures which set this config option still
support preempt count for hard and softirq accounting.

There is absolutely no reason to prevent lockdep from using the preempt
counter nor is there a reason to prevent the enablement of
CONFIG_DEBUG_ATOMIC_SLEEP on such architectures.

Remove the dependencies, which affects ALPHA, HEXAGON, M68K and UM.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 lib/Kconfig.debug |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1161,7 +1161,7 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
+	select PREEMPT_COUNT
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1323,7 +1323,6 @@ config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
-	depends on !ARCH_NO_PREEMPT
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called inside atomic sections: when a spinlock is
