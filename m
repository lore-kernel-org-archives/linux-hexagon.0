From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Mon, 11 Nov 2019 10:23:36 +0900
Message-ID: <20191111012336.GA85185@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
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
	List-Owner; bh=hmYrW5OjmRN5Y824/LFVSu2PnCR8WKNzmX2Y6CH67ns=; b=lP7XGiJbYsegLc
	ygrMqHQVuw1mmBezeMNxdlhehztc3NkwhlRXYEwZ0XnAE7BD2k+UbjpVut92ddk5OM6stmvsNH2a8
	8aD4OJ7KcHvPnOGsoUP+KoJ24jm9fZu83DByXHhKrOLE3Cq1Pzelua/ZiBC5BQdjdtrIVu/30H611
	EzPBHVb/PMrBlT3tObG+KG5vj1t9K0Tx42awV9r3yQ3k+68wK5XFfgFeMPRv4Q8/5e0jdyTPNh+eS
	f3hWEfyd9xC2BRSxb60qqZcEDtW07BaZ5Mw0vKMxnbAnwSkNBFd7ltotjABg55dp2Idnr/BklflkB
	EkDGe4iqFhJaW1yXbgfg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=meRRGW7ni43do21CnMh1ypMYB7GRo8yRghEKxpnOMtM=;
 b=PEUFO8IEu1osGIrKprDzvbxlNRJeZ7+VQZKgcPA4VWwOYdra1vch/X2sOCSKa29N9n
 VdblGN+C6xXZa66p438tGiFX2wH1ZMvXaLBCYR4jMYFYKpHWbu3dvuf4i51nfGHovAdM
 kJ21eWqlCVZNsUh7vR0KmZmoQmTZB1DoPsxQK2h0K8DrMvb84HP3pZHYPYw+F3AAOb8s
 2PUdw4923VWsoF2jPoVNv2KKLc7p6DTbwWWIyb/CwJRvDtzNsBcrU623traZ5+UDPhd8
 dvUZh/U5lV6A1081bATRr1q945s51Yb6awkYmElXIQG0WkPEPjbs1iqGD3WlzUt7rcka
 L5/w==
Content-Disposition: inline
In-Reply-To: <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.or>

On (19/11/08 14:04), Petr Mladek wrote:
[..]
> I agree that it is complicated to pass the loglevel as
> a parameter. It would be better define the default
> log level for a given code section. It might be stored
> in task_struct for the normal context and in per-CPU
> variables for interrupt contexts.

I do recall that we talked about per-CPU printk state bit which would
start/end "just print it" section. We probably can extend it to "just
log_store" type of functionality. Doesn't look like a very bad idea.
"This task/context is in trouble, whatever it printk()-s is important".

Per-console loglevel also might help sometimes. Slower consoles would
->write() only critical messages, faster consoles everything.

Passing log_level as part of message payload, which printk machinery
magically hides is not entirely exciting. What we have in the code
now - printk("%s blah\n", lvl) - is not what we see in the logs.
Because the leading '%s' becomes special. And printk()/sprintf()
documentation should reflect that: '%s' prints a string, but sometimes
it doesn't.

	-ss
