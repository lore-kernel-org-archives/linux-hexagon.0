From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 01/44] x86/perf/amd: Remove tracing from perf_lopwr_cb()
Date: Mon, 19 Sep 2022 11:59:40 +0200
Message-ID: <20220919101520.399971897@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B3EF41700
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 839E14170B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FD68425CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B6F9425D3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=YOWU43M4IjsvcmJXQwOIFJh+WuCbnSytdcIdnv65DkY=; b=AlyUL2n21Ay/eo4jzhxLVHbjtT
 UQyURrUAFbSeZXMu+qSEhGh5tsE0SavJsEpBS1K1IB5BR2w0cqpFKFUfHSoscIwaG1ohk66JX0VfJ
 mLJwvAXSiH7Gt28S3XByOnqo3uEOTiM0P9sWLADHW7udnoML9bRxDpBpb3wcuoeOVqMcXphlfL21A
 my5k9xukM3nRKLIX0+tEddJpYBIiN6NUySN7jnWjWc6oY49Xk2EEzfYF2TBITi40qvcU6x6hpac+t
 3G1ys0gAkcnegE95WH6F0JTlIbD+ZqauWXPqFE9mdWImdtoBd2u5kmXCBlZVlWagaRZnaojLqXDwM
 xgmg5ltg==;
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

The perf_lopwr_cb() is called from the idle routines; there is no RCU
there, we must not enter tracing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/amd/brs.c         |   13 +++++--------
 arch/x86/include/asm/perf_event.h |    2 +-
 2 files changed, 6 insertions(+), 9 deletions(-)

--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -41,18 +41,15 @@ static inline unsigned int brs_to(int id
 	return MSR_AMD_SAMP_BR_FROM + 2 * idx + 1;
 }
 
-static inline void set_debug_extn_cfg(u64 val)
+static __always_inline void set_debug_extn_cfg(u64 val)
 {
 	/* bits[4:3] must always be set to 11b */
-	wrmsrl(MSR_AMD_DBG_EXTN_CFG, val | 3ULL << 3);
+	__wrmsr(MSR_AMD_DBG_EXTN_CFG, val | 3ULL << 3, val >> 32);
 }
 
-static inline u64 get_debug_extn_cfg(void)
+static __always_inline u64 get_debug_extn_cfg(void)
 {
-	u64 val;
-
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, val);
-	return val;
+	return __rdmsr(MSR_AMD_DBG_EXTN_CFG);
 }
 
 static bool __init amd_brs_detect(void)
@@ -338,7 +335,7 @@ void amd_pmu_brs_sched_task(struct perf_
  * called from ACPI processor_idle.c or acpi_pad.c
  * with interrupts disabled
  */
-void perf_amd_brs_lopwr_cb(bool lopwr_in)
+void noinstr perf_amd_brs_lopwr_cb(bool lopwr_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	union amd_debug_extn_cfg cfg;
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -554,7 +554,7 @@ extern void perf_amd_brs_lopwr_cb(bool l
 
 DECLARE_STATIC_CALL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
 
-static inline void perf_lopwr_cb(bool lopwr_in)
+static __always_inline void perf_lopwr_cb(bool lopwr_in)
 {
 	static_call_mod(perf_lopwr_cb)(lopwr_in);
 }
