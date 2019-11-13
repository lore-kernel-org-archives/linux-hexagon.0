From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 10:23:37 +0900
Message-ID: <20191113012337.GA70781@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com>
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
	List-Owner; bh=yOqDuqb+68NvBk8Q4OnzdNWpqSkOjQtT2EUbyWOAr7c=; b=D4OILMKTtCKD9M
	fQ8kfaI8o0zqZY8tWlsgTZ5lTn4wyYI8O5j54d6OdgvIj14nxVpmFH3GY9TIKlEbfob+3fUdO+M4U
	m+SvHG+Q57xV1hhBtgtGSYLzifi28Mi1+WHsgm0IOiMn9DMH511V+6IdbFMzOmA+nVPVcPz5hKmZQ
	VN7mH4hdPnULfVqgNhPsLXcdh8FKxqrfTXlbvzLgkZCcg0VQ9tGIRxO9PG+/DREEYfCQhaOPtqi50
	6ptF48bQG1tfmOcE/Vj1w+UAgQtQzOpvFkBEFRoVZS5VmCmL3DVMp6VpHdBaKb7SoxUD/94kVW8HM
	btf1uIpz2Ejy8+JWrKUg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1L7ASzKkM9H3jGXxNBrUB+7DORYDzuzDLILdAI3Iz7A=;
 b=hPWPZKlqyeQnXDnfKM+yto4tna7/NwAt3iB5d61vGkkJIZuUufxmpnoxkEgePVnej7
 L3hqEC23l+0zKgGK6W4wPhhfu5rKZowqxPh/46+GMjsQYom9+rxAtKscDZa4tq1EZ716
 v3E2zlUhIldCXA7DVyUqyyBaEbvglPUOrZExWlUjNqVUbKviWiZ0UqqlQQn5uS5GaAHc
 mq/bIirdXr39H9gdTuhjl1CNb4pz9u1NyVaytreQwY9zEl/crJdG04QmPFkkR8rnNcTE
 UvMTM+CfzewoFMwCfZcUTuuW9mgMTzeza8o6UpjTQJvYoUxBVhuX8rWLl3B8wj02ljU3
 maaw==
Content-Disposition: inline
In-Reply-To: <20191112101229.GA201294@google.com>
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
To: Petr Mladek <pmladek@suse.com>, Dmitry Safonov <dima@arista.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwys>

On (19/11/12 19:12), Sergey Senozhatsky wrote:
> On (19/11/12 09:35), Petr Mladek wrote:
> [..]
> > This is getting too complicated. It would introduce too many
> > hidden rules. While the explicitly passed loglevel parameter
> > is straightforward and clear.
>
> If loglevel is DEFAULT or NOTICE or INFO then we can overwrite it
> (either downgrade or upgrade). That's one rule, basically. Not too
> complicated, I guess.

Can be taken even a bit further than

	show_stack(NULL, NULL, LOGLEVEL_DEBUG);
or
	show_stack(NULL, NULL, LOGLEVEL_ERR);

For instance,

	spin_lock_irqsave(&rq->lock, flags);
	printk_emergency_enter(LOGLEVEL_SCHED);
		...
		show_stack(...);
		printk();
		printk();
		...
	spin_unlock_irqrestore(&rq->lock, flags);

or

	spin_lock_irqsave(&uart_port->lock, flags);
	printk_emergency_enter(LOGLEVEL_SCHED);
		...
		printk();
		printk();
		...

and so on.

	-ss
