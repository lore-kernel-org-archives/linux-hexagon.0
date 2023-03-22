From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
Date: Thu, 23 Mar 2023 00:14:28 +0100
Message-ID: <20230322231428.GV2017917@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
 <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
 <xhsmhmt45c703.mognet@vschneid.remote.csb>
 <20230322140434.GC2357380@hirez.programming.kicks-ass.net>
 <xhsmhjzz8d8km.mognet@vschneid.remote.csb>
 <20230322172242.GH2357380@hirez.programming.kicks-ass.net>
 <xhsmhh6ucd4t7.mognet@vschneid.remote.csb>
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
	List-Owner; bh=3WjCfikvCNC3vNzLssWs7dDZv8RgDoNiwg1eSzZQdws=; b=L26xBmYK7eSH9s
	9mZJ+cBIfQo15eqFzKy36lLQTF6W6eaO9jBiF5SMgtRaruGruSdnAHcHLJN9VvaJIfZ0aF4yXOCT0
	aVhMZxcjErIIw4L9FpsgSTsUJqlmhAsbyVmvKY2beAgmr04sNXnADcCqKF0kModJXSVcYMVkdvv2r
	dSgJrmttRJGsT2RlnqObATJOEwemnLA/1eyxFNt/S9c0pHiWLtl3STHUw9elHkkbM9a9XuNAncRCJ
	BENI56XGZOy+T5RTXHBYaU7hYVE6jmmbY4wAphnTYrYjzNrqMf6aaQvaKXsf3U8t9Msmprwbcx3Bu
	Sn0eYUxsBVJx1iLShkkw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hKMA4pE4ZC1WEjwlMS0oahB5WbuLzi761bi+OVXv/X8=; b=k4/hIANBdxC2Z8c++HmkBPk16F
	hq1n4vi1aFY7d/izKMGpm0/zkTd++0c77IZs+Q5bV257Gjkiy34yMSDd8L7TKq46+CV0zDSHb27H+
	4KSIRSylcgYZ2OMei78Bb1gC7STjWled8MJkcwhhG29tpOAa6HtPIFWPyA9seeGrRiJr3vWUYPsTp
	3Vu3FPyPpiLcCMVxhaxuIGSboSf1mmZy7nxDek09nDmg/P6bBJA5M4EMw//9ErW/pvBC1TxeGCDAY
	4DGmD2DpR96GbtKoxaTV3TYyxFMIuFbNKoIU/LaGvb2xuytoT+Rk3V4s2DX53haN44indyDWk1fXo
	N1G/mBcw==;
Content-Disposition: inline
In-Reply-To: <xhsmhh6ucd4t7.mognet@vschneid.remote.csb>
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

On Wed, Mar 22, 2023 at 06:22:28PM +0000, Valentin Schneider wrote:
> On 22/03/23 18:22, Peter Zijlstra wrote:

> >>        hackbench-157   [001]    10.894320: ipi_send_cpu:         cpu=3 callsite=check_preempt_curr+0x37 callback=0x0
> >
> > Arguably we should be setting callback to scheduler_ipi(), except
> > ofcourse, that's not an actual function...
> >
> > Maybe we can do "extern inline" for the actual users and provide a dummy
> > function for the symbol when tracing.
> >
> 
> Huh, I wasn't aware that was an option, I'll look into that. I did scribble
> down a comment next to smp_send_reschedule(), but having a decodable
> function name would be better!

So clang-15 builds the below (and generates the expected code), but
gcc-12 vomits nonsense about a non-static inline calling a static inline
or somesuch bollocks :-/

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1991,7 +1991,7 @@ extern char *__get_task_comm(char *to, s
 })
 
 #ifdef CONFIG_SMP
-static __always_inline void scheduler_ipi(void)
+extern __always_inline void scheduler_ipi(void)
 {
 	/*
 	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -130,9 +130,9 @@ extern void arch_smp_send_reschedule(int
  * scheduler_ipi() is inline so can't be passed as callback reason, but the
  * callsite IP should be sufficient for root-causing IPIs sent from here.
  */
-#define smp_send_reschedule(cpu) ({		  \
-	trace_ipi_send_cpu(cpu, _RET_IP_, NULL);  \
-	arch_smp_send_reschedule(cpu);		  \
+#define smp_send_reschedule(cpu) ({				\
+	trace_ipi_send_cpu(cpu, _RET_IP_, &scheduler_ipi);	\
+	arch_smp_send_reschedule(cpu);				\
 })
 
 /*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3790,6 +3790,15 @@ static int ttwu_runnable(struct task_str
 }
 
 #ifdef CONFIG_SMP
+void scheduler_ipi(void)
+{
+	/*
+	 * Actual users should end up using the extern inline, this is only
+	 * here for the symbol.
+	 */
+	BUG();
+}
+
 void sched_ttwu_pending(void *arg)
 {
 	struct llist_node *llist = arg;
