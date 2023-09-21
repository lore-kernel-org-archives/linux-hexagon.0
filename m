From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: Arches that don't support PREEMPT
Date: Thu, 21 Sep 2023 08:20:38 -0400
Message-ID: <020d4d23-ee7e-49aa-9ed5-1bde21fd0a5d@app.fastmail.com>
References: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <20230919141627.GB39281@noisy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w8C7MyMm+xKpSvSm5sa2BnCv6qE4utS/hepDKT8iw24=; b=ZmbSfpY1HfWjW2
	k4zzUL2yDEOxaBojfow30KsLPDceW5c0VxASfyP8nmw3255jrrAJKRWu+ffXH+YmtdkxEa3cH0yr5
	/O7stL5igZ3I1mvh2zd/ghSZLyvP4g5dqS81Y65cFrMPw/6UTDid/3lU2cXlZAMY+N9RFpuIFLywT
	Bs01tqGatYJb6vE9WFSSpoTOUptQ/GFASduxU0N3/ZEDTiO37l7MGY/p20/DszOcBZ/Rr58DJwq6e
	fPH7EVIBvYGchhLZuLOCfOI4Hg5EpDLYJObvcADRmCekjnyriKVm1mW3/NLpqSa8sbtV1PYoi8LKb
	7s9I2MsaNjQPwSxo8CRA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695298930; x=1695385330; bh=bI
	CU49f3R5e6tOFgPrJQcVi5tnUnFNXIHPGMh+L+TBg=; b=L6lYR2Tkg6YW09ZEP7
	OC3REXNbmFESOwzVxVw2xX2d4Mi1KLdjyBDeCIwOzEDPQelkPCFvhPiTDReuvjRa
	0K1hEEajfz0y5nKBcAX7j8/UhzL1ElgAUMXKoBLoTo1KDUxLJWpLAygQ2ew2IDsj
	yEf5ZXz91216EYizxRSDX6hehjnrwtBmiUcDsF3KmYhM2APrLSnFrmpF/TEJpq25
	j3Ps22K2WbFlR6SjGyseavSRtb9b6d8mN8o6jtErbySiShiA4GoNRtuQAnjzlHCi
	xMcSOr8TwAzbkGJWZcVMfLHINdShZIY7AaXYAdPb5nJpyTv+4zntqwaEt9FTkovz
	J26g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695298930; x=1695385330; bh=bICU49f3R5e6t
	OFgPrJQcVi5tnUnFNXIHPGMh+L+TBg=; b=RVjMo7y3by+104e0tpt3AaC3rxAB/
	BkN16pzGhr3PFOnA7+MzV5/LwVyFOToOKDEebEeB37my8a5dUM8dxWXyv71kgWpH
	g8G4rKJYqZNrQuEP2VH5DcjJbhzkWhqCuLtvX7/i62XytcJ1QDvDI8XBMSTLJEBD
	Zjs7BSkgAJHit6Pq6JzybieBHCckG9lZuYEPH8f3T/JN9tCgDrFEQ79omye4NBL6
	1NxzbRH7G4K6UmvQHcjFoxIuEmJjkWSv3iVjrtsoa8UKTZw061MvDMOgFXUhnn/r
	xH28CZr8YCId7DqtXVl4D3XfokExmYeY/SIZShdXISc78kCqeNrRTcl8g==
In-Reply-To: <20230919141627.GB39281@noisy.programming.kicks-ass.net>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com, Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Juergen Gross <jgross@suse.com>, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux

On Tue, Sep 19, 2023, at 10:16, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 03:48:09PM +0200, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
>> > > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>> > > that people are still working on! Can we please not do this?
>> > 
>> > If you're working on one of them, then surely it's a simple matter of
>> > working on adding CONFIG_PREEMPT support :-)
>> 
>> As Geert poined out, I'm not seeing anything particular problematic with the
>> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
>> something about organizing KConfig files.
>
> The plan in the parent thread is to remove PREEMPT_NONE and
> PREEMPT_VOLUNTARY and only keep PREEMPT_FULL.
...
>
> PREEMPT isn't something new. Also, I don't think the arch part for
> actually supporting it is particularly hard, mostly it is sticking the
> preempt_schedule_irq() call in return from interrupt code path.
>
> If you convert the arch to generic-entry (a much larger undertaking)
> then you get this for free.

I checked the default configurations for both in-kernel targets and
general-purpose distros and was surprised to learn that very few
actually turn on full preemption by default:

- All distros I looked at (rhel, debian, opensuse) use PREEMPT_VOLUNTARY
  by default, though they usually also set PREEMPT_DYNAMIC to let users
  override it at boot time.

- The majority (220) of all defconfig files in the kernel don't select
  any preemption options, and just get PREEMPT_NONE automatically.
  This includes the generic configs for armv7, s390 and mips.
  
- A small number (24) set PREEMPT_VOLUNTARY, but this notably
  includes x86 and ppc64. x86 is the only one of those that sets
  PREEMPT_DYNAMIC

- CONFIG_PREEMPT=y (full preemption) is used on 89 defconfigs,
  including arm64 and a lot of the older arm32, arc and
  mips platforms.

If we want to have a chance of removing both PREEMPT_NONE and
PREEMPT_VOLUNTARY, I think we should start with changing the
defaults first, so defconfigs that don't specify anything else
get PREEMPT=y, and distros that use PREEMPT_VOLUNTARY use it
use it in the absence of a command line argument. If that
doesn't cause too many regressions, the next step might be
to hide the choice under CONFIG_EXPERT until all m68k and
alpha no longer require PREEMPT_NONE.

     Arnd
