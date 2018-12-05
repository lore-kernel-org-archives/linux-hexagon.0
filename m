From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
Date: Tue, 4 Dec 2018 19:41:28 -0800
Message-ID: <CAD=FV=WS+9d6xeCx4xDqSQkPKPuRx6yATh=j_c1=uJpTdMVUqA@mail.gmail.com>
References: <20181127173839.34328-1-dianders@chromium.org> <20181127173839.34328-3-dianders@chromium.org>
 <20181203155724.7g37vp43e4fd4xqk@holly.lan>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=claPucn+XJmQuNDr9GzOxYNtVSSdZHOjhhV3KuIo0kc=;
        b=imbLSuUdrAQA+3eZTMnGhlCCedBfnUq0nH8VeWgXogzdRJPxVpsi6rdlN+L037ryt/
         c3Bg09Qimd0+OuB8LKUrOzPW/Bgv8lKmtZzpVicVGuWesxKatrE6XgbZD2GlbsrjCd4/
         yd0IeRC1t/Tzha8cYdMtMxxdHI5JaICl3xbAM=
In-Reply-To: <20181203155724.7g37vp43e4fd4xqk@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Will Deacon <will.deacon@arm.com>, kgdb-bugreport@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org, linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, dalias@libc.org, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com, rkuo@codeaurora.org, linuxppc-de

Hi,

On Mon, Dec 3, 2018 at 7:57 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Nov 27, 2018 at 09:38:37AM -0800, Douglas Anderson wrote:
> > When I had lockdep turned on and dropped into kgdb I got a nice splat
> > on my system.  Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> >
> > Specifically it looked like this:
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
> > Looking closely at it, it seems like a really bad idea to be calling
> > local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> > like it could violate spinlock semantics and cause a deadlock.
> >
> > Instead, let's use a private csd alongside
> > smp_call_function_single_async() to round up the other CPUs.  Using
> > smp_call_function_single_async() doesn't require interrupts to be
> > enabled so we can remove the offending bit of code.
> >
> > In order to avoid duplicating this across all the architectures that
> > use the default kgdb_roundup_cpus(), we'll add a "weak" implementation
> > to debug_core.c.
> >
> > Looking at all the people who previously had copies of this code,
> > there were a few variants.  I've attempted to keep the variants
> > working like they used to.  Specifically:
> > * For arch/arc we passed NULL to kgdb_nmicallback() instead of
> >   get_irq_regs().
> > * For arch/mips there was a bit of extra code around
> >   kgdb_nmicallback()
> >
> > NOTE: In this patch we will still get into trouble if we try to round
> > up a CPU that failed to round up before.  We'll try to round it up
> > again and potentially hang when we try to grab the csd lock.  That's
> > not new behavior but we'll still try to do better in a future patch.
> >
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Moved smp_call_function_single_async() error check to patch 3.
> >
> > Changes in v5:
> > - Add a comment about get_irq_regs().
> > - get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
> > - for_each_cpu() => for_each_online_cpu()
> > - Error check smp_call_function_single_async()
> >
> > Changes in v4: None
> > Changes in v3:
> > - No separate init call.
> > - Don't round up the CPU that is doing the rounding up.
> > - Add "#ifdef CONFIG_SMP" to match the rest of the file.
> > - Updated desc saying we don't solve the "failed to roundup" case.
> > - Document the ignored parameter.
> >
> > Changes in v2:
> > - Removing irq flags separated from fixing lockdep splat.
> > - Don't use smp_call_function (Daniel).
> >
> >  arch/arc/kernel/kgdb.c     | 10 ++--------
> >  arch/arm/kernel/kgdb.c     | 12 -----------
> >  arch/arm64/kernel/kgdb.c   | 12 -----------
> >  arch/hexagon/kernel/kgdb.c | 27 -------------------------
> >  arch/mips/kernel/kgdb.c    |  9 +--------
> >  arch/powerpc/kernel/kgdb.c |  4 ++--
> >  arch/sh/kernel/kgdb.c      | 12 -----------
>
> Please could you re-send with the arch maintainers for these platforms
> included in the Cc: of the patch description rather than just in the
> e-mail header.
>
> I'd like to make sure arch maintainers have a chance to opt out if they
> want to (it's a weak symbol so an arch could chose not to use it).
>
> Otherwise I shall start testing shortly!

OK, I did a repost of v6 with the Cc's and also the Acks I've received
so far.  There are no code changes in the repost.  Please let me know
if you have additional comments and thanks for your help.

-Doug
