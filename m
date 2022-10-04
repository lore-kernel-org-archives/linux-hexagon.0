From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 23/44] arm,smp: Remove trace_.*_rcuidle() usage
Date: Tue, 4 Oct 2022 13:08:00 +0200
Message-ID: <CAPDyKFoMidikoTPe0Xd+wZQdBBJSoy+CZ2ZmJShfLkbGZZRYDQ@mail.gmail.com>
References: <20220919095939.761690562@infradead.org>
 <20220919101521.886766952@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D16158134F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6ACB781307
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F2BC81307
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32D43812C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=Gtwwkxm3K9zy3ub+GhlddjjtZ7fh91sG2Y46OOYgmCM=;
 b=EnhlO7DcICPKJpPG1jb7KTMLBU7DAMNWLzZM/l8aLFUsRZkWp+mkSVMMBmLZ1zgxaC
 wxY3CYIRcHyRXss5NtxD4hq5yFum2Xsa/Xfa8NFMZbQ3tgmqUq13E1Fcil8BIgM2OEw6
 m+P6TSNsaCcBVdUXpgo0TEJ7VOVGVt6KKPFMuMhn/bj0r2dm5zCuaEvX7UiZOqeeJEdX
 h1wGhs9cmKjNMVwi5bkackIBv98JM8+NjLMoMPaPS3klw1yQNu9dahurEQIN+cDnqkmM
 Hbcu0L1M6U3Rd654P0n2Hh4Q6bzGWuS7xOAcwB9SuDvPVBJ1Tctv5MAKRuD35o1eodHl
 dgPQ==
In-Reply-To: <20220919101521.886766952@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, linux-sh@vger.kernel.org, kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org, mingo@redhat.com, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, lpieralisi@kernel.org, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, kernel@pengutronix.de, t

On Mon, 19 Sept 2022 at 12:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> None of these functions should ever be ran with RCU disabled anymore.
>
> Specifically, do_handle_IPI() is only called from handle_IPI() which
> explicitly does irq_enter()/irq_exit() which ensures RCU is watching.
>
> The problem with smp_cross_call() was, per commit 7c64cc0531fa ("arm: Use
> _rcuidle for smp_cross_call() tracepoints"), that
> cpuidle_enter_state_coupled() already had RCU disabled, but that's
> long been fixed by commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
> deeper into the idle path").
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/kernel/smp.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -639,7 +639,7 @@ static void do_handle_IPI(int ipinr)
>         unsigned int cpu = smp_processor_id();
>
>         if ((unsigned)ipinr < NR_IPI)
> -               trace_ipi_entry_rcuidle(ipi_types[ipinr]);
> +               trace_ipi_entry(ipi_types[ipinr]);
>
>         switch (ipinr) {
>         case IPI_WAKEUP:
> @@ -686,7 +686,7 @@ static void do_handle_IPI(int ipinr)
>         }
>
>         if ((unsigned)ipinr < NR_IPI)
> -               trace_ipi_exit_rcuidle(ipi_types[ipinr]);
> +               trace_ipi_exit(ipi_types[ipinr]);
>  }
>
>  /* Legacy version, should go away once all irqchips have been converted */
> @@ -709,7 +709,7 @@ static irqreturn_t ipi_handler(int irq,
>
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  {
> -       trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
> +       trace_ipi_raise(target, ipi_types[ipinr]);
>         __ipi_send_mask(ipi_desc[ipinr], target);
>  }
>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
