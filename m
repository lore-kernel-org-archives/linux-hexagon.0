From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Tue, 12 Nov 2019 11:17:47 +0900
Message-ID: <20191112021747.GA68506@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Guc/SnXr9vvX4xEx1xDqKSHQIRS7eYk0OXesgRSAh30=; b=Rz08+sZlcbNKHt
	dZsHPdSSooLyOZwsVJwtXKnPQZw1aWpquiL73D6SugGO9DzSse9Z58squxtElMHQuTcbgGUZN9C1u
	QC2hrQ4am4iZNB5aDCMaFEhzyVzAltJ1ZpVvDryYFO9PwmGD+Z+VsfPcPcY4oKvpLXY3vrWRW3i2h
	Xhs56ej5jc6TiUAmsgvsoVpUq2WM+vBqfWZ4GnC5un18/dkTha0J0hilSOwer/JaIlgq3B1wNOh/j
	qTVtp8fq+zzTSUeSj4V7jMgcHPZH8QKsGXWTNvHnLEHDBJ/zmfRNfa+uBeOm6rXPwhLCasPX6uTMP
	7mtlL4nMP5e8KUHKFBzA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IS2Rt6ZY2kbQpUl893KQNxQCDA75x7+my/1Tf7NswKk=;
 b=Vjlm6KDBvoD6YwvO++lGZ6lHjSc6cCAm9fWSs4JjxabSDi/CqNgEayfiCYPC9t2GLz
 /Uty/IrZcv04aOS3qRrPGUG7rvgiF7YDnI2Kh9DQ5F3zuIcYwKRvol7P+LJHVR2Ntpue
 BmenkoLlXCW6FGqP0oYogfaCGkjco6cjgwMGb8PovVw8l1XJbVJPK3lxsi28NPqBWING
 uoTRw1Bt7GD9J0aMH2Xm/nWO4Q+ipdt8rIvGvN7pJpIBErQgGrRImSVcDd2J/2wookMd
 9Mf3+OZR0ijbdxrDUHHqzfcSZeytQjNDcnXBd9Ph8Qnd5c5vZ2BNhRMMpdwPBrRfh+x9
 Q4tA==
Content-Disposition: inline
In-Reply-To: <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Dmitry Safonov <dima@arista.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwyso>

On (19/11/11 19:47), Dmitry Safonov wrote:
[..]
> I don't see how bits on task_struct or in per-cpu are easier than
> supplying a log level parameter down the stack.
> How would it work if sysrq_handle_crash() called by key-press?
> How would that interact with deferred printing?
> How would it make visible prints from current context, but not from
> something that preempted it?

[..]

per-context log_level works pretty much the same way as per-message
log_level.

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
static DEFINE_PER_CPU(int, cpu_loglevels[4]); // @INITME.. LOGLEVEL_DEBUG + 1?

static int __printing_context(void)
{
	unsigned int preempt = preempt_count();

	if (!(preempt & (NMI_MASK | HARDIRQ_MASK | SOFITRQ_OFFSET)))
		return 0;
	if (preempt & SOFITRQ_OFFSET)
		return 1;
	if (preempt & HARDIRQ_MASK)
		return 2;
	return 3;
}

static int adj_context_loglevel(int level)
{
	int ctx = __printing_context();
	int cpu_level = this_cpu_read(cpu_loglevels[ctx]);

	// this one is important
	if (level == LOGLEVEL_SCHED)
		return level;
	// we are not in emergency context
	if (cpu_level == LOGLEVEL_DEBUG + 1)
		return level;
	// we better not override these
	if (LOGLEVEL_EMERG <= level && level <= LOGLEVEL_ERR)
		return level;
	return cpu_level;
}

void printk_emergency_enter(int log_level)
{
	int ctx;

	preempt_disable();
	ctx = __printing_context();
	this_cpu_write(cpu_loglevels[ctx], log_level);
}

void printk_emergency_exit(void)
{
	int ctx = __printing_context();

	this_cpu_write(cpu_loglevels[ctx], LOGLEVEL_DEBUG + 1);
	preempt_enable();
}

void vprintk_emit(...)
{
	level = adj_context_loglevel(level);
}
//
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
//
static void __show_stack(struct task_struct *task, unsigned long *sp)
{
	printk();
	...
	printk();
}

void show_stack(struct task_struct *task, unsigned long *sp, int log_level)
{
	printk_emergency_enter(log_level);
	__show_stack(task, sp);
	printk_emergency_exit();
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

show_stack() never schedules, disabling preemption around it should
not change anything. Should it be interrupted, we will handle it via
preempt count.

printk_emergency_enter(log_level) handles every printk() that
__show_stack() and friends do. Not worse than printk("%s Stack", lvl);
all over the place.

> What I'm going to do - is to fix all build and reported issues, I'll
> send v2 this week and feel free to NAK it, I will forget about those
> patches and won't be offended.

Lovely.
And - no, I'm not going to NAK platform specific changes. Just so you know.

*All* I'm talking about is an alternative, less "go and touch a ton of
platform code" approach. The argument "I patched so many files that I'm
not even going to discuss anything now" is not productive, to say the
least. Hope this clarifies.

	-ss
