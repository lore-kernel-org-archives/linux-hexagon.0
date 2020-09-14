From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 10/13] xtensa: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:19 +0200
Message-ID: <20200914204441.994684356@linutronix.de>
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
	 bh=ajo7gaM9POwNFcU8bMNQKkyxSmCzS+hwdZX7rwaLJ4U=; b=WQ5gKa+uhhOejvaFDUW5Qp9ot
	X3A5WqRCbUP5ixn9LDxD1XzHqIfndPvkBGWUn7xFMusleBvZ1GZFn4vz8Fai9hLpHUyvXgL4EUFHG
	dpeH4IunGuUtHrScx+PTZPFN5fNcQ4aRbHcF/EZjUqOakLTiCgQOyIIewEN85VtU7fc5A2TR2sPif
	kXGwq1bdM+PSWFGH+nFzX/ptoq+9PnIvNDdHO7UPlLgnj4jJDyVjRayGAHBayRqS6HblCv/BJDtf7
	e/oOg+YGvK0Lj61A9TF5TINPRLw1STOQFY2NtbUK0UUVpoohPgLIFFLwBISpkDfLaqRiCG13DZiXe
	vL/U33VqA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=TRrTJ1jZm0XUMVVVU/gV/azUYmKke4wyEiIzxYaskEw=;
 b=3TD4iEAa5z0918ENIAD9UxVHjDn6ypjdORbq/o3MOziAQLn2y1ZnbIN+xIaEaHclb0As+g
 58l/uRb7XMMAuEbOSN2Ue4Kh8MReixiWlQi5uyvfUGUgvgpdIeI9d9iu/KlurZfPHgCQ16
 TElbADAbR1FhIsJ8R5Mm6lfip/Blm699jZkGnbmpWLLZhJtUitEXrKx74t54p2WgINTc7J
 Eyh7FNLevwbWXZVNvHaiTDEXkbaqKcDlPV1IJ9AaJsejXEHERuNWJg72je9bpL2lFGOLKa
 tLZfD1PaRIHn/gSUkFHjmh94UUn70FgTc3BXS0N8kofNqvF8MBi3aOXfALZc7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=TRrTJ1jZm0XUMVVVU/gV/azUYmKke4wyEiIzxYaskEw=;
 b=bHJIqI1achWaHiH5/5wVKP2PP0lec8Ju34VdhGbJlNLEqtL/PZG2iVbcTXhNbUAOwhfTJu
 lVgqSlRYWtmPO0Bw==
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/kernel/entry.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -819,7 +819,7 @@ ENTRY(debug_exception)
 	 * preemption if we have HW breakpoints to preserve DEBUGCAUSE.DBNUM
 	 * meaning.
 	 */
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_HAVE_HW_BREAKPOINT)
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 	GET_THREAD_INFO(a2, a1)
 	l32i	a3, a2, TI_PRE_COUNT
 	addi	a3, a3, 1
