From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 02/51] x86/idle: Replace x86_idle with a static_call
Date: Thu, 12 Jan 2023 20:43:16 +0100
Message-ID: <20230112195539.453613251@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C0244009B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AE9641837
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26BE74182E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF09F4180F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=tPOdw9LFGiPCDTfwXmDjC03yH+Atd2yWpwgqK4SP6Bs=; b=MCFGk/zfAQ1MOxe655CfrxSndB
 KMsj8OM47QEIEF+dE7LPbkmxg/PQAts31gFJ5Xz3no3m62IuisxdrSXrLN8SYgr1mtDIwtR8p1Foy
 vgMnbz7h6ch5F50b53yunuqk9MFEuX5uEMORRcRhTqQRFnQzXIgNjlWLrzQ8IyZodgjiEI5j/hfm2
 jtsLGmSu2xYww6Em1c+Sd7XPqSMSM0BgTy1Y9iUSaQMsmpIltEMs2Z+FvPcdV8LPGTs0uCR8XY70j
 Jdml4OVol/2E06Nb6eijodGglka4wn0K9TaSFCWA1YgF/306McxeUsk6Jgniwje3STV7G1K2gesSb
 SZObcOlw==;
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

Typical boot time setup; no need to suffer an indirect call for that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/x86/kernel/process.c |   50 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -24,6 +24,7 @@
 #include <linux/cpuidle.h>
 #include <linux/acpi.h>
 #include <linux/elf-randomize.h>
+#include <linux/static_call.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
 #include <asm/cpu.h>
@@ -692,7 +693,23 @@ void __switch_to_xtra(struct task_struct
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-static void (*x86_idle)(void);
+/*
+ * We use this if we don't have any better idle routine..
+ */
+void __cpuidle default_idle(void)
+{
+	raw_safe_halt();
+}
+#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
+EXPORT_SYMBOL(default_idle);
+#endif
+
+DEFINE_STATIC_CALL_NULL(x86_idle, default_idle);
+
+static bool x86_idle_set(void)
+{
+	return !!static_call_query(x86_idle);
+}
 
 #ifndef CONFIG_SMP
 static inline void play_dead(void)
@@ -715,28 +732,17 @@ void arch_cpu_idle_dead(void)
 /*
  * Called from the generic idle code.
  */
-void arch_cpu_idle(void)
-{
-	x86_idle();
-}
-
-/*
- * We use this if we don't have any better idle routine..
- */
-void __cpuidle default_idle(void)
+void __cpuidle arch_cpu_idle(void)
 {
-	raw_safe_halt();
+	static_call(x86_idle)();
 }
-#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
-EXPORT_SYMBOL(default_idle);
-#endif
 
 #ifdef CONFIG_XEN
 bool xen_set_default_idle(void)
 {
-	bool ret = !!x86_idle;
+	bool ret = x86_idle_set();
 
-	x86_idle = default_idle;
+	static_call_update(x86_idle, default_idle);
 
 	return ret;
 }
@@ -859,20 +865,20 @@ void select_idle_routine(const struct cp
 	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
 #endif
-	if (x86_idle || boot_option_idle_override == IDLE_POLL)
+	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
 		return;
 
 	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
 		pr_info("using AMD E400 aware idle routine\n");
-		x86_idle = amd_e400_idle;
+		static_call_update(x86_idle, amd_e400_idle);
 	} else if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
-		x86_idle = mwait_idle;
+		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		x86_idle = tdx_safe_halt;
+		static_call_update(x86_idle, tdx_safe_halt);
 	} else
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 }
 
 void amd_e400_c1e_apic_setup(void)
@@ -925,7 +931,7 @@ static int __init idle_setup(char *str)
 		 * To continue to load the CPU idle driver, don't touch
 		 * the boot_option_idle_override.
 		 */
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 		boot_option_idle_override = IDLE_HALT;
 	} else if (!strcmp(str, "nomwait")) {
 		/*
