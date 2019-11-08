From: Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Fri, 8 Nov 2019 16:28:30 +0000
Message-ID: <CAGrbwDRgX1BZoFrVYSXhAeeUKHrB=q3w8jXFPOuRvO7HV4Ciqw@mail.gmail.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
 <20191106203440.GH3079@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Oi0URCVlCW/xv6mf3y82Ao9G3AOxjSzoaGA9O2Wao8=; b=GOo2zr59AZ6Tob
	ByEndOWOFE/L4Xu4NBHrHlE0ElV+1Izi43qDMD4WWRT9xhf2hNFSGWwPma1BZa77QWi8p1EbMryWF
	kyq4PNHL+kVrHMhGpy4nkWKlgB5cOtZXVqVcEW7YVXd06pndH8yZx7qzqrzs5RS+Qf1AWkf9PhNyQ
	Z3DMMuOIDEF8mX25Vo8Inkb6cucZplq64JQ3J/NYAqmVufIAmD1Y/oCwmC7a9nDS3VMR2mBNcl4Nj
	dqWloNynH9PLRjzvhukwV06wu+0YFHnr1dTFSBh4d+1wEupoJwZWE0I0hRxyKXd3f3es7Lm2u0Cm3
	YI/Qk3d14560/WxfCyCg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g8y3Kv95ejyL7msYqyPIoRMuCM9aKky/CsOCvaHvzKM=;
 b=OFQ83MN4Hmk627ztvJPIKihtIRsS8ZJ3GNTmqGPL14tUmqtruv4K7nmTrdqjRLFkAn
 v66F5LmIzidO2RY0wAc8faHozHlKmYZjXqnWdur1cdgyOYMMPWxMT2qM/13lV7Gll4Nc
 lRCKNQhkBNihdDdl1Z0mCUKrkPWWlSTJj8W9XuLLYhohd1gFs4UlSNvhCs93ZGZd3jBA
 FVTjYbasessxSjfBcyeOLdW+Y8Bd7gD+BB7UCWg2KPTCWA+UwS7+l7bzP+7BahjCAYhI
 nOv6jmxm+6mZbCk5AkWY13lz+e0hU9EGlWVlrK7ojQr4zo4A/XJr3HfWznngkwdMz6Mb
 pEiA==
In-Reply-To: <20191106203440.GH3079@worktop.programming.kicks-ass.net>
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
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Ralf

On 11/6/19 8:34 PM, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 04:27:33PM +0000, Dmitry Safonov wrote:
[..]
>> Sorry, I should have tried to describe better.
>>
>> I'm trying to remove external users of console_loglevel by following
>> reasons:
>
> I suppose since all my machines have 'debug ignore_loglevel
> earlyprintk=serial,ttyS0,115200 console=ttyS0,115200' I don't have this
> experience.

Yeah, I remember you avoid all those functionalities of printk(), fair
enough. On the other side, regular users and I'm betting most of
the non-tuned distributions use /proc/sys/kernel/printk by default.
(Checking on my Arch & Fedora - loglevel 4 from the box)

>> - changing console_loglevel on SMP means that unwanted messages from
>> other CPUs will appear (that have lower log level)
>> - on UMP unwanted messages may appear if the code is preempted while it
>> hasn't set the console_loglevel back to old
>> - rising console_loglevel to print wanted message(s) may not work at all
>> if printk() has being delayed and the console_loglevel is already set
>> back to old value
>
> Sure, frobbing the global console_loglevel is bad.
>
>> I also have patches in wip those needs to print backtrace with specific
>> loglevel (higher when it's critical, lower when it's notice and
>> shouldn't go to serial console).
>
> (everything always should go to serial, serial is awesome :-)

Personally I agree. Unfortunately, here @Arista there are switches (I'm
speaking about the order of thousands at least) those have baud-rate 9600.
It's a bit expensive being elaborate with such setup.

>> Besides on local tests I see hits those have headers (messages like
>> "Backtrace: ") without an actual backtrace and the reverse - a backtrace
>> without a reason for it. It's quite annoying and worth addressing by
>> syncing headers log levels to backtraces.
>
> I suppose I'm surprised there are backtraces that are not important.
> Either badness happened and it needs printing, or the user asked for it
> and it needs printing.
>
> Perhaps we should be removing backtraces if they're not important
> instead of allowing to print them as lower loglevels?

Well, the use-case for lower log-level is that everything goes into logs
(/var/log/dmesg or /var/log/messages whatever rsyslog has settting).

That has it's value:
- after a failure (i.e. panic) messages, those were only signs that
something goes wrong can be seen in logs which can give ideas what has
happened.
- before the failure, those messages go to telemetry and can be
auto-magically processed remotely to take a decision (e.g. balance the
traffic away).

I wish all the information could be gathered in the userspace, but many
existing kernel/driver messages are valuable. A more detailed example is
hung task detector: we want to have the backtrace for a task that is
in uninterruptible state too long, but only in logs as printing on
serial console may lead to holding console lock and watchdog.
Besides customer notifications and investigations, I see the value of such
"bottleneck" warnings during long-running integration tests.

Thanks,
          Dmitry
