From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Date: Wed, 16 Sep 2020 13:48:41 -0700
Message-ID: <20200916204841.GC29330@paulmck-ThinkPad-P72>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <20200916192352.GO5449@casper.infradead.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600289321;
        bh=QF1zQJP79WVPgC7BQeqDP3DZhHjaF5z1yd8g5M2I7fo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=akB9Q04wZh3xRPtHQo3QuvPylihDbICVfThimNTeh+6Dq0zpizzibT3VdQC852Awd
         fuMHbK20SAzoAhLwH6t+euR5PcSNWcJa0SR4ujAxGLaUq8AJQAgfX4YxZ7alYezUvX
         j37+068f8IMjVrTrNXFe4dEm94w3+K/HU0qZ4xJY=
Content-Disposition: inline
In-Reply-To: <20200916192352.GO5449@casper.infradead.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kerne>

On Wed, Sep 16, 2020 at 08:23:52PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 14, 2020 at 11:55:24PM +0200, Thomas Gleixner wrote:
> > But just look at any check which uses preemptible(), especially those
> > which check !preemptible():
> 
> hmm.
> 
> +++ b/include/linux/preempt.h
> @@ -180,7 +180,9 @@ do { \
>  
>  #define preempt_enable_no_resched() sched_preempt_enable_no_resched()
>  
> +#ifndef MODULE
>  #define preemptible()  (preempt_count() == 0 && !irqs_disabled())
> +#endif
>  
>  #ifdef CONFIG_PREEMPTION
>  #define preempt_enable() \
> 
> 
> $ git grep -w preemptible drivers
> (slightly trimmed by hand to remove, eg, comments)
> drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
> drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
> drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
> drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
> drivers/firmware/arm_sdei.c:    WARN_ON(preemptible());
> drivers/firmware/efi/efi-pstore.c:                            preemptible(), record->size, record->psi->buf);
> drivers/irqchip/irq-gic-v4.c:   WARN_ON(preemptible());
> drivers/irqchip/irq-gic-v4.c:   WARN_ON(preemptible());
> drivers/scsi/hisi_sas/hisi_sas_main.c:          if (!preemptible())
> drivers/xen/time.c:     BUG_ON(preemptible());
> 
> That only looks like two drivers that need more than WARNectomies.

I could easily imagine someone thinking that these did something in
CONFIG_PREEMPT_NONE=y kernels.  In fact, I could easily imagine myself
making that mistake.  :-/

> Although maybe rcu_read_load_sched_held() or rcu_read_lock_any_held()
> might get called from a module ...

But yes, from the rcutorture module for certain and also from any other
RCU-using module that includes the usual RCU debug checks.

							Thanx, Paul
