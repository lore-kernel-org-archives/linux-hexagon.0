From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 15:21:39 +0100
Message-ID: <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <20230919134218.GA39281@noisy.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Zijlstra <peterz@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.



On 19/09/2023 14:42, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 03:37:24PM +0200, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 14:00 +0100, Matthew Wilcox wrote:
>>> On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
>>>> Though it just occured to me that there are dragons lurking:
>>>>
>>>> arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
>>>> arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
>>>> arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
>>>> arch/um/Kconfig:        select ARCH_NO_PREEMPT
>>>
>>> Sounds like three-and-a-half architectures which could be queued up for
>>> removal right behind ia64 ...
>>
>> The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>> that people are still working on! Can we please not do this?
> 
> If you're working on one of them, then surely it's a simple matter of
> working on adding CONFIG_PREEMPT support :-)

In the case of UML adding preempt will be quite difficult. I looked at this a few years back.

At the same time it is used for kernel test and other stuff. It is not exactly abandonware on a CPU found in archaeological artifacts of past civilizations like ia64.

> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
