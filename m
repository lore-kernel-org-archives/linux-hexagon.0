From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 11:51:50 +0900
Message-ID: <20191113025150.GA101113@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
 <20191112021747.GA68506@google.com>
 <25cb9647-007a-9c18-4784-49c0aef4f54b@arista.com>
 <20191112042546.GA119579@google.com>
 <d828cb62-aeea-4d67-33ba-b3a93ea10a3d@arista.com>
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
	List-Owner; bh=pDT5yRPn9SlnfHXXTiYssqGmvx2r398LWrYx2wizQQw=; b=HEhEqnl2VfQbAt
	2haM1qIp1I+4E32ysFfIAM5wh3p2uIBRfjLI8l1wBfHRYxaXQPFMc96cwPFvu7pXQQ4zbX0Z/LaZh
	6rjiRjlR7qLCZl+JLNFVVD1TWzBU2IGON9rjFdfdI71XG7bvzXjJEQzoNRrxm2y5dPhVWT7n4ReDs
	rPZdHsaxQECMxa4Y5fCzTR+7wg7aqA3KlQdhBaK6pYb7u0ZdcGnTFAbXzywfl4/sErYxlJapH9Kzl
	4nFSUB7icZ+FXlsSLaF7bLKWIXU0IMXUKOTWB/8YFrZYszmsbTvmrw2aVuF548dDrTQbn6pKR3hHH
	nZkh/faKE6p+hivKb+CQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mAEGoUcf015Kc1YtW4ruE+InFHxWlwYn7gbBVyirKYs=;
 b=XXCh/lzhc9PTzZMC0vGMEKaB6i1csVlUbqsH9rt47YYmIE3wdFLdN1RZ9XLo0Arau9
 DFSxYtIImotqP13tsBpRhqb8n2/Js3UmCNvM723O76JsU3YeDgNvB62RSmDR472f865P
 t1QAOVBhx+MjcLVo2R7QGZwppOQAhnDe5pnFM8bcC1mQYP4Xfr9JZq5mLce2CdFOCSHQ
 84njoBNSpMDUUGTsuJ77DSMbJh6PdBhKnrYmuC5XmJlJhZH9X7UWxpAWc2QurRhXPwj/
 RNRLsIyLkoYPXcQN5wrdc5lLemIanQ8txwfErNc3g/3wLnhyIhyW/Sj8BqL1ib+dXaLC
 deQg==
Content-Disposition: inline
In-Reply-To: <d828cb62-aeea-4d67-33ba-b3a93ea10a3d@arista.com>
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

On (19/11/13 02:41), Dmitry Safonov wrote:
[..]
> 
> I don't strongly disagree, but if you look at those results:
> git grep 'printk("%s.*", \(lvl\|level\)'
> 
> it seems to be used in quite a few places.

Yes, you are right, it is used in some places. That's why I said
that I'd prefer to keep that number low (minimize it). But it's
not 0 (that ship has sailed).

	-ss
