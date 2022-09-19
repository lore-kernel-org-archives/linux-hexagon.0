From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 18/44] cpuidle,
 intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE *again*
Date: Mon, 19 Sep 2022 11:59:57 +0200
Message-ID: <20220919101521.543128460@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2C1E6FBA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAA2C6FB7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C527416ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59537416FD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=DdEsMVUZF4If17doP56YIzy8DGEaYRA+HGcY5bau4R0=; b=ffPA43DaWXeDYiTFZClhauINRG
 z19ZJjXssAtxfxlr1fPti4t6DT2wiH5H5okV4mosIrd7GgaAlF0oC1lqVqmVBftJAA2vQfkPcKfUB
 /U0vTN34R4a+hHK83IQXeWvWCqPzz0nnTgQXXHdkzX9BwVsJH4tOHGf0mHnfP5CWPuYM278I5ENHD
 WehTtuDKTueI72NRvdFd1F1VLL8jZu66MtULr4TFip3m9C+lCpQvpdh0UZepmdn4+5v/s8V1gFfja
 AgtzRJ3HHWQbfFESfeToxLhqhuejqmj7MmjOzZwdMUMyEXl+kBGtul38srQpHF4LuFHeP66Lijddw
 WsNauTzQ==;
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

  vmlinux.o: warning: objtool: intel_idle_irq+0x10c: call to trace_hardirqs_off() leaves .noinstr.text section

As per commit 32d4fd5751ea ("cpuidle,intel_idle: Fix
CPUIDLE_FLAG_IRQ_ENABLE"):

  "must not have tracing in idle functions"

Clearly people can't read and tinker along until splat dissapears.
This straight up reverts commit d295ad34f236 ("intel_idle: Fix false
positive RCU splats due to incorrect hardirqs state").

It doesn't re-introduce the problem because preceding patches fixed it
properly.

Fixes: d295ad34f236 ("intel_idle: Fix false positive RCU splats due to incorrect hardirqs state")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/idle/intel_idle.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -168,13 +168,7 @@ static __cpuidle int intel_idle_irq(stru
 
 	raw_local_irq_enable();
 	ret = __intel_idle(dev, drv, index);
-
-	/*
-	 * The lockdep hardirqs state may be changed to 'on' with timer
-	 * tick interrupt followed by __do_softirq(). Use local_irq_disable()
-	 * to keep the hardirqs state correct.
-	 */
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	return ret;
 }
