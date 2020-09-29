From: Michal Hocko <mhocko@suse.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Date: Tue, 29 Sep 2020 10:19:38 +0200
Message-ID: <20200929081938.GC22035@dhcp22.suse.cz>
References: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAKMK7uGFyfhEyt=jmdk2jDO-hq0_Pf0ck+cKSELHjr2U3rPuYQ@mail.gmail.com>
 <20200916205840.GD29330@paulmck-ThinkPad-P72>
 <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601367582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFyfyEQCS1dcCR4BhfL+zwiQ3CuzyAy4x23tr+VkzjE=;
        b=SSpMjosSL8o4OPVa55QL9wIlM8PHwJpdBy+0T8Zs2+GxBxG6YA9l00PJ9Y66qcHmMfGLv9
        u+g+tcEvJ7RxAvAP57LRStfEelxtPsdHOGOgFzbQCNh9qQZDiKdnSarvXzcr1YnPqWmMjI
        wdLRjalKNBbwgyGfH1Q3bT+vgMo4axA=
Content-Disposition: inline
In-Reply-To: <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>

On Wed 16-09-20 23:43:02, Daniel Vetter wrote:
> I can
> then figure out whether it's better to risk not spotting issues with
> call_rcu vs slapping a memalloc_noio_save/restore around all these
> critical section which force-degrades any allocation to GFP_ATOMIC at

did you mean memalloc_noreclaim_* here?

> most, but has the risk that we run into code that assumes "GFP_KERNEL
> never fails for small stuff" and has a decidedly less tested fallback
> path than rcu code.

Even if the above then please note that memalloc_noreclaim_* or
PF_MEMALLOC should be used with an extreme care. Essentially only for
internal memory reclaimers. It grants access to _all_ the available
memory so any abuse can be detrimental to the overall system operation.
Allocation failure in this mode means that we are out of memory and any
code relying on such an allocation has to carefuly consider failure.
This is not a random allocation mode.

-- 
Michal Hocko
SUSE Labs
