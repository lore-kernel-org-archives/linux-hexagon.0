From: Matthew Wilcox <willy@infradead.org>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 15:32:05 +0100
Message-ID: <ZQmw5dUzcFOWjHdB@casper.infradead.org>
References: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <20230919141627.GB39281@noisy.programming.kicks-ass.net>
 <a428516ebeae71e33635edc83052c972ce40c85d.camel@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3qzZ5QqVlcO5mNfNGbmbRviUaDRQSDEdLZbqk184E1A=; b=xtUPR8v2fWZ9UX
	Kue1AZKdRwpF5gg5JzHwbpVtgIfYqTxVCb084Ot5Wwa2rt866WRxePy22TMT2e54+WwUo0mOjXXaB
	mI0gUaDCUQ7+sf3uBmBkenWsii91P02CHL6sjW2jl/GdpX5nFIzKyUK8W30NkNM/If8qAGfw0s7/u
	8KLmARxbBI1hS4GMweJGoCG8OmZntIeJqUW7WupW7y0uvItJcY/aUWcld84PrMnTwsZWEQGkRHdeh
	TH5Iwijt7zxgwUn0PKmaXppcHLhswkdZ9CThVYyMOKd1NELSrJVrBvS0qDv+OY/wX61sgb2YbOTvu
	AukqgfSWqceOwjiUSccg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SidCZEV6eW0lcJ6NuB/uLvR734BxaKgfVBoDR9i1ilY=; b=wU6JouyF8Bxm56RpaenERGdpUO
	uCvAVUpRAqLEsiOGlctL7ZupHDmJIFbEljv7BpsiWCt0P+Eu8m9up5lt1qMWnxNwnJbtaVWvn2FQO
	4pKdpCBLaE5AaX6Gst2Xuv0aasi95ZnKa4+CkMPcsqW3PJEhR/eMlp/4usTSnSmznL5I2UfrU1dem
	V9TSusY7h9TQCeE1ORzWfmKqeJBq5CEAIc84YqLmNerMa9UNwMBCfOxHRGWc+rMCfeIV01jDcHqaB
	/apAzpnS4eTJSYIuKueYpJsctmmF6g8UbjSkd+Xp1I9U0O/06u6cqRSZD5goB0T09jgJOfd51cvIn
	2UW3Y5Cw==;
Content-Disposition: inline
In-Reply-To: <a428516ebeae71e33635edc83052c972ce40c85d.camel@physik.fu-berlin.de>
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
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vge

On Tue, Sep 19, 2023 at 04:24:48PM +0200, John Paul Adrian Glaubitz wrote:
> If the conversion isn't hard, why is the first reflex the urge to remove an architecture
> instead of offering advise how to get the conversion done?

Because PREEMPT has been around since before 2005 (cc19ca86a023 created
Kconfig.preempt and I don't need to go back further than that to make my
point), and you haven't done the work yet.  Clearly it takes the threat
of removal to get some kind of motion.
