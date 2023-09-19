From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 17:17:23 +0200
Message-ID: <87y1h2ur98.ffs@tglx>
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
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695136644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziuwOLCbw6a4ZLSyQtFECkdi5DpyFdO1Yq7Iy0MyDm0=;
        b=xfTYwe+EZSOhJ5ZWyANndueq2hUu/L4a8CM1/oAoRZtzh4dXrcGLYGZmFDRlRbbmYt7Vk5
        q2a8s67GoVgkH/vtyTkmPv/zMoH9BYGxAEHj2NTitWpnBbFutuNDI6H1JPYV43N7FKxaoQ
        4hC/61NGBBGSMcuN2eSwwtsASqR3q3H06Cy7Z7rF614qv6pL1DZ+t3J4cwWM4+dA2YExPS
        Yj2UGnTJ24Wa6zHkGlCKoO+Zi6tBfDavDhwHUDdHZm3LfgYdhB7jLgydTPgxJk5eQXI5DE
        90AM6SeB7t4A+rORL9BVHHLD86RdMOvst214XGduAHjS54S1ZtgQLqiA15ULdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695136644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziuwOLCbw6a4ZLSyQtFECkdi5DpyFdO1Yq7Iy0MyDm0=;
        b=1eCCtDGKEUrDxtL8LY3g3sZgbE2u2Gi+z3OLPbxme25w5xD5smNfNB+DrDuC//vli78Ete
        kk+DBO2N6UphuqAw==
In-Reply-To: <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Peter Zijlstra <peterz@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>, l

On Tue, Sep 19 2023 at 15:21, Anton Ivanov wrote:
> On 19/09/2023 14:42, Peter Zijlstra wrote:
>> If you're working on one of them, then surely it's a simple matter of
>> working on adding CONFIG_PREEMPT support :-)
>
> In the case of UML adding preempt will be quite difficult. I looked at
> this a few years back.

What's so difficult about it?

Thanks,

        tglx
