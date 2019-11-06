From: Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 6 Nov 2019 16:12:01 +0000
Message-ID: <de8a397d-8660-4ace-9626-127debcf43a7@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
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
	List-Owner; bh=3umfyvnnGpWUdKvZTOJrUwav+2FQBwECDiB7LJ58BsQ=; b=u2wtV53P2xPjvn
	LldKHUzBxD2ZTDXT/3NfjSeQCpjH43dZE7LIzXPItnl9zUAVEBJKPypqLKzMXPYUdq3LWbCIMarXF
	Sfz94nnkHl4/VKjce29+t/xP6OqIYJIcaEeHfXVYvLh0zU3OlHZ72/F8qGgKHxgPahfHazAqahMX/
	JCn4F0FrJFhT45VHohj9sGCtuGhMGlKw5mLgiLcfF51SsE9UTrgx/4NPxZD8DWiS8yM/7f+1MlWBo
	+UIf3V9GH3rpNCwy1lnvSu8BDMARstvAG6dlXQLlnMrj8HJvPGnHHHRPDfwsD6qlhovP0c323vUin
	PTn4WlFyvHupEB0kxZjQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6YKC1kJOcWpyD+8pjGdr6zJNIwDWfqyBu/N6KBSP97U=;
 b=MpZHturjPCBg33iU1ozhAjvA8LCtPPFI3DR58OYlFEaUZGZqfEzhUtttDDrlEOGegQ
 4vDex9qExlxkA9WH33d8HwoxTLWivc69W/6aer4DXfteqgbtXwv3cNxCcRds4ZAMweGX
 5ZXj+X+FYkL8t+hZqh4LwhZRZNRrqod+Up3sqXtFrQSRV7C3Y69W33Z8X4jj1Fl7gbuY
 R6u824u7CLy//WZ/duinZirY1ifbAiK575WJqRiWdVx2qkiQPu6t7SWS7JDhyX5hOHLe
 oe8RLdwEfd46kke7TKQhcEtTSIZl2oUQhbinVc7bj3yYIQzIfU4ltgAEvZlXwG6aLosM
 UhRA==
In-Reply-To: <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ralf Baechle <r>

On 11/6/19 8:35 AM, Petr Mladek wrote:
> On Wed 2019-11-06 03:04:51, Dmitry Safonov wrote:
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
> 
> Just to clarify. The problem in sysrq driver is a bit different.
> It modifies console_loglevel to show even less important message
> on the console.
> 
> IMHO, it should be solved by printing the header line with pr_error().
> It is not ideal. A cleaner solution might be to introduce another
> loglevel that will always get pushed to the console. But I am
> not sure if it is worth this single line.

I believe why it's not done - there is a comment in sysrq code that said
the userspace relies on the loglevel of sysrq messages (and may trigger
alerts from emerg/err log level):
  * Raise the apparent loglevel to maximum so that the sysrq header
  * is shown to provide the user with positive feedback.  We do not
  * simply emit this at KERN_EMERG as that would change message
  * routing in the consumers of /proc/kmsg.

But I don't mind any solution.

>>   Hung task warning before panic [2] - suggested by Tetsuo (but he
>>   probably didn't realise what it would involve).
>> o While doing (1), (2) the backtraces were adjusted to headers
>>   and other messages for each situation - so there won't be a situation
>>   when the backtrace is printed, but the headers are missing because
>>   they have lesser log level (or the reverse).
>> o As the result in (2) plays with console_loglevel for kdb are removed.
> 
>> The least important for upstream, but maybe still worth to note that
>> every company I've worked in so far had an off-list patch to print
>> backtrace with the needed log level (but only for the architecture they
>> cared about).
>> If you have other ideas how you will benefit from show_stack() with
>> a log level - please, reply to this cover letter.
> 
> I agree with all the other justification.
> 
> I would add. The backtrace is really useful for debugging. It should
> be possible to print it even in less critical situations.
> 
> I am afraid that many people use WARN() for this purpose. But WARN()
> is not always appropriate. WARN() misuse huts when panic_on_warn
> option is used.

Thanks, Petr.

-- 
          Dmitry
