From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 35/51] trace,hardirq: No moar _rcuidle() tracing
Date: Thu, 12 Jan 2023 20:43:49 +0100
Message-ID: <20230112195541.477416709@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D313820B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC060820B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DAA3160EB3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00E4A60EA7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=dY+sZF8zXVTImEusizdFam+mvD2uBaZ1sCttd0zpvx8=; b=Zvs6hw3dC5vZ9/e3RVPulXa4vo
 0LGVycD5ek8na8AFjgsGQDoJWr/GILDhDZZRLr5jcFSKcCvqgSV1b0VFMw8bgB2ismeu3VWWkJ8fT
 iOKXjPhSfP3BdrVt2KEx/AK1uUamJSxIAfVV8e3ZVtl5XXXBjts18yo5G52OU+rSmciaSR1qJTQOp
 jrcY4VRNY3AgQZacZ+/mcgJwzOUsYcfiXdjCWRnrFGw8rdAFr9f26ET+gY1q1gut10GpU+iYN1B13
 B3mDdBlf4EOS02q8DY62DSvt/0WRC0IcizLnoP75ZxAWdBkF7dWM1rEkjziDX2zFcPQkr7kw9pR2z
 NdL9gE2Q==;
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, nsekhar@ti.com, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com

Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
_rcuidle() tracepoint through local_irq_{en,dis}able().

For 'sane' configs, these calls will only happen with RCU enabled and
as such can use the regular tracepoint. This also means it's possible
to trace them from NMI context again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace_preemptirq.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -20,6 +20,15 @@
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
 /*
+ * ...
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define trace(point)	trace_##point
+#else
+#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
+#endif
+
+/*
  * Like trace_hardirqs_on() but without the lockdep invocation. This is
  * used in the low level entry code where the ordering vs. RCU is important
  * and lockdep uses a staged approach which splits the lockdep hardirq
@@ -28,8 +37,7 @@ static DEFINE_PER_CPU(int, tracing_irq_c
 void trace_hardirqs_on_prepare(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -40,8 +48,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepar
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -63,8 +70,7 @@ void trace_hardirqs_off_finish(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 
 }
@@ -78,8 +84,7 @@ void trace_hardirqs_off(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
