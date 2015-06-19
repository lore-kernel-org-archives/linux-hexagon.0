From: David Long <dave.long@linaro.org>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
Date: Fri, 19 Jun 2015 10:12:30 -0400
Message-ID: <5584234E.2040701@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>	 <1434386579-6045-2-git-send-email-dave.long@linaro.org> <1434687583.23771.5.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434687583.23771.5.camel@ellerman.id.au>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kerne

On 06/19/15 00:19, Michael Ellerman wrote:
> On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>>   feature and has identical definitions in four different arch ptrace.h
>> include files. It seems unlikely that definition would ever need to be
>> changed regardless of architecture so lets move it into
>> include/linux/ptrace.h.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/powerpc/kernel/ptrace.c | 5 -----
>
> Built and booted on powerpc, but is there an easy way to actually test the code
> paths in question?
>

There is an easy way to "smoke test" it on all archiectures that also 
implement kprobes (which powerpc does).  If I'm understanding the 
powerpc code correctly (WRT register naming conventions) just do the 
following:

cd /sys/kernel/debug/tracing
echo 'p do_fork %gpr0' > kprobe_events
echo 1 > events/kprobes/enable
ls
cat trace
echo 0 > events/kprobes/enable

Every fork() call done on the system between those two echo commands 
(hence the "ls") should append a line to the trace file.  For a more 
exhaustive test one could repeat this sequence for every register in the 
architecture.

This should work the same on all architectures supporting kprobes.  You 
just have to use the appropriate register names for your architecture 
after the "%".

> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> cheers
>
>

Thanks,
-dl

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
