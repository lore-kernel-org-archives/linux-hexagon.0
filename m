From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Date: Wed, 31 Oct 2018 17:01:36 +0000
Message-ID: <20181031170136.s3ids6tm4rxxlpma@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031134926.GB13237@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7PRsslQ+AmlGw6ESJEAEIN3Ju+lMTMOAAXzG79p0Hk=;
        b=LcTmkgLaTJl5aqBKxMqvydqj6P3/DffuXvVPbAUygeibeDLzwTIQqXfR4uds2rIZYM
         XhmMGb7KngDWan146d22FCM9UQ9Ko/QDf54C0Fdt16LXoigKyLTLkNkKnhAaTuALlKv5
         25xBM+L683GMsxPWlmbZaDfh6fxO/3dRfQFIc=
Content-Disposition: inline
In-Reply-To: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.or>

On Wed, Oct 31, 2018 at 02:49:26PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > Looking closely at it, it seems like a really bad idea to be calling
> > local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> > like it could violate spinlock semantics and cause a deadlock.
> > 
> > Instead, let's use a private csd alongside
> > smp_call_function_single_async() to round up the other CPUs.  Using
> > smp_call_function_single_async() doesn't require interrupts to be
> > enabled so we can remove the offending bit of code.
> 
> You might want to mention that the only reason this isn't a deadlock
> itself is because there is a timeout on waiting for the slaves to
> check-in.

dbg_master_lock must be owned to call kgdb_roundup_cpus() so
the calls to smp_call_function_single_async() should never deadlock the
calling CPU unless there has been a previous failure to round up (e.g.
cores that cannot react to the round up signal).

When there is a failure to round up when we resume, there is a window (before
whatever locks that prevented the IPI being serviced are released) during which
the system will deadlock if the debugger is re entered.

I don't think there is any point trying to round up a CPU that did not
previously respond... it should still have an IPI pending. The deadlock
can be eliminated by getting the round up code to avoid CPUs whose csd->flags
are non-zero either by checking the flag in the kgdb code or adding something
like smp_trycall_function_single_async().


Daniel.
