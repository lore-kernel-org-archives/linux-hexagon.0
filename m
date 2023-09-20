From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: Arches that don't support PREEMPT
Date: Wed, 20 Sep 2023 15:38:33 +0100
Message-ID: <159b79fc-16d8-2d12-ed17-fb508879d791@cambridgegreys.com>
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
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rdN3ddq+RwnBD/OXMjMnMQsueNZZp52q1X1u3N45Ee0=; b=0BEA3AdoSZWvDp
	VJVBWbom0ncelL/rgkskDS2dD1SuelnS6P57u3bOEBbjTaOkM+skv8WsgArW9LsWYeZspggjYmHOC
	t3lHu0ozgLkBWaAP7af5n5yl6EXh29694dibIxZTw+A2dKD1J15sUyxDNZMM13eeq13WDJUCCmpWT
	amiPSQ0EMlGzi5IquZ6eyu9F4j7RLaq+UgDuOzKu2qJLAeBoIhDBq4Grm++BKWVKA7rydx0ICg7HH
	Bvw0lrjh89E2i90SawElds3WvO6Q5S8Gp99sIiK3E2z5dbdNTyRHMv8+xr/inUNZ7lGBuHbFMB7I4
	xfXncCFDQvu0g2nYq9UQ==;
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Zijlstra <peterz@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Richard Henderson <richard.henderson@li>



On 19/09/2023 15:16, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 03:48:09PM +0200, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
>>>> The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>>>> that people are still working on! Can we please not do this?
>>>
>>> If you're working on one of them, then surely it's a simple matter of
>>> working on adding CONFIG_PREEMPT support :-)
>>
>> As Geert poined out, I'm not seeing anything particular problematic with the
>> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
>> something about organizing KConfig files.
> 
> The plan in the parent thread is to remove PREEMPT_NONE and
> PREEMPT_VOLUNTARY and only keep PREEMPT_FULL.
> 
>> I find it a bit unfair that maintainers of architectures that have huge companies
>> behind them use their manpower to urge less popular architectures for removal just
>> because they don't have 150 people working on the port so they can keep up with
>> design changes quickly.
> 
> PREEMPT isn't something new. Also, I don't think the arch part for
> actually supporting it is particularly hard, mostly it is sticking the
> preempt_schedule_irq() call in return from interrupt code path.

That calls local_irq_enable() which does various signal related/irq pending work on UML. That in turn does no like being invoked again (as you may have already been invoked out of that) in the IRQ return path.

So it is likely to end up being slightly more difficult than that for UML - it will need to be wrapped so it can be invoked from the "host" side signal code as well as invoked with some additional checks to avoid making a hash out of the IRQ handling.

It may be necessary to modify some of the existing reentrancy prevention logic in the signal handlers as well and change it to make use of the preempt count instead of its own flags/counters.

> 
> If you convert the arch to generic-entry (a much larger undertaking)
> then you get this for free.
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
