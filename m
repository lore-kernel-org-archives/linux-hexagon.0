From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
Date: Fri, 19 Jun 2015 09:58:45 -0700
Message-ID: <CAGXu5jJFkv=ma0SJ-5N+GKQ3xoPw8193+kxO0F3M0c0_c=ZTtg@mail.gmail.com>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
	<1434386579-6045-2-git-send-email-dave.long@linaro.org>
	<1434687583.23771.5.camel@ellerman.id.au>
	<5584234E.2040701@linaro.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zzgXkdpN61hYOVX+QnZLztquSri8F6L7BqLVwFOCu3Y=;
        b=XA0Ybe0RgaIzbq9xfpPEV3dvUKPIIZHlLRK4NfTEG2+6h3Saxpes5I8uXh3RmHFPHN
         nC4KSvJ+YecZIBTWdWsOD53RgY4QtzVCTHJbElAVHKrFhx+/YWe868evB1bxz7CHEmNH
         lPoyrbpXOt3xiDA3cqtgA93t+kZVEpsmP5RmulYlmfwLEb0nHBwTRXyZHZwKi5iDY4Cy
         4ara9QNK5RFQ9UoJVE0ztQXYnDfG4xZ5aijmsVXsPgjw0wURea19qTuI99N6tHLsLVHa
         Vbp/mUzrAFpQ+E28h74VEgbPFXRUyXu87Y5UR2/uvzAimsCEPq7mlFiMNL+7crdXNTzN
         9iyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zzgXkdpN61hYOVX+QnZLztquSri8F6L7BqLVwFOCu3Y=;
        b=BLVypo1CPvStMw3vhf5N4lhd0X3bpQ4ZRllIP9I6BLeerm7d1/E/+4F9coMzm7nbIE
         LIMlGwmUT5nQUzWVW2ItNmpQMD5fl+4TIJhThILCZHgWkN6B9VDprKH/r0WjpukWNPLY
         l3zxqb5L3i/IsBJK6KeFLfRuM1njhh5Inml2Y=
In-Reply-To: <5584234E.2040701@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Long <dave.long@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-h

On Fri, Jun 19, 2015 at 7:12 AM, David Long <dave.long@linaro.org> wrote:
> On 06/19/15 00:19, Michael Ellerman wrote:
>>
>> On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
>>>
>>> From: "David A. Long" <dave.long@linaro.org>
>>>
>>> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>>>   feature and has identical definitions in four different arch ptrace.h
>>> include files. It seems unlikely that definition would ever need to be
>>> changed regardless of architecture so lets move it into
>>> include/linux/ptrace.h.
>>>
>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>> ---
>>>   arch/powerpc/kernel/ptrace.c | 5 -----
>>
>>
>> Built and booted on powerpc, but is there an easy way to actually test the
>> code
>> paths in question?
>>
>
> There is an easy way to "smoke test" it on all archiectures that also
> implement kprobes (which powerpc does).  If I'm understanding the powerpc
> code correctly (WRT register naming conventions) just do the following:
>
> cd /sys/kernel/debug/tracing
> echo 'p do_fork %gpr0' > kprobe_events
> echo 1 > events/kprobes/enable
> ls
> cat trace
> echo 0 > events/kprobes/enable
>
> Every fork() call done on the system between those two echo commands (hence
> the "ls") should append a line to the trace file.  For a more exhaustive
> test one could repeat this sequence for every register in the architecture.
>
> This should work the same on all architectures supporting kprobes.  You just
> have to use the appropriate register names for your architecture after the
> "%".

Is this something we could codify into the selftests directory? It
seems like a great thing to capture in a single place somewhere (the
register lists, that is).

-Kees

>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> cheers
>>
>>
>
> Thanks,
> -dl
>



-- 
Kees Cook
Chrome OS Security
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
