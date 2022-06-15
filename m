From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 16/36] rcu: Fix rcu_idle_exit()
Date: Tue, 14 Jun 2022 17:44:12 -0700
Message-ID: <20220615004412.GA5766@paulmck-ThinkPad-P17-Gen-1>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.935970247@infradead.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655253852;
        bh=rcjBHcwDa3Vvz9ae34yYid9fcwgrK1WVNSLCfZ/KP5E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fdhcRapfOZeMu89rXN1F9+PFgQBw1jq2TFCvdWilZKBPl7d60xoaf+Z1BoVI71oyo
         RqJwT7IyOmWKrdq1gGthk/wr5qRLVQoB8lFuH3bhpG8v28ehqFht7ixYYEHPsMm9AB
         B8Nl92yiOr67Th9tcRyEPi0fRLrSpOhoRzoC/T6UuHa5X12CLk5h++1bfLpyoCHqB+
         fvK77b4d+EdbOzzr1aIJ1u6gTHC44L8QS8SaSAp9SKbflwgVl3VgsZCvB9XatY8lhL
         9YwdPZU6iL7l0pnNRdqWmeOhCsfxrQ+i6D2NKXEGZhl5QpSSUjx5BoIk0tcHaLBiwv
         bedv5BuhTNO6Q==
Content-Disposition: inline
In-Reply-To: <20220608144516.935970247@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

On Wed, Jun 08, 2022 at 04:27:39PM +0200, Peter Zijlstra wrote:
> Current rcu_idle_exit() is terminally broken because it uses
> local_irq_{save,restore}(), which are traced which uses RCU.
> 
> However, now that all the callers are sure to have IRQs disabled, we
> can remove these calls.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

We have some fun conflicts between this series and Frederic's context-tracking
series.  But it looks like these can be resolved by:

1.	A patch on top of Frederic's series that provides the old rcu_*()
	names for the functions now prefixed with ct_*() such as
	ct_idle_exit().

2.	Another patch on top of Frederic's series that takes the
	changes remaining from this patch, shown below.  Frederic's
	series uses raw_local_irq_save() and raw_local_irq_restore(),
	which can then be removed.

Or is there a better way to do this?

							Thanx, Paul

------------------------------------------------------------------------

commit f64cee8c159e9863a74594efe3d33fb513a6a7b5
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Jun 14 17:24:43 2022 -0700

    context_tracking: Interrupts always disabled for ct_idle_exit()
    
    Now that the idle-loop cleanups have ensured that rcu_idle_exit() is
    always invoked with interrupts disabled, remove the interrupt disabling
    in favor of a debug check.
    
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Cc: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 1da44803fd319..99310cf5b0254 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -332,11 +332,8 @@ EXPORT_SYMBOL_GPL(ct_idle_enter);
  */
 void noinstr ct_idle_exit(void)
 {
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
-	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
 
