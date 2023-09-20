From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Arches that don't support PREEMPT
Date: Wed, 20 Sep 2023 10:26:25 +0200
Message-ID: <87edituu6m.ffs@tglx>
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
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695198386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cz3ybOd/ypkcGDuMCJQdl0UFouGTxpARZATHk1efhH0=;
        b=EGx2EBigs6+KVxSISL/lO4SeWI2/p5U3N6zV5areodcDyVNQT2YbEaxonhjEzXP7/szlID
        TMqjKMwwRJVKmQfn51MUW9KIbWl9E19kzugQpYPh1RqXMdMqyHRHId8GsHbiYMY1gupCr9
        inWCgekLEVw9LLIxUEhX+SjOdAKmXLyfbATOE5SKrIhGQ6opMrTgQNDBWj6h+pupcy9mQY
        IAtJFpC+IZrsZhADhx21jPYjN4cUEmbdknYpq1yaFpD3q1JUKeyYvZEasHaRFyuKPfCocG
        sb/JjJcoHFqbdHPNLrqct85JyOKGX/90xcldUD95gAEiF72EcQ3euVx2thUmyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695198386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cz3ybOd/ypkcGDuMCJQdl0UFouGTxpARZATHk1efhH0=;
        b=Zhs312twDc9TbsbkF5GT2tuvKzW8ClBRyZtMimieaTdcJbOGBK7CVUU6mFwCowxAhHysBo
        5AdimDwJAjJms3Ag==
In-Reply-To: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead

On Tue, Sep 19 2023 at 10:25, Linus Torvalds wrote:
> PeterZ mentioned the generic entry code, which does this for the entry
> path. But it actually goes much deeper: just do a
>
>     git grep preempt_disable arch/x86/kernel
>
> and then do the same for some other architectures.
>
> Looking at alpha, for example, there *are* hits for it, so at least
> some of the code there clearly *tries* to do it. But does it cover all
> the required parts? If it's never been tested, I'd be surprised if
> it's all just ready to go.

Interestingly enough m68k has zero instances, but it supports PREEMPT on
the COLDFIRE subarchitecture...
