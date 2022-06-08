From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Date: Wed, 08 Jun 2022 16:27:27 +0200
Message-ID: <20220608144516.172460444@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UoTZx1hq9H2CvH0rrTcV0HznPxDNWA5jpJDFLHo4BPo=; b=pWyQNOHjBAsuQpOso13wfLuQhy
        thcRQJ5QKxIY2Kx66e1E+YWNvAX7hqXi16FG/Yvv/6jL9gxmDHqHQPKhI/0ggi7JOI+l8ZF0tpt+J
        /gMx4WY4gISoTMfEmXYlgqylwRgmyofm3M3UVZmyco3ziu7Gt9h7q5c6wPiUbTexd+wgemxfyY0hu
        i2lO18Et3kvZasrH8//VkE/uwwYBCUK8seXG2zWjgtEkf9QnvC7u4APyLvyuKQI1XGO+wwn5fXDdh
        Vbf00ESlaotTdYhjQqpHmvpB4FpOELLEZl4FjWs1MRv1VKlYsOC56S74pB+SmAESsa1OcuRYoS/lu
        XKg+WotA==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
Xeons") wrecked intel_idle in two ways:

 - must not have tracing in idle functions
 - must return with IRQs disabled

Additionally, it added a branch for no good reason.

Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/idle/intel_idle.c |   48 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -129,21 +137,37 @@ static unsigned int mwait_substates __in
  *
  * Must be called under local_irq_disable().
  */
+
-static __cpuidle int intel_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index)
+static __always_inline int __intel_idle(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
 
-	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
-		local_irq_enable();
-
 	mwait_idle_with_hints(eax, ecx);
 
 	return index;
 }
 
+static __cpuidle int intel_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	return __intel_idle(dev, drv, index);
+}
+
+static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv, int index)
+{
+	int ret;
+
+	raw_local_irq_enable();
+	ret = __intel_idle(dev, drv, index);
+	raw_local_irq_disable();
+
+	return ret;
+}
+
 /**
  * intel_idle_s2idle - Ask the processor to enter the given idle state.
  * @dev: cpuidle device of the target CPU.
@@ -1801,6 +1824,9 @@ static void __init intel_idle_init_cstat
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
+		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
+			drv->states[drv->state_count].enter = intel_idle_irq;
+
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&


