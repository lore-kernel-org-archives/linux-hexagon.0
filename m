From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 05/36] cpuidle: Move IRQ state validation
Date: Wed, 08 Jun 2022 16:27:28 +0200
Message-ID: <20220608144516.235041924@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VIZr4C1ndt5VeFEZaPlCUg+5Hz4QhdyspUVrjQe3s0Q=; b=kqq4L3g1QhZht/evh2l5s39qps
        jnBmYIZTu4x4BpY6GPBYny1gorePfmz6gw7CvGZUUJ45UgB+3ZNOnUmDTa3XgcsU+AliBRJfiL13t
        KoZXJ4YmKkyUiI8J1DUyBTQtQ6SVAlRBjd2lYrcQy3VMZs1753vYk1wEdi55HMURyDlMTLnIp2/DG
        MGr0nky4kAarfcUiOqeOkLaYDyaA2nmZrRDB481pz0z3AmobbTQyJi9vcmXREbRCThBWV4zvIbtlx
        7V9kx4NPTBy1ipdrxzrHOS+OsGpY03vNc7rSx1DlzzyZ2hAby7AX1FdAQjZ3DF1PF+uzX0/EndUAP
        yetT9Drg==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Make cpuidle_enter_state() consistent with the s2idle variant and
verify ->enter() always returns with interrupts disabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -234,7 +234,11 @@ int cpuidle_enter_state(struct cpuidle_d
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
 		rcu_idle_enter();
+
 	entered_state = target_state->enter(dev, drv, index);
+	if (WARN_ONCE(!irqs_disabled(), "%ps leaked IRQ state", target_state->enter))
+		raw_local_irq_disable();
+
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
 		rcu_idle_exit();
 	start_critical_timings();
@@ -246,12 +250,8 @@ int cpuidle_enter_state(struct cpuidle_d
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


