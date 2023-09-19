From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 10:25:17 -0700
Message-ID: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695144335; x=1695749135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUjFUwCVE5/xUduoxjL7lC1W3crAzRPXEbwf2O/yhew=;
        b=IJQRWuVT4GWUyGUYFvpMnG+Mgr+MKOYHZcY4hDVFvtc1yPFOVK7pX08ApSParXpHLy
         8aV8hqWNV2c/NIpLAweOm2ZyCQXZOuCGna1apzIJXQA4U+rZD5Dq/LoO3iR6KzZwIiM0
         tn0UyfYpSj5rmmcwj2E2KD7BwbTlvdeeW89ow=
In-Reply-To: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipso>

On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> As Geert poined out, I'm not seeing anything particular problematic with the
> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> something about organizing KConfig files.

It can definitely be problematic.

Not the Kconfig file part, and not the preempt count part itself.

But the fact that it has never been used and tested means that there
might be tons of "this architecture code knows it's not preemptible,
because this architecture doesn't support preemption".

So you may have basic architecture code that simply doesn't have the
"preempt_disable()/enable()" pairs that it needs.

PeterZ mentioned the generic entry code, which does this for the entry
path. But it actually goes much deeper: just do a

    git grep preempt_disable arch/x86/kernel

and then do the same for some other architectures.

Looking at alpha, for example, there *are* hits for it, so at least
some of the code there clearly *tries* to do it. But does it cover all
the required parts? If it's never been tested, I'd be surprised if
it's all just ready to go.

I do think we'd need to basically continue to support ARCH_NO_PREEMPT
- and such architectures migth end up with the worst-cast latencies of
only scheduling at return to user space.

               Linus
