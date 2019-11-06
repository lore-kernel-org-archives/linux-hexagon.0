From: Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 6 Nov 2019 16:27:33 +0000
Message-ID: <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iPCCugWfxxCbBgX4qpIVRQwjYe5fP2yTnirMLShmNuI=; b=BxOuSGSbbUM972
	Xd+c3/US9kRVCuJpkffeBZxi/382T/LHUzNGMKoAhbJ3UCSsTjtF7aXwIRw55PcY6yOmkRj1tL0KL
	CpCmTaLS/YwkyYuGulVRyTt10s3DHvYzVI/Ze6CI2uvBYeC5QBpvyn0doomPZ+CI8nspIU/x2+6ME
	UVf7JC1X7qYIFFuEo/z9WEgmCxpgR8s+bjdwtHc2NOrbbj35h2krj7qgh4XtraMK1c8DsYhSHhUef
	suFYLiYbph88AqnCurOXKS+N1MR7yQnElwu/FlkZR63bq3La/YJEK9wu9txhMFXdMw0bReiDrykum
	OpVuLdws+l4bnNTd7Pog==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ILRv70ifsS4R/1VQKE/+LZSUA7puynZg3ILLVfy9hZk=;
 b=CdDAyQ43Jv36qsn9EkuUTZw8nt/+mOBKFoXfvdiENDFswTz54lmUElxhgNjniKxvLI
 izkIqTz62/+BsaxfKUgZ8S2RMG637jnDm+u0E1aGEUIzsEbWwsDV18EKNobslN2UlmYW
 WhC8g2REeIsonwoMKiOWl5u0CwVw1KGMvWwvlr5qjl4PZWOYWYsDg5p9F3UN6uGx7U/X
 y0XyKjPvcy9QpHnBDaHHpgbyRB/umgRbu9qBjoNr1nlR2d6FHD+lGiNEfvnrob7yl41T
 Rb+d5GPnNkrUNEfbqJzu6sSRExc4iKzcT+7U+xgq+doooMPjYjmc+eE6U7r6YPGlvf7O
 nVDg==
In-Reply-To: <20191106092039.GT4131@hirez.programming.kicks-ass.net>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ralf Baechle <r>

Hi Peter,

On 11/6/19 9:20 AM, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 03:04:51AM +0000, Dmitry Safonov wrote:
>> Add log level argument to show_stack().
>> Done in three stages:
>> 1. Introducing show_stack_loglvl() for every architecture
>> 2. Migrating old users with an explicit log level
>> 3. Renaming show_stack_loglvl() into show_stack()
>>
>> Justification:
>> o It's a design mistake to move a business-logic decision
>>   into platform realization detail.
>> o I have currently two patches sets that would benefit from this work:
>>   Removing console_loglevel jumps in sysrq driver [1]
>>   Hung task warning before panic [2] - suggested by Tetsuo (but he
>>   probably didn't realise what it would involve).
>> o While doing (1), (2) the backtraces were adjusted to headers
>>   and other messages for each situation - so there won't be a situation
>>   when the backtrace is printed, but the headers are missing because
>>   they have lesser log level (or the reverse).
>> o As the result in (2) plays with console_loglevel for kdb are removed.
> 
> I really don't understand that word salad. Why are you doing this?
> 

Sorry, I should have tried to describe better.

I'm trying to remove external users of console_loglevel by following
reasons:
- changing console_loglevel on SMP means that unwanted messages from
other CPUs will appear (that have lower log level)
- on UMP unwanted messages may appear if the code is preempted while it
hasn't set the console_loglevel back to old
- rising console_loglevel to print wanted message(s) may not work at all
if printk() has being delayed and the console_loglevel is already set
back to old value

Sysrq driver changes console_loglevel because it needs to print message
with a specific log level (the code said userspace relies on this).
Kdb changes console_loglevel to print backtrace as the log level depends
on architecture realisation.

I also have patches in wip those needs to print backtrace with specific
loglevel (higher when it's critical, lower when it's notice and
shouldn't go to serial console).

Besides on local tests I see hits those have headers (messages like
"Backtrace: ") without an actual backtrace and the reverse - a backtrace
without a reason for it. It's quite annoying and worth addressing by
syncing headers log levels to backtraces.

Thanks,
          Dmitry
