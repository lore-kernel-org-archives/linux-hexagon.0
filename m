From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 14/44] cpuidle,
 cpu_pm: Remove RCU fiddling from cpu_pm_{enter, exit}()
Date: Tue, 4 Oct 2022 13:04:57 +0200
Message-ID: <CAPDyKFquBVkYmKsriPD+BfVrrz62ih7oCxb7HwOML+Zzs-5U_Q@mail.gmail.com>
References: <20220919095939.761690562@infradead.org>
 <20220919101521.274051658@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D6594012F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD1AE408CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46FF160B5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4B2560B46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=8dOAtcXqtbDTbOtGHdeMRx2lSxGZ/p81xoeulWg88O8=;
 b=ALPYtY9NECpkdz09jpHMZbs0aH+hKiq7zCwXfK1hWKvM2elz9mNR/JJb0byGfir59h
 CWc9izoQX0glvUd9bdjzB+GxZIKg7cZ1wWKnb5xSlDD9fDdUtUduD7qTiOAX8rgJzNMY
 16i4fnybYgh61uFsRfFa0jFHaMm217pAorBQUItONSq5D0pjQfmpgEbFEG0ovD83XmiY
 JRBnUwctQs5MU4QsxdCrYJ2mV5ubOvxFCDZOs+xf+eBgsrQVN1CIV6SHGqFX6RFQbzq7
 D2ARCpgG/orA8SpRSFPIMnoc2IRLOYljdFwc8QX3tXFa2vpA/P7Kkd/ZsaWnXMh+ArFb
 1Asw==
In-Reply-To: <20220919101521.274051658@infradead.org>
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <a>

On Mon, 19 Sept 2022 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> All callers should still have RCU enabled.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  kernel/cpu_pm.c |    9 ---------
>  1 file changed, 9 deletions(-)
>
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -30,16 +30,9 @@ static int cpu_pm_notify(enum cpu_pm_eve
>  {
>         int ret;
>
> -       /*
> -        * This introduces a RCU read critical section, which could be
> -        * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
> -        * this.
> -        */
> -       ct_irq_enter_irqson();
>         rcu_read_lock();
>         ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
>         rcu_read_unlock();
> -       ct_irq_exit_irqson();
>
>         return notifier_to_errno(ret);
>  }
> @@ -49,11 +42,9 @@ static int cpu_pm_notify_robust(enum cpu
>         unsigned long flags;
>         int ret;
>
> -       ct_irq_enter_irqson();
>         raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
>         ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
>         raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
> -       ct_irq_exit_irqson();
>
>         return notifier_to_errno(ret);
>  }
>
>
