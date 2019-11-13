From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 10:32:14 -0500
Message-ID: <20191113103214.1585923c@gandalf.local.home>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
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
	List-Owner; bh=la1fcWRqkrLphM1uzmzI9A+GcfFlZDG8o9aFNCyzSoM=; b=W7FII/ZKZ/5flE
	P6jqcSglsiersJ+A3xvMgm4jIS2THCJp1f870aYm5kno9c9mq7BHKKq4JStXD9uVPiiBo+lz95yML
	A0Jj2j6YPG1wIKtqI2iewPhpuTTv78lm0Gnxh+hQzOXYh4VmF9yJIRV02xZQRQhnixPgvU/ngvc4P
	8P5zPg2RbgY0cwqkX859tv9VO3vznID+crIqMx7E5OSPxRVUwi7f+zF5aUW2d64Ah4y3CfEeC9HAy
	s6iFj0qtOQfUDRJohM5PGybn1rMq9Y3gT2xm5qTnWd5NCNzlLh4mE2CyRs1dCcxHAZ5KI2byGRv5c
	IO49MLZN0ybNnYWJ6V2w==;
In-Reply-To: <20191112044447.GA121272@google.com>
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

On Tue, 12 Nov 2019 13:44:47 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > > I do recall that we talked about per-CPU printk state bit which would
> > > start/end "just print it" section. We probably can extend it to "just
> > > log_store" type of functionality. Doesn't look like a very bad idea.  
> > 
> > The problem with per-CPU printk is that we would need to disable
> > interrupts.  
> 
> Or disable preemption and have loglevel per-CPU and per-context.
> preempt_count can navigate us to the right context loglevel on
> particular CPU. I'm talking here only about backtrace (error)
> reporting contexts. Those can be atomic perfectly fine.

With my real-time hat on, I'm totally against disabling of preemption
for this purpose.

-- Steve
