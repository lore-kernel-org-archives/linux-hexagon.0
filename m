From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 04/44] cpuidle: Move IRQ state validation
Date: Mon, 19 Sep 2022 11:59:43 +0200
Message-ID: <20220919101520.602636221@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Return-path: <linux-clk-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wztoayxqdaRhc3fzwYQuz0RAh5ZT6y7bJFX0CXMuNy8=; b=ADXtthd/kB2UkNVNsBZX3mcAgx
        eb1wSA1egq4M07Od+XfETtj3lhd4iMNEvYwcU9NzeS13eZKp+mowXOQTzEFZK7CeroXVfNcUNAucm
        DFEs4ENnbXNf93/JuDzTXaj8dDvpaoObTItrP5rfAcPTaGTUO9u17CB7M9lBwSzhZqApt31copOyD
        THHS1zzgB7BqCqSJl0DeM5JLgmoPtje3pC9taSIf0jDAy3NiwNozoFE6k7Aa6gH0axWhSw0Ae2Kln
        k7+RKfh2KfpdBiXJ6godhy6Y1cfSrmD10KmQxJ5TbTEnSM6kxy+r95TYqIDfTireSwql4ofArgV57
        wDOwI0dQ==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

Make cpuidle_enter_state() consistent with the s2idle variant and
verify ->enter() always returns with interrupts disabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -236,7 +236,11 @@ int cpuidle_enter_state(struct cpuidle_d
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
 		ct_idle_enter();
+
 	entered_state = target_state->enter(dev, drv, index);
+	if (WARN_ONCE(!irqs_disabled(), "%ps leaked IRQ state", target_state->enter))
+		raw_local_irq_disable();
+
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
 		ct_idle_exit();
 	start_critical_timings();
@@ -248,12 +252,8 @@ int cpuidle_enter_state(struct cpuidle_d
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
 
-	if (broadcast) {
-		if (WARN_ON_ONCE(!irqs_disabled()))
-			local_irq_disable();
-
+	if (broadcast)
 		tick_broadcast_exit();
-	}
 
 	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();


