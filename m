From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Fri, 15 Nov 2019 12:36:57 +0900
Message-ID: <20191115033657.GA407@tigerII.localdomain>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
 <20191112021747.GA68506@google.com>
 <20191113103922.3dc3e8e9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CkSq7JkRGG1n99HnZbTlsT+4cTsXzbrPMlJ3gy6M62U=; b=SDXvS81m7bUXiu
	AFEwVwEf2yIehneKwlbcov3jpPXC57MmERtTXQk3nL+64KWcpPjzJZFKL4/sbw4gsSoN4JYchC73z
	CQZ38GSZsYWe/zHznQTC+fWeqp6jFKvh/l8/VahRtY5lYb+JGlXx6uXU7g9U4+zqPKaTymcSfuroR
	LL+xigpbTJ8zScLptvnrTrqkH/zwgOWvBf4SgUmMI0TIm74iZMxSwpYS3++89NYsbkLReqGBfYBiy
	DRaaZVw7cQDJ/5sBgMlcuASk5xC5P1OXg7D961+7dyaU3eY3o6cIFT5/mzytK1/UGxYqnxXyGIEMm
	D2881qXLktt4lVorZJ1g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=R4XvROx888fXHPMG3Yq7w0aZuXsuTxn0lpM2IVqDtzs=;
 b=rosvxXmbxVwR1vACXmA9SkZCr7uwAAKB6UJ8GlY8l4n3tXBdK85d2C9bdYAAEJpyjW
 fFT+vr+mLl81JuDMdjUW+anF/Xfc5QEH7c2oMcSh2P3aCNGkUk5+dRVglouCIodq7WHR
 JntZpByfaG3f7z0ITWNWyjrHYUvHFedDz7NuSv9ofmpS9hbezDyvMp+CoX7pBe/a9BYH
 /5ccIl6Ob9b8/5VHy4+InTzOLbgcfU08QWMmpxugSNVufjRM7H87w0j0Xx9TVnx7E9kd
 kxH5U2h1R9bMcCLWkDU/RL/xXI7ZSl6Xqv3IfS/GbHtrXQnrqR+tQq1vNAk34F04bDED
 gXaQ==
Content-Disposition: inline
In-Reply-To: <20191113103922.3dc3e8e9@gandalf.local.home>
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On (19/11/13 10:39), Steven Rostedt wrote:
[..]
> > void show_stack(struct task_struct *task, unsigned long *sp, int log_level)
> > {
> > 	printk_emergency_enter(log_level);
> > 	__show_stack(task, sp);
> > 	printk_emergency_exit();
> > }
> > // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
> >
> > show_stack() never schedules, disabling preemption around it should
> > not change anything. Should it be interrupted, we will handle it via
> > preempt count.
>
> Please no! The whole point of the printk rewrite was to allow for
> printk to be preemptible and used in more contexts. The show_stack() can
> be all over the place and is not a fast function. Let's not disable
> preemption for it.

I never said that this code should be used all over the place. What
I did say several times was that this code is for quick debugging,
when one sits behind a slow serial console and wants to tweak loglevel
of all printk-s of a particular context/function only.

	-ss
