From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 15/36] cpuidle,cpu_pm: Remove RCU fiddling from cpu_pm_{enter,exit}()
Date: Wed, 08 Jun 2022 16:27:38 +0200
Message-ID: <20220608144516.871305980@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fn1U7MEbZz2QK5hbMetRGs1LaJ4dLQ5TDl+y9fGIqjs=; b=AHoLDlFIJpM2yJSN34mWYuYDyZ
        RrXBAbCHcbiLETtqHyostv6hzGyHst5r7VORCZGrERmGvvRqMr2NwXjLQsK1TYGzVvVJBLCgsCf3j
        LieJtCZHAdjEyntbLFkbTU93xwC08IjFigevejKo+3rMPJ833Xxh7xrrmgzcKasuf6t3frm6PkmxU
        vZovY0XqO2YqPGD7SFjfk9rslAidePmYi7ReTaMHUlcVRH/amspREeDyWUmyOeqnEP6bQYjeAjWHS
        JBInW3LvF6tscP+ZjodqILQopYhhA13ptDRMV4kNqtb9FKzkYAPZG/ay8CNlYM5sVD+3xA6vTTC0E
        vR1dCMqg==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

All callers should still have RCU enabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/cpu_pm.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -30,16 +30,9 @@ static int cpu_pm_notify(enum cpu_pm_eve
 {
 	int ret;
 
-	/*
-	 * This introduces a RCU read critical section, which could be
-	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
-	 * this.
-	 */
-	rcu_irq_enter_irqson();
 	rcu_read_lock();
 	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
 	rcu_read_unlock();
-	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
@@ -49,11 +42,9 @@ static int cpu_pm_notify_robust(enum cpu
 	unsigned long flags;
 	int ret;
 
-	rcu_irq_enter_irqson();
 	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
 	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
 	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
-	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }


