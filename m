From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 34/51] trace: WARN on rcuidle
Date: Thu, 12 Jan 2023 20:43:48 +0100
Message-ID: <20230112195541.416110581@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEACA416CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 284CD41522
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C41AB4119C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 506C541181
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=BAfnvD9cLrzo61xSnZTsQNCRnrvqWps/XpXHA7FoM0k=; b=H7KH+Z08RTaT/3t06vLCizvkOG
 Nl80fuaYr06fmNux1Mx9qtYbuwqPX3UIm8aftX5Z28NOSi2Mj7BunBpu5fAFoNnbe42np6v2RdXQ3
 SsfqtFqcG9qi0lyDVOoDELfYVw4hTQlnjw9EXtt56vdDtyaKEp2Xa2RVM+DXP4oJW61oMArRyeeJ0
 ilQmOrnOonRkmnKqBoOTtnaRQcwrM4jm6DFFkWE7NCRk2QdP8h1Fs9cERrbXc91ROvdPufdHKZpV7
 QvcZXHXDtmJlQQByg/agmBAC+3sVjR/N/VTls/IF9+ePAkX1RGUky+6xWZXvuRPrOisPJZlzBILYP
 znwmGuiA==;
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
Cc: juri.lelli@redhat.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, nsekhar@ti.com, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.

ARCH_WANTS_NO_INSTR (a superset of CONFIG_GENERIC_ENTRY) disallows any
and all tracing when RCU isn't enabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tracepoint.h |   15 +++++++++++++--
 kernel/trace/trace.c       |    3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -178,6 +178,17 @@ static inline struct tracepoint *tracepo
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
+ * ARCH_WANTS_NO_INSTR archs are expected to have sanitized entry and idle
+ * code that disallow any/all tracing/instrumentation when RCU isn't watching.
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define RCUIDLE_COND(rcuidle)	(rcuidle)
+#else
+/* srcu can't be used from NMI */
+#define RCUIDLE_COND(rcuidle)	(rcuidle && in_nmi())
+#endif
+
+/*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
@@ -188,8 +199,8 @@ static inline struct tracepoint *tracepo
 		if (!(cond))						\
 			return;						\
 									\
-		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
+		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
+			return;						\
 									\
 		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3119,6 +3119,9 @@ void __trace_stack(struct trace_array *t
 		return;
 	}
 
+	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_GENERIC_ENTRY)))
+		return;
+
 	/*
 	 * When an NMI triggers, RCU is enabled via ct_nmi_enter(),
 	 * but if the above rcu_is_watching() failed, then the NMI
