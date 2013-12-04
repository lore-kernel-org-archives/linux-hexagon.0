From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v3 07/19] smp, hexagon: kill SMP single function call interrupt
Date: Thu,  5 Dec 2013 00:12:58 +0800
Message-ID: <1386173591-28514-8-git-send-email-liuj97@gmail.com>
References: <1386173591-28514-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jFgAhCXf11kEwwrCtME8CnQCP2SkcWCLDxzZj8Cyhik=;
        b=PFZv5E6PeiAtS98ZUxNEuz5PiqDTy+ReB1+aU28CNp/pxW3S0JdJYgAmUTzzO5hvxP
         KumukAPxA84IeWcEnH2Inod5UFtuBtYXuKhTqKXn1/T7iUVfbOooKMttGWyImOAZoNJz
         QmMWATxqGaat/3N9bUVLpk/5ecM/2YKZvz3jMNb2qTobIRuSgxC7QJnjLGuG1QcGMLaE
         RGjhvxvGYDxqnfGmPSkqgIjM7HcGSGUuQJsyDWYFu6D13IUF0eSKsjyqotnGriXO4pez
         uGfrMUUpvmqVt8KPBmxPK/IohkletJwlxdcKqZ8fw8wMWteyCSfB5hcBBQAeQo/QXAE6
         DmZw==
In-Reply-To: <1386173591-28514-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Richard Kuo <rkuo@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiang Liu <liuj97@gmail.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-arch@vger.kernel.org

Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
similar to smp_call_function_single()" has unified the way to handle
single and multiple cross-CPU function calls. Now only one intterupt
is needed for architecture specific code to support generic SMP function
call interfaces, so kill the redundant single function call interrupt.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/hexagon/include/asm/smp.h | 1 -
 arch/hexagon/kernel/smp.c      | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/hexagon/include/asm/smp.h b/arch/hexagon/include/asm/smp.h
index 2b9b974..ca171c1 100644
--- a/arch/hexagon/include/asm/smp.h
+++ b/arch/hexagon/include/asm/smp.h
@@ -29,7 +29,6 @@ enum ipi_message_type {
 	IPI_NOP = 0,
 	IPI_RESCHEDULE = 1,
 	IPI_CALL_FUNC,
-	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
 	IPI_TIMER,
 };
diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 9faaa94..ff759f2 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -64,10 +64,6 @@ static inline void __handle_ipi(unsigned long *ops, struct ipi_data *ipi,
 			generic_smp_call_function_interrupt();
 			break;
 
-		case IPI_CALL_FUNC_SINGLE:
-			generic_smp_call_function_single_interrupt();
-			break;
-
 		case IPI_CPU_STOP:
 			/*
 			 * call vmstop()
@@ -248,7 +244,7 @@ void smp_send_stop(void)
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	send_ipi(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
+	send_ipi(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
-- 
1.8.1.2
