From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 0/8] Generic IPI sending tracepoint
Date: Mon, 14 Nov 2022 12:27:45 -0500
Message-ID: <20221114122745.189af864@gandalf.local.home>
References: <20221102182949.3119584-1-vschneid@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>

On Wed,  2 Nov 2022 18:29:41 +0000
Valentin Schneider <vschneid@redhat.com> wrote:

> This is incomplete, just looking at arm64 there's more IPI types that aren't
> covered: 
> 
>   IPI_CPU_STOP,
>   IPI_CPU_CRASH_STOP,
>   IPI_TIMER,
>   IPI_WAKEUP,
> 
> ... But it feels like a good starting point.

For the tracing portions:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
