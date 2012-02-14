From: Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH 3/3] um: Avoid raw handling of cpu_online_map
Date: Tue, 14 Feb 2012 14:49:44 -0800
Message-ID: <1329259784-20592-4-git-send-email-venki@google.com>
References: <87wr7pbwbz.fsf@rustcorp.com.au>
 <1329259784-20592-1-git-send-email-venki@google.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=G1uOMzHgzzP7ZeAyvXYF0gGf+HQmOoIOsfXAlX0EVpI=;
        b=y8rVfgFMJ803msfIH96qh8JPSFAMFr1rbrxpWvullywNL2bM8yd92VHKIEjiMTKi/C
         +0YwQDFfXaCWYnGqGrrnjWaZXmJVO+uXuc3OjN2jqV+1Zdmj8CN3bkq3sBea4rc8NxG2
         M+9aw25Ejr0Tgbzaqiin8DoWQbr63wU5yueM4=
In-Reply-To: <1329259784-20592-1-git-send-email-venki@google.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tony Luck <tony.luck@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KOSAKI Motohiro <kosaki.motohiro@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Mike Travis <travis@sgi.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Venkatesh Pallipadi <venki@google.com>

Use init_cpu_online and set_cpu_online instead.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 arch/um/kernel/skas/process.c |    2 +-
 arch/um/kernel/smp.c          |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 2e9852c..5daa0f5 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -41,7 +41,7 @@ static int __init start_kernel_proc(void *unused)
 	cpu_tasks[0].pid = pid;
 	cpu_tasks[0].task = current;
 #ifdef CONFIG_SMP
-	cpu_online_map = cpumask_of_cpu(0);
+	init_cpu_online(cpumask_of(0));
 #endif
 	start_kernel();
 	return 0;
diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
index 155206a..b5d2ca9 100644
--- a/arch/um/kernel/smp.c
+++ b/arch/um/kernel/smp.c
@@ -76,7 +76,7 @@ static int idle_proc(void *cpup)
 		cpu_relax();
 
 	notify_cpu_starting(cpu);
-	cpu_set(cpu, cpu_online_map);
+	set_cpu_online(cpu, true);
 	default_idle();
 	return 0;
 }
@@ -110,8 +110,8 @@ void smp_prepare_cpus(unsigned int maxcpus)
 	for (i = 0; i < ncpus; ++i)
 		set_cpu_possible(i, true);
 
-	cpu_clear(me, cpu_online_map);
-	cpu_set(me, cpu_online_map);
+	set_cpu_online(me, false);
+	set_cpu_online(me, true);
 	cpu_set(me, cpu_callin_map);
 
 	err = os_pipe(cpu_data[me].ipi_pipe, 1, 1);
@@ -138,7 +138,7 @@ void smp_prepare_cpus(unsigned int maxcpus)
 
 void smp_prepare_boot_cpu(void)
 {
-	cpu_set(smp_processor_id(), cpu_online_map);
+	set_cpu_online(smp_processor_id(), true);
 }
 
 int __cpu_up(unsigned int cpu)
-- 
1.7.7.3
