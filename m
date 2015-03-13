From: Alex Dowad <alexinbeijing@gmail.com>
Subject: [PATCH 12/32] hexagon: copy_thread(): rename 'arg' argument to 'kthread_arg'
Date: Fri, 13 Mar 2015 20:14:35 +0200
Message-ID: <1426270496-26362-2-git-send-email-alexinbeijing@gmail.com>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oq7apnlTylkjiDGiCPhaiX6nNWbxJxFSzqpQ17NU764=;
        b=DfE2rAwo+gvEKk4HXfKfmoqXsGSPGXYl2nqUp2gi5L1KpSBMm0mT5GA1FSkJjIkPVC
         en8sAlyDs8u1sAxPkreUx1H8JamQCWdXp0rTGxiZCsbWb/AaD/fc+04oRN1sZJaTUjin
         HFIfKl0S+1bz93itgSmMaIN1Ws0bI2s//XgqRbHz+osdJw9wiQaGqRNra7ts5MOMoOvc
         Mx+6duW9viI97GMbZ70yD7vtDd5VmBnQNksgNbkS4UOP6VVrFhG6dG8U+VD/Kbck0qde
         3oe0mr/G0LjALH23Al+Jg8L0XqKgcl9bod1SEtR2zUBqe7I4/jamMH6YBKV/BhjHvBcz
         cE8A==
In-Reply-To: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>

The 'arg' argument to copy_thread() is only ever used when forking a new
kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
with do_fork() and other arch-specific implementations of copy_thread()).

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/hexagon/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 0a0dd5c..6f27358 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -71,7 +71,7 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
  * Copy architecture-specific thread state
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct hexagon_switch_stack *ss;
@@ -94,10 +94,11 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
-		ss->r25 = arg;
+		ss->r25 = kthread_arg;
 		pt_set_kmode(childregs);
 		return 0;
 	}
-- 
2.0.0.GIT
