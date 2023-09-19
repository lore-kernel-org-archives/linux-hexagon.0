From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 07:50:36 -0700
Message-ID: <7EB81196-3A32-4638-A076-0C0CFF722996@zytor.com>
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com> <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com> <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx> <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com> <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org> <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de> <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de> <877comw8m7.ffs@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=faUiEGRpypN0eR3wuQp71okWlg+ed77cY2poRYumr5c=; b=HnPx4nnJfTlfdy
	dr4ccZUxH2e+UyxWjbp1nmnf0bl3bbB6FP2UKLICJTxUAmgCrA2oDxjeTIlXCYcemsjNldZZu8M2c
	QJLHzPzbEXQZOZMPtQYdn+HYipVpl9UVsePjAu6tXZhuMi6Q4EmX1/3i4uBiMgOwYKee96hb27IUM
	zra2vvguU45vMvmOXCHDQ5NVMqSvqxtxVhSIq59qXLaEaA0eovrhDJfoTkHnRdUAPtJwonKZQTX2U
	9Ot4lnl5ZQRnZYrxoR6Y+d0p40qLS/JCrzqEX0wZIjC8oQcpmszQSHVkBdQzSXneaL+9zZGYEcOvr
	zskmwkYcrI6H2fea8Sjg==;
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38JEoefQ2134063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023091101; t=1695135044;
	bh=tUr/tHfO1etLyJ5iEsuuEqfdyv68/fcilJS639sYECk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rKxd+En5VITJVOEGiLmUKlIHqjSXGvGPVilskDP5cDHYQFDKWK93NnuXqpVPm85sg
	 IQ8mukavFvwyuQ2+LZQx/SFeLAJwt3NRGCnufaQHbyTI8yWPctJU8mvsKC8ydIURew
	 TWPjynPQFVYSogaCk173v4hcW64i46jcQU9Kvle5dlPXtXvcQsapqcrc0+JX4lPkGr
	 sf4WDdKOaq1+eQt1DQ0rhsH9vVqYCi8L00mlI3ZyOafcEgEQnuvBKUCD1TlG5Gwolf
	 v/ICNSdydZcPDXpEjwZCuJJ1aG9hOBj/BpI/RLMLoqn1ibICPlO3SW2Zd9eA3bsF4x
	 ffTTSTGuqyWmA==
In-Reply-To: <877comw8m7.ffs@tglx>
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
To: Thomas Gleixner <tglx@linutronix.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain <bcain@qui>

On September 19, 2023 7:17:04 AM PDT, Thomas Gleixner <tglx@linutronix.de> wrote:
>On Tue, Sep 19 2023 at 15:48, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
>>> > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>>> > that people are still working on! Can we please not do this?
>>> 
>>> If you're working on one of them, then surely it's a simple matter of
>>> working on adding CONFIG_PREEMPT support :-)
>>
>> As Geert poined out, I'm not seeing anything particular problematic with the
>> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
>> something about organizing KConfig files.
>>
>> I find it a bit unfair that maintainers of architectures that have huge companies
>> behind them use their manpower to urge less popular architectures for removal just
>> because they don't have 150 people working on the port so they can keep up with
>> design changes quickly.
>
>I don't urge for removal. I just noticed that these four architectures
>lack PREEMPT support. The only thing which is missing is the actual
>preemption point in the return to kernel code path.
>
>But otherwise it should just work, which I obviously can't confirm :)
>
>Even without that preemption point it should build and boot. There might
>be some minor latency issues when that preemption point is not there,
>but adding it is not rocket science either. It's probably about 10 lines
>of ASM code, if at all.
>
>Though not adding that might cause a blocking issue for the rework of
>the whole preemption logic in order to remove the sprinkled around
>cond_resched() muck or force us to maintain some nasty workaround just
>for the benefit of a few stranglers.
>
>So I can make the same argument the other way around, that it's
>unjustified that some architectures which are just supported for
>nostalgia throw roadblocks into kernel developemnt.
>
>If my ALPHA foo wouldn't be very close to zero, I'd write that ASM hack
>myself, but that's going to cost more of my and your time than it's
>worth the trouble,
>
>Hmm. I could delegate that to Linus, he might still remember :)
>
>Thanks,
>
>        tglx

Does *anyone* actually run Alpha at this point?
