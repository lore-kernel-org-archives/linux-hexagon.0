From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [patch 00/13] preempt: Make preempt count
 unconditional
Date: Tue, 29 Sep 2020 11:00:03 +0200
Message-ID: <20200929090003.GG438822@phenom.ffwll.local>
References: <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAKMK7uGFyfhEyt=jmdk2jDO-hq0_Pf0ck+cKSELHjr2U3rPuYQ@mail.gmail.com>
 <20200916205840.GD29330@paulmck-ThinkPad-P72>
 <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
 <20200929081938.GC22035@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=l8n+Qtmools068Op1SBkscZ3rmiXf/OnO40zpDWJvQs=;
 b=HSfJ7A4FNQbt4jfghWagnZ0q3COkKg8qz4BPThTLTJ7eDRMt1DvHHeb7XKEZ522gOH
 eWGtprOnXgZp5uEMLqACAESKMKR8I99jBaCAbi8CJzl/OnYlzX1P6crhIyasKLf4c1bf
 2XybbZVEohhAC+dLedQmm8E/GOTp7GyR5iP8M=
Content-Disposition: inline
In-Reply-To: <20200929081938.GC22035@dhcp22.suse.cz>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@kernel.org>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Matt Turner <mattst88@gmail.com>, Valentin Schneider <valentin.s>

On Tue, Sep 29, 2020 at 10:19:38AM +0200, Michal Hocko wrote:
> On Wed 16-09-20 23:43:02, Daniel Vetter wrote:
> > I can
> > then figure out whether it's better to risk not spotting issues with
> > call_rcu vs slapping a memalloc_noio_save/restore around all these
> > critical section which force-degrades any allocation to GFP_ATOMIC at
> 
> did you mean memalloc_noreclaim_* here?

Yeah I picked the wrong one of that family of functions.

> > most, but has the risk that we run into code that assumes "GFP_KERNEL
> > never fails for small stuff" and has a decidedly less tested fallback
> > path than rcu code.
> 
> Even if the above then please note that memalloc_noreclaim_* or
> PF_MEMALLOC should be used with an extreme care. Essentially only for
> internal memory reclaimers. It grants access to _all_ the available
> memory so any abuse can be detrimental to the overall system operation.
> Allocation failure in this mode means that we are out of memory and any
> code relying on such an allocation has to carefuly consider failure.
> This is not a random allocation mode.

Agreed, that's why I don't like having these kind of automagic critical
sections. It's a bit a shotgun approach. Paul said that the code would
handle failures, but the problem is that it applies everywhere.

Anyway my understanding is that call_rcu will be reworked and gain a pile
of tricks so that these problems for the callchains leading to call_rcu
all disappear.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
