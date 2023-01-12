From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 43/51] intel_idle: Add force_irq_on module param
Date: Thu, 12 Jan 2023 20:43:57 +0100
Message-ID: <20230112195541.967699392@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C33B411A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9107B41197
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E60A981E8C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33BBA81F84
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=JTqeKYECYSubBnJX/J9QEXdDkgA0NkIECFSZWgBtZ5c=; b=QLxqheLQZUqNb4ar6Mg/ZNYb8D
 KRXignWHOdRNYAZm1cWdi/oPzQSARGwohBPicdntdXc+jUrRsNN0/8D5g40oSZToLbikwu1cLT8Yq
 DGxNRPTtijYeX370Unaju4jHsAmBpKk4CtqN4rzPT0XsWknfadHdAv5RZqCyX7svpkdfdNo2Iy+X2
 deUTui/Bqe2X+k6Xu+YE1rX06haCXJkDpEbwkwuRoA1QmH69jGtF95HxJnRzgOZzuAinpm8tbEcEr
 TteyBVyGlHJftS/ry2M8MUzehKE9YMacr/muMS965kyZZf+vOtAukwARx8+SxhX8sDlxjf8Sr0LdM
 JiM9bSsw==;
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

For testing purposes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/idle/intel_idle.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1787,6 +1787,9 @@ static bool __init intel_idle_verify_cst
 	return true;
 }
 
+static bool force_irq_on __read_mostly;
+module_param(force_irq_on, bool, 0444);
+
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
@@ -1838,8 +1841,10 @@ static void __init intel_idle_init_cstat
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
-		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
+		if ((cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
+			printk("intel_idle: forced intel_idle_irq for state %d\n", cstate);
 			drv->states[drv->state_count].enter = intel_idle_irq;
+		}
 
 		if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
 		    cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IBRS) {
