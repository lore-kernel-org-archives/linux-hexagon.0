From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [RFC PATCH 01/10] hexagon: smp: remove call to ipi_call_lock()/ipi_call_unlock()
Date: Tue, 29 May 2012 15:15:56 +0800
Message-ID: <1338275765-3217-2-git-send-email-yong.zhang0@gmail.com>
References: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=js2RduqTmnX/bOONYGUODQyETfhbtE6+fdP2l9NVdWs=;
        b=iodtBawSuXibBRsK03SiyV0uK0I/Q8ShiiBnfAIQKv6BFRyUIYdYOJnl7vs6XptIQ4
         hDmzh6Ys3x8395jTV9G/O3PhqzV3uj1QBNUMEVbuSnszjFuMmoYtblmzwnQka5bAHzuZ
         q2+Eb2RuijqkZ1FEwIVTaCURGnWSF3xFjwaXuMU8QZ6bMiq9z8KHC60I+dhggZfHFISn
         n0RzI0PkT0JkBdpgzTbUweEZU+/kI/KtHeJBJgbXmfPYVTMrIBTV4e+uEJ48KjM+eklA
         eJNIIP4hmALeBGi0YT+4C8jSfk5StLZY8174uBz6w40hlVeGC76qBZg2+L3xe5IpTUgI
         a3ag==
In-Reply-To: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com, nikunj@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, axboe@kernel.dk, mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org, akpm@linux-foundation.org, srivatsa.bhat@linux.vnet.ibm.com, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

From: Yong Zhang <yong.zhang@windriver.com>

1) call_function.lock used in smp_call_function_many() is just to protect
   call_function.queue and &data->refs, cpu_online_mask is outside of the
   lock. And it's not necessary to protect cpu_online_mask,
   because data->cpumask is pre-calculate and even if a cpu is brougt up
   when calling arch_send_call_function_ipi_mask(), it's harmless because
   validation test in generic_smp_call_function_interrupt() will take care
   of it.

2) For cpu down issue, stop_machine() will guarantee that no concurrent
   smp_call_fuction() is processing.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/kernel/smp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index f726462..149fbef 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -180,9 +180,7 @@ void __cpuinit start_secondary(void)
 
 	notify_cpu_starting(cpu);
 
-	ipi_call_lock();
 	set_cpu_online(cpu, true);
-	ipi_call_unlock();
 
 	local_irq_enable();
 
-- 
1.7.5.4
