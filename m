From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 12/32] hexagon: copy_thread(): rename 'arg' argument to
 'kthread_arg'
Date: Mon, 16 Mar 2015 11:25:18 -0500
Message-ID: <20150316162518.GA15501@codeaurora.org>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
 <1426270496-26362-2-git-send-email-alexinbeijing@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426270496-26362-2-git-send-email-alexinbeijing@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Dowad <alexinbeijing@gmail.com>
Cc: linux-kernel@vger.kernel.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>

On Fri, Mar 13, 2015 at 08:14:35PM +0200, Alex Dowad wrote:
> The 'arg' argument to copy_thread() is only ever used when forking a new
> kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
> with do_fork() and other arch-specific implementations of copy_thread()).
> 
> Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
> ---
>  arch/hexagon/kernel/process.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
> index 0a0dd5c..6f27358 100644
> --- a/arch/hexagon/kernel/process.c
> +++ b/arch/hexagon/kernel/process.c
> @@ -71,7 +71,7 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
>   * Copy architecture-specific thread state
>   */
>  int copy_thread(unsigned long clone_flags, unsigned long usp,
> -		unsigned long arg, struct task_struct *p)
> +		unsigned long kthread_arg, struct task_struct *p)
>  {
>  	struct thread_info *ti = task_thread_info(p);
>  	struct hexagon_switch_stack *ss;
> @@ -94,10 +94,11 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  	ss->lr = (unsigned long)ret_from_fork;
>  	p->thread.switch_sp = ss;
>  	if (unlikely(p->flags & PF_KTHREAD)) {
> +		/* kernel thread */
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		/* r24 <- fn, r25 <- arg */
>  		ss->r24 = usp;
> -		ss->r25 = arg;
> +		ss->r25 = kthread_arg;
>  		pt_set_kmode(childregs);
>  		return 0;
>  	}
> -- 
> 2.0.0.GIT
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>



-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
