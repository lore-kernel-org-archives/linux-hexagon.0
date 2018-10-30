From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/7] smp: Don't yell about IRQs disabled in
 kgdb_roundup_cpus()
Date: Tue, 30 Oct 2018 09:25:25 +0100
Message-ID: <20181030082525.GA13436@hirez.programming.kicks-ass.net>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-7-dianders@chromium.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JrT+GY2FMwB2T1XAI7yMtLPtyidWS9RM37PHU0M8ADE=; b=hrjdgZYKhW66jsqwqYy7iBEqT
        aNllxbN4/e8ECyE0JYYVlRz4hYMQq+5XyXBhJug9T7NXVMGsZYNnB48zQ5AONXgGCCz5pSF7PKDGv
        pUVDc3Gfy6dNIDOhDp3hygtwI+6Ayy/kWZdsh+gXrZwiOSnojSmqIpKvUnWw65wIWG/RWwAdU+PXE
        ybavT2cUzBF09n3j7ot0t/xu+zRu2FHWKXET0xypzw3UeDhmVbOVREEUYAxmV9gYCr96vhkDYDukA
        /HU86umn8HQtqmSEHxnQN9yJjjim6IzloRma9Rh3rDily9mqzwc2/lKjda/4VtIWu1flnKNK/ibTj
    
Content-Disposition: inline
In-Reply-To: <20181029180707.207546-7-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, frederic@kernel.org, riel@surriel.com, linux-kernel@vger.kernel.org, luto@kernel.org, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 29, 2018 at 11:07:06AM -0700, Douglas Anderson wrote:
> In kgdb_roundup_cpus() we've got code that looks like:
>   local_irq_enable();
>   smp_call_function(kgdb_call_nmi_hook, NULL, 0);
>   local_irq_disable();

> Let's add kgdb to the list of reasons not to warn in
> smp_call_function_many().  That will allow us (in a future patch) to
> stop calling local_irq_enable() which will get rid of the original
> splat.
> 
> NOTE: with this change comes the obvious question: will we start
> deadlocking more often now when we drop into the debugger.  I can't
> say that for sure one way or the other, but the fact that we do the
> same logic for "oops_in_progress" makes me feel like it shouldn't
> happen too often.  Also note that the old logic of turning on
> interrupts temporarily wasn't exactly safe since (I presume) that
> could have violated spin_lock_irqsave() semantics and ended up with a
> deadlock of its own.

How is any of that not utterly and terminally broken?

> @@ -413,7 +414,8 @@ void smp_call_function_many(const struct cpumask *mask,
>  	 * can't happen.
>  	 */
>  	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
> -		     && !oops_in_progress && !early_boot_irqs_disabled);
> +		     && !oops_in_progress && !early_boot_irqs_disabled
> +		     && !in_dbg_master());
>  
>  	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
>  	cpu = cpumask_first_and(mask, cpu_online_mask);

Not a fan of this. There is a distinct difference between
oops_in_progress and dropping into kgdb in that you don't ever expect to
return/survive oopses, whereas we do expect to survive kgdb.

Also, how does kgdb work at all without actual NMIs ?

So no, NAK on this.
