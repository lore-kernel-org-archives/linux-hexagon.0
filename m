From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCHv2 14/50] hexagon: Add show_stack_loglvl()
Date: Tue, 17 Mar 2020 10:34:22 -0500
Message-ID: <016201d5fc71$89c01ab0$9d405010$@codeaurora.org>
References: <20200316143916.195608-1-dima@arista.com> <20200316143916.195608-15-dima@arista.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584459270; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=n0DB5rQk3vxOGb0AlK5NXyNF/JWOE9+RENHn6S1ppc0=; b=EhY4+aY141B8bLwoqmfD0ynbVlp84w5Qnk7ZfJn30fWDjjz1rLTYsjYxSulm4KKxqtQk9Dyf
 4bCOo5hKM9aWq4eySoBwuB4VI2D/CV2aFu4SDJwU3icuyy/Hv4xyiZfjGvlyG3gaKx8lBZ41
 OD9HQ3ncxMuIPpU/Njt4iHkt96o=
In-Reply-To: <20200316143916.195608-15-dima@arista.com>
Content-Language: en-us
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Dmitry Safonov' <dima@arista.com>, linux-kernel@vger.kernel.org
Cc: 'Dmitry Safonov' <0x7f454c46@gmail.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Jiri Slaby' <jslaby@suse.com>, 'Petr Mladek' <pmladek@suse.com>, 'Sergey Senozhatsky' <sergey.senozhatsky@gmail.com>, 'Steven Rostedt' <rostedt@goodmis.org>, 'Tetsuo Handa' <penguin-kernel@I-love.SAKURA.ne.jp>, linux-hexagon@vger.kernel.org

Acked-by: Brian Cain <bcain@codeaurora.org>

> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-
> dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/hexagon/kernel/traps.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index 69c623b14ddd..a8a3a210d781 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -79,7 +79,7 @@ static const char *ex_name(int ex)  }
> 
>  static void do_show_stack(struct task_struct *task, unsigned long *fp,
> -			  unsigned long ip)
> +			  unsigned long ip, const char *loglvl)
>  {
>  	int kstack_depth_to_print = 24;
>  	unsigned long offset, size;
> @@ -93,9 +93,8 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  	if (task == NULL)
>  		task = current;
> 
> -	printk(KERN_INFO "CPU#%d, %s/%d, Call Trace:\n",
> -	       raw_smp_processor_id(), task->comm,
> -	       task_pid_nr(task));
> +	printk("%sCPU#%d, %s/%d, Call Trace:\n", loglvl,
> raw_smp_processor_id(),
> +		task->comm, task_pid_nr(task));
> 
>  	if (fp == NULL) {
>  		if (task == current) {
> @@ -108,7 +107,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  	}
> 
>  	if ((((unsigned long) fp) & 0x3) || ((unsigned long) fp < 0x1000)) {
> -		printk(KERN_INFO "-- Corrupt frame pointer %p\n", fp);
> +		printk("%s-- Corrupt frame pointer %p\n", loglvl, fp);
>  		return;
>  	}
> 
> @@ -125,8 +124,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
> 
>  		name = kallsyms_lookup(ip, &size, &offset, &modname,
> tmpstr);
> 
> -		printk(KERN_INFO "[%p] 0x%lx: %s + 0x%lx", fp, ip, name,
> -			offset);
> +		printk("%s[%p] 0x%lx: %s + 0x%lx", loglvl, fp, ip, name,
> offset);
>  		if (((unsigned long) fp < low) || (high < (unsigned long)
fp))
>  			printk(KERN_CONT " (FP out of bounds!)");
>  		if (modname)
> @@ -136,8 +134,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  		newfp = (unsigned long *) *fp;
> 
>  		if (((unsigned long) newfp) & 0x3) {
> -			printk(KERN_INFO "-- Corrupt frame pointer %p\n",
> -				newfp);
> +			printk("%s-- Corrupt frame pointer %p\n", loglvl,
> newfp);
>  			break;
>  		}
> 
> @@ -147,7 +144,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  						+ 8);
> 
>  			if (regs->syscall_nr != -1) {
> -				printk(KERN_INFO "-- trap0 -- syscall_nr:
> %ld",
> +				printk("%s-- trap0 -- syscall_nr: %ld",
loglvl,
>  					regs->syscall_nr);
>  				printk(KERN_CONT "  psp: %lx  elr: %lx\n",
>  					 pt_psp(regs), pt_elr(regs));
> @@ -155,7 +152,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  			} else {
>  				/* really want to see more ... */
>  				kstack_depth_to_print += 6;
> -				printk(KERN_INFO "-- %s (0x%lx)  badva:
> %lx\n",
> +				printk("%s-- %s (0x%lx)  badva: %lx\n",
loglvl,
>  					ex_name(pt_cause(regs)),
> pt_cause(regs),
>  					pt_badva(regs));
>  			}
> @@ -178,10 +175,16 @@ static void do_show_stack(struct task_struct
> *task, unsigned long *fp,
>  	}
>  }
> 
> -void show_stack(struct task_struct *task, unsigned long *fp)
> +void show_stack_loglvl(struct task_struct *task, unsigned long *fp,
> +		       const char *loglvl)
>  {
>  	/* Saved link reg is one word above FP */
> -	do_show_stack(task, fp, 0);
> +	do_show_stack(task, fp, 0, loglvl);
> +}
> +
> +void show_stack(struct task_struct *task, unsigned long *fp) {
> +	show_stack_loglvl(task, fp, 0, KERN_INFO);
>  }
> 
>  int die(const char *str, struct pt_regs *regs, long err) @@ -207,7 +210,7
> @@ int die(const char *str, struct pt_regs *regs, long err)
> 
>  	print_modules();
>  	show_regs(regs);
> -	do_show_stack(current, &regs->r30, pt_elr(regs));
> +	do_show_stack(current, &regs->r30, pt_elr(regs), KERN_EMERG);
> 
>  	bust_spinlocks(0);
>  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> --
> 2.25.1

