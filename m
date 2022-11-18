From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 8/8] sched, smp: Trace smp callback causing an IPI
Date: Fri, 18 Nov 2022 10:12:43 +0100
Message-ID: <Y3dMiyFn6TG1s5g3@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-7-vschneid@redhat.com>
 <Y3ZBUMteJysc1/lA@hirez.programming.kicks-ass.net>
 <xhsmhfsehy706.mognet@vschneid.remote.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rgz5xDeHk1lWbaMj4w1NCsYJ6NJRNYNVLYybOzL2u6Y=; b=YYs5l7+BC0Desj
	oWOXvbRyY6FZknxD32soGlU2WEhaM5NOCzHkk8kQzGevWbnmePJlItSGvXDWw0lWixoOhg+3oe0Nb
	+xSOFPhNnGcLEnqqLFBkVJkrhIw2NGEEoCfJ8Qt+pAtgqb433nImaFBOWW+nKDpaXtBAaTnrO3zTv
	6GJjKcLpwmG130hn9p6G8LJr3pAQevlL3hjDh1pQ3dg75VOE4fyuUbjOu76isgXZB2/iJ75q75R+U
	c1zE70n7Uya3IN+WkemT6fhTkc7wlOKAquqOf/i2bh8YuiKtCmgByls3BUNlMYZV+QxFBlyLT5e3u
	DLhI8r+IGwNovqSSnh8g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mwt73Igv1Cbi6CXwxAPKd0Pr+R9hvpBvRt03pYQ3bys=; b=ab3Y1GXh5hZN4kYCUal3zeuK3Q
	7SRG1cvzhO7eKodvFDYyuRae96G8g5PWd/XWhtSWcEI5MUsYEab5Ovzc8ze8gBOk9y9y/n4/VG6QA
	kxoDu7O/fG1a2giqiMnnG8GWp7V1BxUra+Jgp+oiupx2occO6L51vWUZQgeu4+7U3imdC7NUUUJ2N
	J5VaNoVksNMD06l+gxDbRhfwA3keSj0mXPL1+LX088MVxqFi6HWwWMGwF0jamw9uSp14pYO1PV0sb
	dSKJCydBYVIQlrwj2um9MWjTnI+ZTo1PEgHrvF9BZHJpiPATdBDwJ3bT9CqtMVsKHp/fep69BWHYQ
	1FAlMbCA==;
Content-Disposition: inline
In-Reply-To: <xhsmhfsehy706.mognet@vschneid.remote.csb>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mi>

On Thu, Nov 17, 2022 at 02:45:29PM +0000, Valentin Schneider wrote:

> > +	if (trace_ipi_send_cpumask_enabled()) {
> > +		call_single_data_t *csd;
> > +		smp_call_func_t func;
> > +
> > +		csd = container_of(node, call_single_data_t, node.llist);
> > +
> > +		func = sched_ttwu_pending;
> > +		if (CSD_TYPE(csd) != CSD_TYPE_TTWU)
> > +			func = csd->func;
> > +
> > +		if (raw_smp_call_single_queue(cpu, node))
> > +			trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);
> 
> So I went with the tracepoint being placed *before* the actual IPI gets
> sent to have a somewhat sane ordering between trace_ipi_send_cpumask() and
> e.g. trace_call_function_single_entry().
> 
> Packaging the call_single_queue logic makes the code less horrible, but it
> does mix up the event ordering...

Keeps em sharp ;-)

> > +		return;
> > +	}
> > +
> > +	raw_smp_call_single_queue(cpu, node);
> >  }
> >
> >  /*
> > @@ -983,10 +1017,13 @@ static void smp_call_function_many_cond(
> >                * number of CPUs might be zero due to concurrent changes to the
> >                * provided mask.
> >                */
> > -		if (nr_cpus == 1)
> > +		if (nr_cpus == 1) {
> > +			trace_ipi_send_cpumask(cpumask_of(last_cpu), _RET_IP_, func);
> >                       send_call_function_single_ipi(last_cpu);
> 
> This'll yield an IPI event even if no IPI is sent due to the idle task
> polling, no?

Oh, right..
