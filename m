From: Dmitry Safonov <dima@arista.com>
Subject: [PATCHv2 14/50] hexagon: Add show_stack_loglvl()
Date: Mon, 16 Mar 2020 14:38:40 +0000
Message-ID: <20200316143916.195608-15-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ML9QnmYycAYqBuHmwB02FgVr/qb/2XNl2+pJ9kSVZfk=;
        b=FAz6w/yr23y1uFPy/XFwW5Sl96On4ZY7zXaQxi6Dv8Kl46TSTnJbw7suk4JfORLhDu
         qfsd1nfrliQg2zAN1Sf8A+dUcQMAWIq18/8v+98blt1kKvwHHR68zpmpKHTcsEivUUuU
         DZUfdfZLdWkvMIfM1lJEJIJ/m3CjsiKAkhXAO1/1n4+XaJ5ziFyFg+Q7y4c8pebckDmw
         iZJUuweHVOTLfwWRi2MB7MQxSvftLCF8t50xo1r2zC8X4kPRcIBHEXIJurbtabLXqjpU
         fbdBwcVOutJ0gwA20OXbIhErWSN0p4uN5s4j1TFRkQejrRYdbE8ldb14hfJjrox5Phwq
         DoZQ==
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

As a good side-effect die() now prints the stacktrace with KERN_EMERG
aligned with other messages.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/hexagon/kernel/traps.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 69c623b14ddd..a8a3a210d781 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -79,7 +79,7 @@ static const char *ex_name(int ex)
 }
 
 static void do_show_stack(struct task_struct *task, unsigned long *fp,
-			  unsigned long ip)
+			  unsigned long ip, const char *loglvl)
 {
 	int kstack_depth_to_print = 24;
 	unsigned long offset, size;
@@ -93,9 +93,8 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	if (task == NULL)
 		task = current;
 
-	printk(KERN_INFO "CPU#%d, %s/%d, Call Trace:\n",
-	       raw_smp_processor_id(), task->comm,
-	       task_pid_nr(task));
+	printk("%sCPU#%d, %s/%d, Call Trace:\n", loglvl, raw_smp_processor_id(),
+		task->comm, task_pid_nr(task));
 
 	if (fp == NULL) {
 		if (task == current) {
@@ -108,7 +107,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	}
 
 	if ((((unsigned long) fp) & 0x3) || ((unsigned long) fp < 0x1000)) {
-		printk(KERN_INFO "-- Corrupt frame pointer %p\n", fp);
+		printk("%s-- Corrupt frame pointer %p\n", loglvl, fp);
 		return;
 	}
 
@@ -125,8 +124,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 
 		name = kallsyms_lookup(ip, &size, &offset, &modname, tmpstr);
 
-		printk(KERN_INFO "[%p] 0x%lx: %s + 0x%lx", fp, ip, name,
-			offset);
+		printk("%s[%p] 0x%lx: %s + 0x%lx", loglvl, fp, ip, name, offset);
 		if (((unsigned long) fp < low) || (high < (unsigned long) fp))
 			printk(KERN_CONT " (FP out of bounds!)");
 		if (modname)
@@ -136,8 +134,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 		newfp = (unsigned long *) *fp;
 
 		if (((unsigned long) newfp) & 0x3) {
-			printk(KERN_INFO "-- Corrupt frame pointer %p\n",
-				newfp);
+			printk("%s-- Corrupt frame pointer %p\n", loglvl, newfp);
 			break;
 		}
 
@@ -147,7 +144,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 						+ 8);
 
 			if (regs->syscall_nr != -1) {
-				printk(KERN_INFO "-- trap0 -- syscall_nr: %ld",
+				printk("%s-- trap0 -- syscall_nr: %ld", loglvl,
 					regs->syscall_nr);
 				printk(KERN_CONT "  psp: %lx  elr: %lx\n",
 					 pt_psp(regs), pt_elr(regs));
@@ -155,7 +152,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 			} else {
 				/* really want to see more ... */
 				kstack_depth_to_print += 6;
-				printk(KERN_INFO "-- %s (0x%lx)  badva: %lx\n",
+				printk("%s-- %s (0x%lx)  badva: %lx\n", loglvl,
 					ex_name(pt_cause(regs)), pt_cause(regs),
 					pt_badva(regs));
 			}
@@ -178,10 +175,16 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	}
 }
 
-void show_stack(struct task_struct *task, unsigned long *fp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *fp,
+		       const char *loglvl)
 {
 	/* Saved link reg is one word above FP */
-	do_show_stack(task, fp, 0);
+	do_show_stack(task, fp, 0, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *fp)
+{
+	show_stack_loglvl(task, fp, 0, KERN_INFO);
 }
 
 int die(const char *str, struct pt_regs *regs, long err)
@@ -207,7 +210,7 @@ int die(const char *str, struct pt_regs *regs, long err)
 
 	print_modules();
 	show_regs(regs);
-	do_show_stack(current, &regs->r30, pt_elr(regs));
+	do_show_stack(current, &regs->r30, pt_elr(regs), KERN_EMERG);
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-- 
2.25.1

