From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/13] preempt: Make preempt count
 unconditional
Date: Mon, 14 Sep 2020 13:59:15 -0700
Message-ID: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Qs78FMzlt+im4GrVUJu3esmNYK1MSMDWWoqgBiwThs=;
 b=ERO6mM2HDltE439vWz9d9wZL1Z1US74Rep2fFSqw78LuIb7lPia7EGvlr1OC0CVjXq
 SMHEUg44TyaQk6ZJLSPy2HsSiKOu/iozCQgjKu5X4wpxZiRqxlsnhy+mopIISbxgK1FP
 TMlpT1uLwxNI5kovsL0EwxutKi15MuXbWCbt0=
In-Reply-To: <20200914204209.256266093@linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx <intel-gfx@lists.freedesktop.org>, Matt Turner <mattst88@gmail.com>, Valentin Schneider <valen>

On Mon, Sep 14, 2020 at 1:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Recently merged code does:
>
>          gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;
>
> Looks obviously correct, except for the fact that preemptible() is
> unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
> that code use GFP_ATOMIC on such kernels.

I don't think this is a good reason to entirely get rid of the no-preempt thing.

The above is just garbage. It's bogus. You can't do it.

Blaming the no-preempt code for this bug is extremely unfair, imho.

And the no-preempt code does help make for much better code generation
for simple spinlocks.

Where is that horribly buggy recent code? It's not in that exact
format, certainly, since 'grep' doesn't find it.

             Linus
