From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 11/17] hexagon: switch to copy_thread_tls()
Date: Tue, 23 Jun 2020 11:11:37 -0500
Message-ID: <14e701d64978$f9a2af60$ece80e20$@codeaurora.org>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com> <20200622234326.906346-12-christian.brauner@ubuntu.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592928732; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=tpu3koTLioptT4rbuRuixAw5FvFwl/Ar2ZGPQtaJuds=; b=kgyHKYH+dbE973OMmJOgxjlEYM46qO8kiD+2UznxXkvdjFYV32X+6NkvL96ktlltwhx8a/tm
 pnFSVUByeSzRjDxabF1SaNGXQP/bJnW38nHwRElx1JsDG2K4RUxrbTlK2sN/a3B5ycoQQz9K
 Z9kmeR+QRn9MWqiEy31eTu4bgD4=
In-Reply-To: <20200622234326.906346-12-christian.brauner@ubuntu.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Christian Brauner' <christian.brauner@ubuntu.com>, linux-kernel@vger.kernel.org
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, linux-hexagon@vger.kernel.org

...
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  arch/hexagon/Kconfig          | 1 +
>  arch/hexagon/kernel/process.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig index
> 667cfc511cf9..19bc2f2ee331 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -31,6 +31,7 @@ config HEXAGON
>  	select GENERIC_CLOCKEVENTS_BROADCAST
>  	select MODULES_USE_ELF_RELA
>  	select GENERIC_CPU_DEVICES
> +	select HAVE_COPY_THREAD_TLS
>  	help
>  	  Qualcomm Hexagon is a processor architecture designed for high
>  	  performance and low power across a wide variety of applications.
> diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
> index ac07f5f4b76b..d756f9556dd7 100644
> --- a/arch/hexagon/kernel/process.c
> +++ b/arch/hexagon/kernel/process.c
> @@ -50,8 +50,8 @@ void arch_cpu_idle(void)
>  /*
>   * Copy architecture-specific thread state
>   */
> -int copy_thread(unsigned long clone_flags, unsigned long usp,
> -		unsigned long arg, struct task_struct *p)
> +int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> +		    unsigned long arg, struct task_struct *p, unsigned long
tls)
>  {
>  	struct thread_info *ti = task_thread_info(p);
>  	struct hexagon_switch_stack *ss;
> @@ -100,7 +100,7 @@ int copy_thread(unsigned long clone_flags, unsigned
> long usp,
>  	 * ugp is used to provide TLS support.
>  	 */
>  	if (clone_flags & CLONE_SETTLS)
> -		childregs->ugp = childregs->r04;
> +		childregs->ugp = tls;
> 
>  	/*
>  	 * Parent sees new pid -- not necessary, not even possible at
> --
> 2.27.0

Acked-by: Brian Cain <bcain@codeaurora.org>


