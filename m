From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/23] hexagon/time: Migrate to new 'set-state' interface
Date: Thu, 16 Jul 2015 16:56:19 +0530
Message-ID: <519cb907e596d13b9f1e3fd1ee689acbbbeb56c7.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

Migrate hexagon driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/hexagon/kernel/time.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index 17fbf45bf150..a6a1d1f8309a 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -97,20 +97,6 @@ static int set_next_event(unsigned long delta, struct clock_event_device *evt)
 	return 0;
 }
 
-/*
- * Sets the mode (periodic, shutdown, oneshot, etc) of a timer.
- */
-static void set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt)
-{
-	switch (mode) {
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		/* XXX implement me */
-	default:
-		break;
-	}
-}
-
 #ifdef CONFIG_SMP
 /*  Broadcast mechanism  */
 static void broadcast(const struct cpumask *mask)
@@ -119,13 +105,13 @@ static void broadcast(const struct cpumask *mask)
 }
 #endif
 
+/* XXX Implement set_state_shutdown() */
 static struct clock_event_device hexagon_clockevent_dev = {
 	.name		= "clockevent",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 400,
 	.irq		= RTOS_TIMER_INT,
 	.set_next_event = set_next_event,
-	.set_mode	= set_mode,
 #ifdef CONFIG_SMP
 	.broadcast	= broadcast,
 #endif
@@ -146,7 +132,6 @@ void setup_percpu_clockdev(void)
 
 	dummy_clock_dev->features = CLOCK_EVT_FEAT_DUMMY;
 	dummy_clock_dev->cpumask = cpumask_of(cpu);
-	dummy_clock_dev->mode = CLOCK_EVT_MODE_UNUSED;
 
 	clockevents_register_device(dummy_clock_dev);
 }
-- 
2.4.0
