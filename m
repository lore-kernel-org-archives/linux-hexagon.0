From: Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 02:25:15 +0000
Message-ID: <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com> <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com> <20191113012337.GA70781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s7LdV2mBP8mQ+qmJC5A/i+JNhkQtNBEV/iqi697vVp8=; b=GfHYV0JITxz3pS
	4hFaPNzeG9gzI6QcuSHDCD4NlCWUgLN4mSmt8wYlVXmyNOptswPvt49NirMX7Wt6tHwq1jsda23XW
	ipiktwleYzw+2HH+RbIsH59vu9bWsj+T5q4Dc/K94IDYyAKMBhfNoWf1JqmPU6QFdUR4oSooem57Z
	r9+sSFR2lDeI0RjfKmTVtb1IlJ7pK7yHjF5Xly0Fo7asOZaN+nGlkhxs7evwogSg7Oa/pl9rFGh6f
	FeXlRE1YsNcU+CdG287EWHKKDrSP9faR5FV/pAIcz9PtGSAR6vw53rLxS2m4F9ysyf4ATfCvyyqLL
	zdahJyS+DiaNST8Eawog==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nujO1oAvQuda3HPNop9afPS+ilUfrJs0rYOKUqnCb18=;
 b=BPU+KO8V4PYZ+J0n2pqqh99W6ac4KcA7jk9+Zx5Bh9OaO6sBVt5ASZ3fj2xsr7WB7h
 SNaYNXc6sIWn6YEyADZbJe7z3JF26ysja52rZqHxSCop1eb2A4pFagSs05W3SzOME71F
 +e50abCI5ARQEy5f8R51YRtyP0PuwpGB72ACdE6tA0mEZfJovs8eMOHA1jiWlzka5K15
 JLUMn+pilZuA3qO/j2ZIJDHqtcvueUv2mdQwVvg7dKtohxfHj+VMahIPeM31ICvNc43E
 iqCMdi8V2KCrPhkZpw3wVaVj1lX/NA93rZJYM+rZ23pl0rachlvFFlb2IN6Z3ISJazGJ
 D/8A==
In-Reply-To: <20191113012337.GA70781@google.com>
Content-Language: en-US
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ralf Baechle <r>

On 11/13/19 1:23 AM, Sergey Senozhatsky wrote:
> On (19/11/12 19:12), Sergey Senozhatsky wrote:
>> On (19/11/12 09:35), Petr Mladek wrote:
>> [..]
>>> This is getting too complicated. It would introduce too many
>>> hidden rules. While the explicitly passed loglevel parameter
>>> is straightforward and clear.
>>
>> If loglevel is DEFAULT or NOTICE or INFO then we can overwrite it
>> (either downgrade or upgrade). That's one rule, basically. Not too
>> complicated, I guess.
> 
> Can be taken even a bit further than
> 
> 	show_stack(NULL, NULL, LOGLEVEL_DEBUG);
> or
> 	show_stack(NULL, NULL, LOGLEVEL_ERR);
> 
> For instance,
> 
> 	spin_lock_irqsave(&rq->lock, flags);
> 	printk_emergency_enter(LOGLEVEL_SCHED);
> 		...
> 		show_stack(...);
> 		printk();
> 		printk();
> 		...
> 	spin_unlock_irqrestore(&rq->lock, flags);
> 
> or
> 
> 	spin_lock_irqsave(&uart_port->lock, flags);
> 	printk_emergency_enter(LOGLEVEL_SCHED);
> 		...
> 		printk();
> 		printk();
> 		...

Yeah, that makes sense.

I believe it's up to you, Petr and Steven to decide what's better for
printk(). I mean, after all you care for all this code.

I guess I've pointed that in my point of view price for one-time testing
code is cheaper than adding a new printk feature to swap log levels on
the fly. But again, it's just how I see it - if we fix those printing
problems, than in half year we will forget they ever existed, but in
your proposal, there will still be some clever printk code.

On the other side, also worth to note that current patches set fix
problems for kdb (and for my hung task printing patch), but it's
incomplete for sysrq driver. I've gone through functions used by sysrq
driver and the same changes introducing log level parameter would be
needed for: sched_show_task(), debug_show_all_locks(), show_regs(),
show_state(), show_mem(). Some of them don't need any platform changes,
but at least show_regs() needs.
So, you also need to have that in mind making the decision.

Thanks,
          Dmitry
