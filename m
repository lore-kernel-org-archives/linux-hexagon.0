From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 21:53:07 +0200
Message-ID: <87jzsmueho.ffs@tglx>
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
 <87pm2eui95.ffs@tglx> <20230919143816.1741760a@gandalf.local.home>
 <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695153187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6MR2qg7K68Ikjp5YKoXbgk+KfdFV5OyH5X+XZI8Hys=;
        b=mOb/eNZUdC0Wj3l6CxvHBXP8mwAJuYFnOVgDDGyXCVGfE9qGC/lTBJMdjrY5OSdh22ztlP
        0pmpPVdeREqTDHGNAEeNvS1DieP+VUS9naCyvjQLxXHFNIP7ZMrmMpAb/G7OBUsq8HkoXh
        Cf2s4EE0LCAMh9WCn8yLJcvMdWe4fgVs+RUHjyvJHQe1wc5lXIfPpDuHsf3M3vaqIXgsMB
        c1zOM7RIRJi9+pTWs8ld1rHuTaEkuhd5s6SL99eLVBOi2BmjT9kDN+s+XFm70ynEg0DH68
        vw1rGuAKizG2OM9QTS2IvcNs1PTtQ9WH7K2vOYlgdiHCWVPYnna48qBKdgNrMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695153187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6MR2qg7K68Ikjp5YKoXbgk+KfdFV5OyH5X+XZI8Hys=;
        b=L3qg/U5CuhkLaMEQDfDZJ0Bp292wap1ObMBS0Fd+vVbQEdDuD8p1gEYpDfgtKABKvVsKv+
        70jMfd8FpBl2jmDQ==
In-Reply-To: <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsol>

On Tue, Sep 19 2023 at 11:52, Linus Torvalds wrote:
> On Tue, 19 Sept 2023 at 11:37, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> We could simply leave the cond_resched() around but defined as nops for
>> everything but the "nostalgia club" to keep them from having any regressions.
>
> I doubt the nostalgia club cares about some latencies (that are
> usually only noticeable under extreme loads anyway).
>
> And if they do, maybe that would make somebody sit down and look into
> doing it right.
>
> So I think keeping it around would actually be both useless and
> counter-productive.

Amen to that.
