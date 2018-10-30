From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
Date: Tue, 30 Oct 2018 15:21:30 -0700
Message-ID: <CAD=FV=Wno+QbhUp+0+Pmk72Ds4C9d25ynSH=0JDdttJ2WBU4NA@mail.gmail.com>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-7-dianders@chromium.org> <20181030094159.zt6akmyxwrbzoe2x@holly.lan>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wA1rTDsTXMl16yQ5A/Q7u3m9syhvXP+vgKrx+kVLhhM=;
        b=XyUm3UDblUwDfzhrHUB+GFOrtiFy2nwEZ/VX9E9gX9X0NUKTyY2otgPaloBJ9jsQ2m
         dUhTvg/OOH/gfA7J5HVIqQsEilgJseVCLNk0SKpmF4vvHNGar1Xu1lVgKMAZvcpZSha/
         /dtGN3uF6cf+b1S6nL1uPSb9pxYJBMbCGV4YM=
In-Reply-To: <20181030094159.zt6akmyxwrbzoe2x@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org, frederic@kernel.org, riel@surriel.com, LKML <linux-kernel@vger.kernel.org>, luto@kernel.org, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Daniel,

On Tue, Oct 30, 2018 at 2:42 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:06AM -0700, Douglas Anderson wrote:
> > In kgdb_roundup_cpus() we've got code that looks like:
> >   local_irq_enable();
> >   smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> >   local_irq_disable();
> >
> > In certain cases when we drop into kgdb (like with sysrq-g on a serial
> > console) we'll get a big yell that looks like:
> >
> >   sysrq: SysRq : DEBUG
> >   ------------[ cut here ]------------
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> >   WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
> >   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
> >   pstate: 604003c9 (nZCv DAIF +PAN -UAO)
> >   pc : lockdep_hardirqs_on+0xf0/0x160
> >   ...
> >   Call trace:
> >    lockdep_hardirqs_on+0xf0/0x160
> >    trace_hardirqs_on+0x188/0x1ac
> >    kgdb_roundup_cpus+0x14/0x3c
> >    kgdb_cpu_enter+0x53c/0x5cc
> >    kgdb_handle_exception+0x180/0x1d4
> >    kgdb_compiled_brk_fn+0x30/0x3c
> >    brk_handler+0x134/0x178
> >    do_debug_exception+0xfc/0x178
> >    el1_dbg+0x18/0x78
> >    kgdb_breakpoint+0x34/0x58
> >    sysrq_handle_dbg+0x54/0x5c
> >    __handle_sysrq+0x114/0x21c
> >    handle_sysrq+0x30/0x3c
> >    qcom_geni_serial_isr+0x2dc/0x30c
> >   ...
> >   ...
> >   irq event stamp: ...45
> >   hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
> >   hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
> >   softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
> >   softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
> >   ---[ end trace adf21f830c46e638 ]---
> >
> > Let's add kgdb to the list of reasons not to warn in
> > smp_call_function_many().  That will allow us (in a future patch) to
> > stop calling local_irq_enable() which will get rid of the original
> > splat.
> >
> > NOTE: with this change comes the obvious question: will we start
> > deadlocking more often now when we drop into the debugger.  I can't
> > say that for sure one way or the other, but the fact that we do the
> > same logic for "oops_in_progress" makes me feel like it shouldn't
> > happen too often.  Also note that the old logic of turning on
> > interrupts temporarily wasn't exactly safe since (I presume) that
> > could have violated spin_lock_irqsave() semantics and ended up with a
> > deadlock of its own.
>
> This is part of the code to bring all the cores to a halt and since
> the other cores are still running kgdb isn't yet able to use the fact
> all the CPUs are halted to bend the rules. It is better for this code
> to play by the rules if it can.
>
> Is is possible to get the roundup functions to use a private csd
> alongside smp_call_function_single_async()? We could add a helper
> function to the debug core to avoid having to add cpu_online loops into
> every kgdb_roundup_cpus() implementaton.

Exactly the kind of helpful suggestion I was looking for.  Thank you
very much!  See v2 and hopefully it matches what you were thinking of.

-Doug
