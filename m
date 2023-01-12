From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 50/51] cpuidle: Comments about noinstr/__cpuidle
Date: Thu, 12 Jan 2023 20:44:04 +0100
Message-ID: <20230112195542.397238052@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CC95411AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33B8F415A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D71781FE3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E57F81F84
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=Un035BTYhsjREpZ4dpy/MHkkoifcKtLiH3nYidAuKL8=; b=Cm0cZvx68fOfy3spcfZv1mTyVN
 I+8nrlfsPTd1YX3ddHPT1tHDaXW6BjutPk9wWpEkW/bLt/CWl0wIYVqUtY/RdgLL1CXyaqx22TN13
 FVZ1Pu0U/vSbCFKDZV31A7dnMTEMlJVmC5JGl3kdM1NWuU5ROH7eP9w1vfRDaocn4JsSLc4YrPw5Q
 92CcZo9NDx6pgppJhIre9PG6+hEZcTjM22p8n4v6T0CGJXpMaxOqy0BIl6Hi1HTM4//PS/Q9GRA+r
 r+JvkRTeh7iePDi9/CdHQ2TT4CowIVH97n1vCAGs/Zkz6o47jhi7eL2nyxXG48k7aP4oDQHY9NYIK
 bJ7NrLVg==;
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

Add a few words on noinstr / __cpuidle usage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle.c      |   12 ++++++++++++
 include/linux/compiler_types.h |   10 ++++++++++
 2 files changed, 22 insertions(+)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -252,6 +252,18 @@ noinstr int cpuidle_enter_state(struct c
 		instrumentation_begin();
 	}
 
+	/*
+	 * NOTE!!
+	 *
+	 * For cpuidle_state::enter() methods that do *NOT* set
+	 * CPUIDLE_FLAG_RCU_IDLE RCU will be disabled here and these functions
+	 * must be marked either noinstr or __cpuidle.
+	 *
+	 * For cpuidle_state::enter() methods that *DO* set
+	 * CPUIDLE_FLAG_RCU_IDLE this isn't required, but they must mark the
+	 * function calling ct_cpuidle_enter() as noinstr/__cpuidle and all
+	 * functions called within the RCU-idle region.
+	 */
 	entered_state = target_state->enter(dev, drv, index);
 
 	if (WARN_ONCE(!irqs_disabled(), "%ps leaked IRQ state", target_state->enter))
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -233,6 +233,16 @@ struct ftrace_likely_data {
 
 #define noinstr __noinstr_section(".noinstr.text")
 
+/*
+ * The __cpuidle section is used twofold:
+ *
+ *  1) the original use -- identifying if a CPU is 'stuck' in idle state based
+ *     on it's instruction pointer. See cpu_in_idle().
+ *
+ *  2) supressing instrumentation around where cpuidle disables RCU; where the
+ *     function isn't strictly required for #1, this is interchangeable with
+ *     noinstr.
+ */
 #define __cpuidle __noinstr_section(".cpuidle.text")
 
 #endif /* __KERNEL__ */
