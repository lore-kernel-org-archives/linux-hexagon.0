From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 33/44] ftrace: WARN on rcuidle
Date: Mon, 19 Sep 2022 12:00:12 +0200
Message-ID: <20220919101522.573936213@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E188425BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68A8142540
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B41276FB85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5F1460BC3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=d1PXrA0ji5y7WX9aOTLSAuRcBGPwqyEk8vh/reRf4ZE=; b=LWO0au/rvI8XBtiLpmPp+Hj6ty
 aVN9bB7ygtes6LLRtSeEdagzQF9hUqR0AP2Xlew8lTJ1+l9gYN1fheWby45WO7HUyga7mVz9FhOWt
 eiKINrvkyp9Bqyk9kjLcHDbPWOp25a01H/raJMCYIgNb4IrTiq9QT/AhVOBh+cjOloRDnZxT+XWaF
 yLrkkOPgJrBGclK4tPXgrx0gLmayYBzdMjZH7m6HBUXtMXqr3Kpvk05mGoh2fnRJUMQaUjvpUM+T/
 ddTH7+6dZSJ3yLO+E1HwSdjEk51sYXwh0pWg9z+JrKcWs/qshJKYcJvb6hFkNZVoCc5bOF2D+D9a1
 zFoJmGCw==;
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

CONFIG_GENERIC_ENTRY disallows any and all tracing when RCU isn't
enabled.

XXX if s390 (the only other GENERIC_ENTRY user as of this writing)
isn't comfortable with this, we could switch to
HAVE_NOINSTR_VALIDATION which is x86_64 only atm.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/tracepoint.h |   13 ++++++++++++-
 kernel/trace/trace.c       |    3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -178,6 +178,16 @@ static inline struct tracepoint *tracepo
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
+ * CONFIG_GENERIC_ENTRY archs are expected to have sanitized entry and idle
+ * code that disallow any/all tracing/instrumentation when RCU isn't watching.
+ */
+#ifdef CONFIG_GENERIC_ENTRY
+#define RCUIDLE_COND(rcuidle)	(rcuidle)
+#else
+#define RCUIDLE_COND(rcuidle)	(rcuidle && in_nmi())
+#endif
+
+/*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
@@ -189,7 +199,8 @@ static inline struct tracepoint *tracepo
 			return;						\
 									\
 		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
+		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
+			return;						\
 									\
 		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3104,6 +3104,9 @@ void __trace_stack(struct trace_array *t
 		return;
 	}
 
+	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_GENERIC_ENTRY)))
+		return;
+
 	/*
 	 * When an NMI triggers, RCU is enabled via ct_nmi_enter(),
 	 * but if the above rcu_is_watching() failed, then the NMI
