From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sun, 24 Feb 2013 15:03:37 -0600
Message-ID: <CAHrUA36YTCfedZGxBa+Vgzvz=DBR=PJhcPHe0aZegQiD79gHXQ@mail.gmail.com>
References: <1163031361018389@web26d.yandex.ru> <1361593470.29465.17@driftwood>
 <171311361707235@web14d.yandex.ru> <CAHrUA34oWaQvVwWk7cCcYmh188pv=vNCZnXWvn4sDJN0k-QEaA@mail.gmail.com>
 <2140201361726967@web5h.yandex.ru>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=kmcivpHVkebrT2CktVGNR9CRzKm0P+3iZSZG+x1CsLo=;
        b=kRfYd6crunZcpfv4UGaA8d116+RgrF42zcWRDhexpwJXrEDMinjl9foASGxp2+tUT6
         WUtxR0tB8VZK9i8Rrb+rwgWgFX1r6Jv5hEJCxJPAF4RPFQGwdh/WAmGIMW1eec7NZxFy
         B4RNnWPUBPrWzXiQVm/cHS84hrkchPnAhfDEtRRxRG2bRlX4JMb0hV+PhCdPjlH+wG6S
         Q50r4E4p3qqCG2jAVwDr87D+F/YrASnmGXZV7Nfvh1peG/7ydNyrrVqKQgL5OC2VKudR
         oUAjOVxVDu3ytn1G+2abjz8KolHb6bBGMM8XNHFRulPNtqjSVfIe3nFkXEvOUXSVeRlw
         hSlg==
In-Reply-To: <2140201361726967@web5h.yandex.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 24 February 2013 11:29,  <cotulla@yandex.ua> wrote:
>
>>  Well.... you are using memb to copy one byte at a time, instead of
>>  memd which will copy 8 bytes at a time.   So that change alone should
>>  multiply performance by 8.
>>
>>  You can almost surely be more clever, and move the if statement and
>>  the increment into a packet, so that they execute in parallel.  Its a
>>  vliw, its very parallel, that needs to be exploited.  For example, (if
>>  I remember correctly (?)) you can set and read r2 in the same packet,
>>  the read will get the old value, the set will write the new value.
>>  You can move the jumpr into the next packet, if you don't mind copying
>>  one extra byte.   So there are many tricks like this.
>>
>>  I don't remember the details any longer, but there are cases where the
>>  compiler would inline some fairly efficient memcpy code.   Also .. the
>>  compiler is smart, in general --  you should try writing the loop in C
>>  (and using 64-bit words) and seeing what it generates.
>>
>>  And finally, aren't there some optimized memcpy assembly routines in
>>  the kernel? I know we kept talking about these...
>>
>>  --linas
>
> Yes, there is an optimized memcpy version.
> But my goal was to "compare" ARM performance with QDSP6 to know what to wait from it.
> So I made a simple C code and tested it on both processors.

I don't understand what you are trying to do, or what you are
expecting.  The hardware is fundamentally different.  As Rob
explained, the hexagon is effectively clocked at the same rate as the
RAM, so you don't need a fancy bus or any fancy hardware to try to
coalesce reads/writes.   By contrast, the ARM is clocked so fast that
a simple bus design would cause it t to stall waiting on RAM. So I
assuming that they have a write-coalescing circuit, which collects up
bytes until they reach bus width, and only then pump the bus.

I don't know if the ARM does this, but I've seen cache designs
optimized for Java:  they noticed that java programs set a word to
zero, and then, a few cycles later, write a different value to the
same location. So this circuit doesn't push out the zero right away;
this keeps down the traffic to the cache, lessens bus contention.

I mean, who knows how the ARM is designed ..

> And there is a difference between them. My question was in general: do you think it's normal or QDSP6 should work faster/slower?

Well, I answered that question: if you ask the processor to write one
byte at a time, it will.  But you could ask it to write 8 bytes at a
time, and it will do that 8 times faster.  And if you make the
processor execute several no-ops  between writes, then, yes, your
write performance will decrease.  The VLIW has four slots per cycle.
Your example program used less than two slots per cycle, more than 60%
or 70% of your program consisted of no-ops. (the dis-assembler doesn't
normally print no-ops for empty slots, it just leaves them blank).

That said, I don't remember at all what the clock speeds or any of
that stuff, so I'm not sure what it should be. It changed between v2,
v3, v4, v5.

> Did you test performance inside Linux on Hexagon?

Yes ... the main result was that it was TLB-starved.  They guys
designing it are performance and watts-per-cycle crazy, they're very
devoted to optimizing this stuff, to getting the most per transistor
possible. Its a very tiny core with very few transistors.  I mean, its
probably smaller than the ARM register file (OK, I'm just making this
last one up, but I'm guessing it just might be true, I wouldn't be
surprised.).

-- Linas
