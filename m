From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 3/8] sched, smp: Trace IPIs sent via
 send_call_function_single_ipi()
Date: Sat, 7 Jan 2023 12:04:47 +0100
Message-ID: <Y7lRz7oCaAmAhoqS@gmail.com>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-4-vschneid@redhat.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jV2yBF+mbkDE0BvyOwe05ARE6EO7XhtOfB/KJLMsfFA=;
        b=BzPTx+ODS2RwGu5d9Av3CGI6XJ0NbmKP1pStUzg0M0m6+VF6wu2vf0tqTwK0k6q0qV
         Fbx7Y4Wluy9p+k8PZjL3FOoLufHJHxtq2K/BaarEwd/dPtd/DgO4uDiDqLUXCcfzSy4g
         Wd0wz4xfpZYGbxR/O6enZWRjIhs25ZrrKgwvTGouDcupcbkSfLeRveiApotbcr4XMgph
         w/4+08uhP/RwKAozhcyw6lYPvScMk8zL6fmWwbkyxQOkT9WdSUz8lze9ta3Mlh7zLg9k
         cM2v76pe7iQT/2ZR+EkGweLVXlhhfTIoWJwjo2u32vXfi3qjeDrWte72tROnSs3wxhtS
         1Wwg==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Content-Disposition: inline
In-Reply-To: <20221202155817.2102944-4-vschneid@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Dani


* Valentin Schneider <vschneid@redhat.com> wrote:

> send_call_function_single_ipi() is the thing that sends IPIs at the bottom
> of smp_call_function*() via either generic_exec_single() or
> smp_call_function_many_cond(). Give it an IPI-related tracepoint.
> 
> Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
> which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Patch series logistics:

 - No objections from the scheduler side, this feature looks pretty useful.

 - Certain patches are incomplete, others are noted as being merged 
   separately, so I presume you'll send an updated/completed series 
   eventually?

 - We can merge this via the scheduler tree I suspect, as most callbacks 
   affected relate to tip:sched/core and tmp:smp/core - but if you have 
   some other preferred tree that's fine too.

Thanks,

	Ingo
