From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 0/5] Generic IPI sending tracepoint
Date: Tue, 11 Oct 2022 16:34:53 -0400
Message-ID: <20221011163453.2133ab4a@rorschach.local.home>
References: <20221007154145.1877054-1-vschneid@redhat.com>
        <Y0CFnWDpMNGajIRD@fuller.cnet>
        <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Valentin Schneider <vschneid@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel

On Tue, 11 Oct 2022 17:17:04 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> tep_get_field_val() just yields an unsigned long long of value 0x200018,
> which AFAICT is just the [length, offset] thing associated with dynamic
> arrays. Not really usable, and I don't see anything exported in the lib to
> extract and use those values.

Correct.

> 
> tep_get_field_raw() is better, it handles the dynamic array for us and
> yields a pointer to the cpumask array at the tail of the record. With that
> it's easy to get an output such as: cpumask[size=32]=[4,0,0,0,]. Still,
> this isn't a native type for many programming languages.

Yeah, this is the interface that I would have used. And it would likely
require some kind of wrapper to make it into what you prefer.

Note, I've been complaining for some time now how much I hate the
libtraceevent interface, and want to rewrite it. (I just spoke to
someone that wants to implement it in Rust). But the question comes
down to how to make it backward compatible. Perhaps we don't and just
up the major version number (libtraceevent 2.0).

What would you recommend as an API to process cpumasks better?

-- Steve
