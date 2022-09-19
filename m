From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 23/44] arm,smp: Remove trace_.*_rcuidle() usage
Date: Mon, 19 Sep 2022 12:00:02 +0200
Message-ID: <20220919101521.886766952@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1589F425DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5B67425CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78443416FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A077E416F2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=rveYe0whW8HL+t/HGSaazkf4IJzq2XAc7vdeRKjh+gA=; b=eDRmeX8n8KBUn6/CAr9rKpy/RP
 2UJXTWSy9Z5hbIlL+Y6yo0LWkUZm1nFVVk0qgHKpQWM9+mi6/uumgd0hvjnMAn3XSVpZxWzD8m+74
 JXBp+z4yXIwfYDRZUAs3OZnRMmPjEIXxm+y8lmvo6cAM8EXbFG0XxYBS/Qgd9MoowJrgyt4+6rd8d
 zj5sYNjaG7FxjQ49N6+Lnd95idPaT1s+5VG/BByjgLeZD+rMnz31Zul5NKFlGosM11YW0NCf20GGn
 k/69f9ALqsPoW6rpNDxkzlxkZkdxlPYq25PvApPNCIfeE0FIawzbekVyy/XMjyx0JlunPKd8sOvH0
 xy17ZOgA==;
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

None of these functions should ever be ran with RCU disabled anymore.

Specifically, do_handle_IPI() is only called from handle_IPI() which
explicitly does irq_enter()/irq_exit() which ensures RCU is watching.

The problem with smp_cross_call() was, per commit 7c64cc0531fa ("arm: Use
_rcuidle for smp_cross_call() tracepoints"), that
cpuidle_enter_state_coupled() already had RCU disabled, but that's
long been fixed by commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
deeper into the idle path").

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/kernel/smp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -639,7 +639,7 @@ static void do_handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
+		trace_ipi_entry(ipi_types[ipinr]);
 
 	switch (ipinr) {
 	case IPI_WAKEUP:
@@ -686,7 +686,7 @@ static void do_handle_IPI(int ipinr)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+		trace_ipi_exit(ipi_types[ipinr]);
 }
 
 /* Legacy version, should go away once all irqchips have been converted */
@@ -709,7 +709,7 @@ static irqreturn_t ipi_handler(int irq,
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	trace_ipi_raise(target, ipi_types[ipinr]);
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
