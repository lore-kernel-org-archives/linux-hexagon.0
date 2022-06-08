From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 16/36] rcu: Fix rcu_idle_exit()
Date: Wed, 08 Jun 2022 16:27:39 +0200
Message-ID: <20220608144516.935970247@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=Ae56F2/vHSxAMY+0KpLDtlvNNteu31Pblave+ocppBw=; b=K8Ynm/svRXkkOXUoDfBvEs9ZFK
 qWXYZy+/5CqUIjZ31FPJ7xPNOIntKDH8NSfrS8D9IkyLAoFrHvJMHJIL/IcnOIM7nqISgd0gcoDeE
 M8QwoOkYRBsSJ6LT9EQT7VUIsk+Z6r7wIXAFTOjV+qSGSdym/gNXacQGPlu5y6oCjnxUFjzOxnG6i
 Qnh3s+Cj3bWdVkKJ0fKWJQJeEH2PS1tbGo8HnFfis2/BavxNxwTBZTq7iTayiBsKwAc/kQ4fijj9Z
 RSxzjU7orl0A9t/vtgrMCy+RX4IT1VlY5omzQIH8HgAO6TFwqNP7RiyW7pf7sKmhryRMbaaQJQ5W8
 0pAFiEvA==;
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, paul

Current rcu_idle_exit() is terminally broken because it uses
local_irq_{save,restore}(), which are traced which uses RCU.

However, now that all the callers are sure to have IRQs disabled, we
can remove these calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -659,7 +659,7 @@ static noinstr void rcu_eqs_enter(bool u
  * If you add or remove a call to rcu_idle_enter(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_enter(void)
+void noinstr rcu_idle_enter(void)
 {
 	lockdep_assert_irqs_disabled();
 	rcu_eqs_enter(false);
@@ -896,13 +896,10 @@ static void noinstr rcu_eqs_exit(bool us
  * If you add or remove a call to rcu_idle_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_exit(void)
+void noinstr rcu_idle_exit(void)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
+	lockdep_assert_irqs_disabled();
 	rcu_eqs_exit(false);
-	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(rcu_idle_exit);
