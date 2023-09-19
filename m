From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 16:17:04 +0200
Message-ID: <877comw8m7.ffs@tglx>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uxq6vVTPKCOYA8crcD8G/72wM9c4fvvXG6mEKyQRT0s=; b=mVcJKQNnfBFWx8
	0vf81fVcZpszdSuNAmXzItTTkWTOBZVmRJKnuMhwdEsbKEHrjzwADTzeWGHrB4PZiZ4d+dfZifdq9
	XwIb1iisuTUz8j7nd9SDUHSuICRxvmUthcyZZT/+gqG8EnkbEf9rH0kSyyx19NyWqm5V9zOCpSwrr
	ZcIbjXp29odANLA9mpmWdhbfpDxEl122Yj/z0Br5WycIi7C13O/swVRg8TimOlzpAOWOqWZ3kLWBJ
	9izPYsWem6LbGb1cSdlnGewK+bra+2Eg+yg0jBWHvAHu+/ZKlk7xeI6Yoh/FVXGFlBLdbzVuAULo5
	A5CyCitPP06UbTsjLPGg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695133024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzWx00LzOrWB97CWuV/YA9TmYjDj3ZDIMkfBUMc4vK4=;
	b=BOxMpPsViTe4eAtpu1ohDtFuIpN7IjvrZhvOBsd6347EBpK1i33XuSFab8AL0lweo+PFy8
	3iOGDMIC+Hvv+hkN5eCfmcGqjfheYxtMZOzKC2dGwAvwVE43AtzVXjipdaNuZPnRPbknwE
	NhtRbmiYrJlKh0tGITD5wAlrwn4Xa6bmHo3iBcler3nO26HcQQl1xzJ/mp0JZif/nQtWlF
	dBjwcMDZfWh/3oIWHNKiGV3t+tWujITFdQ7bz0UDDF95w9VGLx6XyR7FCO5Coye1/DEUi6
	rLum0uGnFlDWQ9t4rol0rAMiYlovZXwlD2eyyMvvFhw0zpX9gnqC1yMp/YlV2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695133024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzWx00LzOrWB97CWuV/YA9TmYjDj3ZDIMkfBUMc4vK4=;
	b=nRpx4S8fWZgScRYmAhyhfVuD4eX5xNxfXOTycjWAjLwMsE2Xlh4NbkKZ/6cMTKcYmUdKVK
	LXdA7Tw5o0myYtBA==
In-Reply-To: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
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
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Richard Henderson <richard.h>

On Tue, Sep 19 2023 at 15:48, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
>> > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>> > that people are still working on! Can we please not do this?
>> 
>> If you're working on one of them, then surely it's a simple matter of
>> working on adding CONFIG_PREEMPT support :-)
>
> As Geert poined out, I'm not seeing anything particular problematic with the
> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> something about organizing KConfig files.
>
> I find it a bit unfair that maintainers of architectures that have huge companies
> behind them use their manpower to urge less popular architectures for removal just
> because they don't have 150 people working on the port so they can keep up with
> design changes quickly.

I don't urge for removal. I just noticed that these four architectures
lack PREEMPT support. The only thing which is missing is the actual
preemption point in the return to kernel code path.

But otherwise it should just work, which I obviously can't confirm :)

Even without that preemption point it should build and boot. There might
be some minor latency issues when that preemption point is not there,
but adding it is not rocket science either. It's probably about 10 lines
of ASM code, if at all.

Though not adding that might cause a blocking issue for the rework of
the whole preemption logic in order to remove the sprinkled around
cond_resched() muck or force us to maintain some nasty workaround just
for the benefit of a few stranglers.

So I can make the same argument the other way around, that it's
unjustified that some architectures which are just supported for
nostalgia throw roadblocks into kernel developemnt.

If my ALPHA foo wouldn't be very close to zero, I'd write that ASM hack
myself, but that's going to cost more of my and your time than it's
worth the trouble,

Hmm. I could delegate that to Linus, he might still remember :)

Thanks,

        tglx
