From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/36] cpuidle,riscv: Push RCU-idle into driver
Date: Wed, 08 Jun 2022 16:27:29 +0200
Message-ID: <20220608144516.297980240@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cRgbn3QvpupGZaeUDgwKs7FEGzBWq3dUbK0A/YX8NGM=; b=ia4syF8cgg/6m5v3rZXIu02WY+
        Q3HePbOq+lusahEVPAuv+ncctlM4B9LyQ4IDnvEM36XkiL3pQJQOuJOs9y3ihqwJctvWOB66u3JYJ
        Qlt03iuvX/XofwOn8uNcW04i6nCJxlVEF9rLtDq+x0rD/Bc0A8t60ry8e0E2SVYvpfWb+XQCvkuTI
        tNiz4zf5Ag+DBhIJ7WsXCnJ+D0Uq+V1s+5EQfEWdabNYdzP3AqCW24rU9LjP4pHcIEaJ/PfULfT6D
        4hFRz16hmpY73XFLbpgY1hKdTTQepj9C9EdlQCPakl0mKOu1mjEe+GnDEVBUwMaBhtc9PVxMw7FCv
        arFlzdAQ==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Doing RCU-idle outside the driver, only to then temporarily enable it
again, at least twice, before going idle is daft.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -116,12 +116,12 @@ static int __sbi_enter_domain_idle_state
 		return -1;
 
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
-	rcu_irq_enter_irqson();
 	if (s2idle)
 		dev_pm_genpd_suspend(pd_dev);
 	else
 		pm_runtime_put_sync_suspend(pd_dev);
-	rcu_irq_exit_irqson();
+
+	rcu_idle_enter();
 
 	if (sbi_is_domain_state_available())
 		state = sbi_get_domain_state();
@@ -130,12 +130,12 @@ static int __sbi_enter_domain_idle_state
 
 	ret = sbi_suspend(state) ? -1 : idx;
 
-	rcu_irq_enter_irqson();
+	rcu_idle_exit();
+
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
 	else
 		pm_runtime_get_sync(pd_dev);
-	rcu_irq_exit_irqson();
 
 	cpu_pm_exit();
 
@@ -246,6 +246,7 @@ static int sbi_dt_cpu_init_topology(stru
 	 * of a shared state for the domain, assumes the domain states are all
 	 * deeper states.
 	 */
+	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[state_count - 1].enter = sbi_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle =
 					sbi_enter_s2idle_domain_idle_state;


