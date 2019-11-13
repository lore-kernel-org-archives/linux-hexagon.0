From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 10:39:22 -0500
Message-ID: <20191113103922.3dc3e8e9@gandalf.local.home>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
 <20191112021747.GA68506@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4/E3QUkaaBFtZy3XCjm3qptg0xc3Cwr0Ymgbwk8U5b0=; b=dKoUiuq6zWm/HF
	u6M8ocld4EwS4Xm6XBfwH50wiehWuUNQFobZr+51eLCumjTfuLbHZ09ww6Vt6LgfSmX/NKqEIoH3o
	4WzPyBwDkceL/6V8YVFBqWS90AiQEfbT9Uo5ptP0BQo3/kLF5vUEueiDEZ6t/Q0/ww90Rd0xB2jQn
	cuWtSg2fF65ayYlQv+LVb4qV+WGYtykGlXJ5lHNGbcWNYLNPJsHjW4l1C2S1dsMQTte5zmpE7N81B
	0+EaFv3cfP57tTNae5j2kQeHKezDVd3M05Xi4d8aIS0MtQz3psK2p8ImYBPdi9yiHWvwXo9S0VvJb
	8jqHzkpb3LQcSKq/wxKw==;
In-Reply-To: <20191112021747.GA68506@google.com>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kerne

On Tue, 12 Nov 2019 11:17:47 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> void show_stack(struct task_struct *task, unsigned long *sp, int log_level)
> {
> 	printk_emergency_enter(log_level);
> 	__show_stack(task, sp);
> 	printk_emergency_exit();
> }
> // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
> 
> show_stack() never schedules, disabling preemption around it should
> not change anything. Should it be interrupted, we will handle it via
> preempt count.

Please no! The whole point of the printk rewrite was to allow for
printk to be preemptible and used in more contexts. The show_stack() can
be all over the place and is not a fast function. Let's not disable
preemption for it.

-- Steve
