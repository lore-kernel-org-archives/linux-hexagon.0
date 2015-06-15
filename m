From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] Hexagon: kernel: use IRQCHIP_SKIP_SET_WAKE instead of irq_set_wake callback
Date: Mon, 15 Jun 2015 17:56:17 +0100
Message-ID: <1434387377-17183-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>

Commit 60f96b41f71d ("genirq: Add IRQCHIP_SKIP_SET_WAKE flag")
introduced a new flag to skip the irq_set_wake callback in the irqchip
core to avoid adding dummy irq_set_wake in the irqchip implementations.

This patch removes the dummy callback and sets the IRQCHIP_SKIP_SET_WAKE
flags.

Cc: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/hexagon/kernel/irq_cpu.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/hexagon/kernel/irq_cpu.c b/arch/hexagon/kernel/irq_cpu.c
index 85883e1fdc12..36b8ccfda43a 100644
--- a/arch/hexagon/kernel/irq_cpu.c
+++ b/arch/hexagon/kernel/irq_cpu.c
@@ -43,24 +43,12 @@ static void eoi_irq(struct irq_data *data)
 	__vmintop_globen((long) data->irq);
 }
 
-/* Power mamangement wake call. We don't need this, however,
- * if this is absent, then an -ENXIO error is returned to the
- * msm_serial driver, and it fails to correctly initialize.
- * This is a bug in the msm_serial driver, but, for now, we
- * work around it here, by providing this bogus handler.
- * XXX FIXME!!! remove this when msm_serial is fixed.
- */
-static int set_wake(struct irq_data *data, unsigned int on)
-{
-	return 0;
-}
-
 static struct irq_chip hexagon_irq_chip = {
 	.name		= "HEXAGON",
 	.irq_mask	= mask_irq,
 	.irq_unmask	= unmask_irq,
-	.irq_set_wake	= set_wake,
-	.irq_eoi	= eoi_irq
+	.irq_eoi	= eoi_irq,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
 /**
-- 
1.9.1
