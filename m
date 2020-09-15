From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Date: Tue, 15 Sep 2020 10:25:50 -0700
Message-ID: <20200915172550.GO29330@paulmck-ThinkPad-P72>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LKcafvSv2n9EdndQuEetR8RCdy3Zau7w2Zs9fNEhPGI=; b=FX0YDIhacxg6tyHvggZFuAZZcm
	NAZbEg4WMmirJTj4HuzX+aDnTcv/ugYKWVVh+p4J8f8gmlHEe8PRfLOc1eTPmzrqUik9FqNm0LuNf
	26SCGxzElOc5suSFG1jZtxvJMXo1eo7+DJjC9rkticjcB7kUHVBXuOFtoTUVUw+sjCHMRrK7oByn7
	jVazVTLT5crThE81iR7Nye3Xym9a7S1odcAwdn1tMRteO07pq5lkOqZQAobdMTkSe+fvL3PcUbSSb
	DRLncMgmviLQYzhhHxnym72yDB06aK5b2se+Ovkr7pJ7vR90Uhn3ctnCYWgVLVr52iRHIeBJobnrd
	G9QCZP+w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600190751;
 bh=zAnK9MdJHBLYi0RM5uCLYkcfWnZYrpv2oBo/jSvr9uY=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=Ykvmjz+uTRDK4muYb7ZaU4DA//3YkvSNNe72xuNxHLx5WYlF6vS8rMYi7/p95sA0e
 ZPdUkNpigzrHNbl4M/6ZTzpu5fGsQWXGQS5l9WSBuK+ES7WGVLX9Rtn/w5xojTk3HA
 SqvN6NXO/B4lR6nWQIM4LgYias8O7Oiya2Sq1o2E=
Content-Disposition: inline
In-Reply-To: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-

On Mon, Sep 14, 2020 at 01:59:15PM -0700, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 1:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Recently merged code does:
> >
> >          gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;
> >
> > Looks obviously correct, except for the fact that preemptible() is
> > unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
> > that code use GFP_ATOMIC on such kernels.
> 
> I don't think this is a good reason to entirely get rid of the no-preempt thing.
> 
> The above is just garbage. It's bogus. You can't do it.
> 
> Blaming the no-preempt code for this bug is extremely unfair, imho.
> 
> And the no-preempt code does help make for much better code generation
> for simple spinlocks.
> 
> Where is that horribly buggy recent code? It's not in that exact
> format, certainly, since 'grep' doesn't find it.

It would be convenient for that "gfp =" code to work, as this would
allow better cache locality while invoking RCU callbacks, and would
further provide better robustness to callback floods.  The full story
is quite long, but here are alternatives have not yet been proven to be
abject failures:

1.	Use workqueues to do the allocations in a clean context.
	While waiting for the allocations, the callbacks are queued
	in the old cache-busting manner.  This functions correctly,
	but in the meantime (which on busy systems can be some time)
	the cache locality and robustness are lost.

2.	Provide the ability to allocate memory in raw atomic context.
	This is extremely effective, especially when used in combination
	with #1 above, but as you might suspect, the MM guys don't like
	it much.

In contrast, with Thomas's patch series, call_rcu() and kvfree_rcu()
could just look at preemptible() to see whether or not it was safe to
allocate memory, even in !PREEMPT kernels -- and in the common case,
it almost always would be safe.  It is quite possible that this approach
would work in isolation, or failing that, that adding #1 above would do
the trick.

I understand that this is all very hand-wavy, and I do apologize for that.
If you really want the full sad story with performance numbers and the
works, let me know!

							Thanx, Paul
