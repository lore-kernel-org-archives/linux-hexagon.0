From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 0/5] Generic IPI sending tracepoint
Date: Tue, 11 Oct 2022 16:41:43 -0400
Message-ID: <20221011164143.52c84421@rorschach.local.home>
References: <20221007154145.1877054-1-vschneid@redhat.com>
        <Y0CFnWDpMNGajIRD@fuller.cnet>
        <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
        <3e680bb9-9896-3665-dd59-4f2e6f8205bb@redhat.com>
        <xhsmhfsfufh51.mognet@vschneid.remote.csb>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <xhsmhfsfufh51.mognet@vschneid.remote.csb>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Valentin Schneider <vschneid@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>

On Tue, 11 Oct 2022 17:40:26 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> > You could keep the tracepoint as a mask, and then make it pretty, like cpus=3-5,8
> > in user-space. For example with a trace-cmd/perf loadable plugin, libtracefs helper.
> >  
> 
> That's a nice idea, the one downside I see is that means registering an
> event handler for all events with cpumasks rather than directly targeting
> cpumask fields, but that doesn't look too horrible. I'll dig a bit in that
> direction.

We could just make all all dynamic array's of unsigned long use that
format? I don't know of any other event that has dynamic arrays of
unsigned longs. And doing a search doesn't come up with any.

-- Steve
