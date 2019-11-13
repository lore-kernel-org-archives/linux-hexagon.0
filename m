From: Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 16:40:57 +0000
Message-ID: <578d041a-3ce5-28bb-9fcc-cf90fe82b036@arista.com>
References: <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com> <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com> <20191113012337.GA70781@google.com>
 <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
 <20191113063334.GA147997@google.com>
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
	List-Owner; bh=7n6gmXMBXY4YuCEWdXZZLAhZnJhQ9DnDLrubJcdQ3DQ=; b=ToUn4uSlIHtsUK
	Z10LwB+iVF3H5DpXpmYj8rsN1+1PnOOHuFsJ23TmCJYzeKM5rIwVLVubxAdT6SLVj26AxFZCR8TtH
	INtkea1eR2V6Om15j7ozLu4603Ub+bzaB/RkYeNWIXkaO5DU9FP6DNLQ8Xdqq7SVJ4KxZkJsN7nj0
	vBLI9WAYCIWGz46jmsh4ENgAVQfB2U5H6fgRzIAwvi1kAcGepGWHsaUliZ0xv/Od7dogBylEz68fn
	vdXkwBW7+uxG63yVdHuAMn9hXWjMFMjhJh8taj3MjuEjjVcqUB6+RnxsZH2R6OSqWkyAuDDkyZpqD
	BwGRJibrSMmf1k9JDwcg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bpYMERXodNN3/IUKFqoV3bu09Kfnjp4MDDbBxGqTaak=;
 b=kRXw4AvoWBw7ukkZ2SwH4DcHmhkOyvtHzm9A9tembEe4SHnL/Wkxs4OG+Y78DFYLKj
 WUQkQ3xkRC7KpV6HsQsVQ8Y83U6DSV4bjqqA4yz8eiAzM5MouyPOfpTV04Q+Swaq6dzO
 iwJ3irSL+AWM6APV8kLc/aiqJnine4lrlZLBQET4Kth1bx1KYWl6QngPsxySaS0LA2u8
 4l3EYQWDxhDPyJMBUmdjQ4AlBq5rQRf2tmZq6s9bjkx4QpbhYyBqV94RH9xa8/CrCe8j
 rdAqy2276oEWDDekf+JPcbvdolRg+K/VuqSY8KHpC1K4x4t7plUDL/CedXLaIDpvWCOd
 tkDg==
In-Reply-To: <20191113063334.GA147997@google.com>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ralf Baechle <r>

Hi Sergey,

On 11/13/19 6:33 AM, Sergey Senozhatsky wrote:
[..]
> Well, here we go. There is a number of generally useful functions that
> print nice data and where people might want to have better loglevel control
> (for debugging purposes). show_stack() is just one of them. Patching all
> those functions, which you have mentioned above, is hardly a fun task to do.
> Hence the printk() per-CPU per-context loglevel proposition. The code there
> is not clever or complicated and is meant for debugging purposes only, but
> with just 3 lines of code one can do some stuff:
> 
> 	/* @BTW you can't do this with "%s" KERN_FOO ;P */
> +	printk_emergency_enter(LOGLEVEL_SCHED);
> +	debug_show_all_locks();
> +	printk_emergency_exit();

Not that I want to critic your proposal more, but just to clarify what
I've meant by "cleaver and complicated":

I don't think semantically there is any difference between:

printk_emergency_enter(LOGLEVEL_SCHED);
printk();
printk_emergency_exit();
vs
printk("%s ...", KERN_SHED, ...);

I was speaking about complexity not about usage, but about realization
inside printk_emergency_enter(): there will be some business logic that
will do "it's NMI? Use loglevel given. it's KERN_ALERT? Don't downgrade
the loglevel..." and other smart details those are really logic which
one have to think about and later maintain.

There will be also minor issues like people inserting print with one log
level and seeing it in dmesg with another, but I presume those
printk_enter() and printk_exit() will cover little amount of code
without much nesting [as long as it's not getting overused]. And also it
can be documented and people will learn about another feature of printk().

And this year I've seen the presentation "Why printk() is so
complicated?" and I presumed that the approach is to keep things as
simple as possible.

In conclusion:
I see that your proposal also solves the problem [except preemption and
some pr_debug() that shouldn't be printed]. And I think your approach is
better in the sense of short-term (we won't have any missed %s KERN_ in
linux-next), but in a long-term it adds some amount of business logic to
printk and another feature.

Just in case: again, I don't mind, it's up to you, maintainers of
printk. It's also not very fun for me to create those patches.
But they fix console_loglevel issues (I hope we could un-export it in
the end) and also I need it for my other patches those will produce
warnings with debug loglevel when configured through sysctl.

Thanks,
          Dmitry
