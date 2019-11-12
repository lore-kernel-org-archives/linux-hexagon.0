From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Tue, 12 Nov 2019 13:44:47 +0900
Message-ID: <20191112044447.GA121272@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
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
	List-Owner; bh=MwYM8yXweak815m0udYipQygSmJVlBLZGBthFH46pMs=; b=UJHuNGfi1/+2Ko
	8tAPr1pzNnq6C5I3BP37ovOzHiNFMmEz2ZluZAey3qLWfecuZrmhUuLab60GjeUbHfXhy6IhyoB6A
	EWOaHDe+1ZKWSI10zsCXxvSuyuquhQOO04XCbj0Szv8W/NgY+BJd0bZzSwifxjcuc+MMHDc4QRW5I
	yb7YRV4tXLeFI1y4fq7ghb/7T7dv41XbFdS26dZhKFrg0QFrtMGst7I0DaCz0l0ZAycApCVWUxh+c
	92p/JbjuYwtkKm57Y7ZfhJYtey2TTJ+YI56Svb+TizdM2Dbe94zl4C5VJ22nKd+PlfCdFTlw/sKtn
	C+SEjTzcbaprFRSFrOeQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z6L3+hI6K7wkMCOOKfC6B5htW9e/NujoD4rmfI82OVU=;
 b=D8FdqJ91C9CViimFs5HkqTNzLfTnpza7YcDlJMaUW/GYDtbpWN+jf3gagVp5Pb54ut
 pJnpc/x6Rud5mFzPf0ZReA35hd11ljJ6cO/5F7Ue3e6hQ2TSEJ94YRDSGLm6NhnyCdqt
 CzzD2BCnxTXK5GtYHwa3Uusyd8eoRKj//LeZNogwczP3XkHhZ0DhI0uDpEhLu6Pcihhn
 H3BS+MU+Nl1Oowf4/jk8zWm4nc12KVZM+ffZ6sfZ7WtTjgYJy574lkrjNaKPgYx+dzhc
 p2jV1Cc9pO8ZsG8xspjchyhzIZQ4FAt5l5TNSRCxJncAjNaATr8g0kc1uRTSgUAVAp1B
 466Q==
Content-Disposition: inline
In-Reply-To: <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
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

On (19/11/11 10:12), Petr Mladek wrote:
[..]
> > I do recall that we talked about per-CPU printk state bit which would
> > start/end "just print it" section. We probably can extend it to "just
> > log_store" type of functionality. Doesn't look like a very bad idea.
> 
> The problem with per-CPU printk is that we would need to disable
> interrupts.

Or disable preemption and have loglevel per-CPU and per-context.
preempt_count can navigate us to the right context loglevel on
particular CPU. I'm talking here only about backtrace (error)
reporting contexts. Those can be atomic perfectly fine.

I posted a silly code snippet.

[..]
> But yes, this per-code-section loglevel is problematic. The feedback
> against the patchset shows that people want it also the other way.
> I mean to keep pr_debug() as pr_debug().

Hmm. Right.

> A solution might be to use the per-code-section loglevel only instead
> of some special loglevel.

So maybe we can "overwrite" only KERN_DEFAULT loglevels?
We certainly should not mess with SCHED or with anything in between
EMERG and ERR.

> The explicitly passed loglevel makes me feel more confident that
> all needed printk() calls were updated. But it might be a false
> feeling. I do not really have any strong preference.

I'm not like really objecting, just trying to explore some other
options.

	-ss
