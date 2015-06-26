From: David Long <dave.long@linaro.org>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
Date: Fri, 26 Jun 2015 14:35:29 -0400
Message-ID: <558D9B71.2080605@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>	<1434386579-6045-2-git-send-email-dave.long@linaro.org>	<1434687583.23771.5.camel@ellerman.id.au>	<5584234E.2040701@linaro.org> <CAGXu5jJFkv=ma0SJ-5N+GKQ3xoPw8193+kxO0F3M0c0_c=ZTtg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJFkv=ma0SJ-5N+GKQ3xoPw8193+kxO0F3M0c0_c=ZTtg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-h

On 06/19/15 12:58, Kees Cook wrote:
> On Fri, Jun 19, 2015 at 7:12 AM, David Long <dave.long@linaro.org> wrote:
>> On 06/19/15 00:19, Michael Ellerman wrote:
>>>
>>> On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
>>>>
>>>> From: "David A. Long" <dave.long@linaro.org>
>>>>
>>>> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>>>>    feature and has identical definitions in four different arch ptrace.h
>>>> include files. It seems unlikely that definition would ever need to be
>>>> changed regardless of architecture so lets move it into
>>>> include/linux/ptrace.h.
>>>>
>>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>>> ---
>>>>    arch/powerpc/kernel/ptrace.c | 5 -----
>>>
>>>
>>> Built and booted on powerpc, but is there an easy way to actually test the
>>> code
>>> paths in question?
>>>
>>
>> There is an easy way to "smoke test" it on all archiectures that also
>> implement kprobes (which powerpc does).  If I'm understanding the powerpc
>> code correctly (WRT register naming conventions) just do the following:
>>
>> cd /sys/kernel/debug/tracing
>> echo 'p do_fork %gpr0' > kprobe_events
>> echo 1 > events/kprobes/enable
>> ls
>> cat trace
>> echo 0 > events/kprobes/enable
>>
>> Every fork() call done on the system between those two echo commands (hence
>> the "ls") should append a line to the trace file.  For a more exhaustive
>> test one could repeat this sequence for every register in the architecture.
>>
>> This should work the same on all architectures supporting kprobes.  You just
>> have to use the appropriate register names for your architecture after the
>> "%".
>
> Is this something we could codify into the selftests directory? It
> seems like a great thing to capture in a single place somewhere (the
> register lists, that is).
> e
> -Kees
>

Due to the architecture-specific naming of registers this would have to 
be added to the architecture subdirectories.  I only see powerpc and x86 
subdirs at this time so extending that infrastructure would have to be 
part of this.  Verifying the register contents would also require some 
change to the kernel, possibly a simple test module, which would have to 
be unique to each architecture.  Without that we could only check for 
recognition of the register name, although maybe that's good enough.

>>
>>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>>
>>> cheers
>>>
>>>
>>
>> Thanks,
>> -dl
>>


-dl


