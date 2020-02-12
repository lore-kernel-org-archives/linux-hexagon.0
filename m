From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH 04/18] hexagon: replace setup_irq() by request_irq()
Date: Wed, 12 Feb 2020 13:33:05 +0530
Message-ID: <0413a7d89e648c6259b466b07b635a4509cdefd5.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=js3m1GRJWAzwHRVNbuv8Yo8F0b3Y/0tD1p72T0JsIgY=;
        b=iA394d5UYe1aB937cb4A8d6BIgNag9uRRjNEHG3KXbE83HUYelShMerBc/GzaJOTww
         UH0MjxzHm30XlYL4X1//xmuWvii0HglyFyf+4G4H0iMEaS/SMz+AsyOMCckoGeZhr79i
         gsp9h84e42oCD3ZkG0LlYTkpQwv7tbl9FTMxIs4eSRFVPpC2yIDmT/KQewIOC+7rdiOJ
         VikWfWXRy7xU4XxWt8rgKNZe5YTNzHZ1FCppNwBqvW0HVr4EypvkxIgiPIx1gLDD+KlM
         DL+AvKcBeI4MnD4VszncCPsOwMN2GMxaxMZFuf8WHdIHc5zilrXJoyVzTzNEvcGLBIWh
         PrEg==
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brian Cain <bcain@codeaurora.org>, Richard Fontana <rfontana@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Alexios Zavras <alexios.zavras@intel.com>

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/hexagon/kernel/smp.c  | 17 ++++++++---------
 arch/hexagon/kernel/time.c | 11 +++--------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0bbbe652a513..50a75af5540b 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -114,12 +114,6 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	local_irq_restore(flags);
 }
 
-static struct irqaction ipi_intdesc = {
-	.handler = handle_ipi,
-	.flags = IRQF_TRIGGER_RISING,
-	.name = "ipi_handler"
-};
-
 void __init smp_prepare_boot_cpu(void)
 {
 }
@@ -155,7 +149,9 @@ void start_secondary(void)
 
 	cpu = smp_processor_id();
 
-	setup_irq(BASE_IPI_IRQ + cpu, &ipi_intdesc);
+	if (request_irq(BASE_IPI_IRQ + cpu, handle_ipi, IRQF_TRIGGER_RISING,
+			"ipi_handler", NULL))
+		pr_err("request_irq() on %s failed\n", "ipi_handler");
 
 	/*  Register the clock_event dummy  */
 	setup_percpu_clockdev();
@@ -213,8 +209,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		set_cpu_present(i, true);
 
 	/*  Also need to register the interrupts for IPI  */
-	if (max_cpus > 1)
-		setup_irq(BASE_IPI_IRQ, &ipi_intdesc);
+	if (max_cpus > 1) {
+		if (request_irq(BASE_IPI_IRQ, handle_ipi, IRQF_TRIGGER_RISING,
+				"ipi_handler", NULL))
+			pr_err("request_irq() on %s failed\n", "ipi_handler");
+	}
 }
 
 void smp_send_reschedule(int cpu)
diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index f99e9257bed4..f5a558a9d287 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -143,13 +143,6 @@ static irqreturn_t timer_interrupt(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-/*  This should also be pulled from devtree  */
-static struct irqaction rtos_timer_intdesc = {
-	.handler = timer_interrupt,
-	.flags = IRQF_TIMER | IRQF_TRIGGER_RISING,
-	.name = "rtos_timer"
-};
-
 /*
  * time_init_deferred - called by start_kernel to set up timer/clock source
  *
@@ -195,7 +188,9 @@ void __init time_init_deferred(void)
 #endif
 
 	clockevents_register_device(ce_dev);
-	setup_irq(ce_dev->irq, &rtos_timer_intdesc);
+	if (request_irq(ce_dev->irq, timer_interrupt,
+			IRQF_TIMER | IRQF_TRIGGER_RISING, "rtos_timer", NULL))
+		pr_err("request_irq() on %s failed\n", "rtos_timer");
 }
 
 void __init time_init(void)
-- 
2.24.1

