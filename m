From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 33/44] ftrace: WARN on rcuidle
Date: Mon, 26 Sep 2022 14:41:57 -0400
Message-ID: <20220926144157.0406dfbb@gandalf.local.home>
References: <20220919095939.761690562@infradead.org>
 <20220919101522.573936213@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C8A4606F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9F5860B05
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08A3341873
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79A9640010
In-Reply-To: <20220919101522.573936213@infradead.org>
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


Nit, the subject should have "tracing:" an not "ftrace:" as the former
encompasses the tracing infrastructure and the latter is for the function
hook part of that.

On Mon, 19 Sep 2022 12:00:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> CONFIG_GENERIC_ENTRY disallows any and all tracing when RCU isn't
> enabled.
> 
> XXX if s390 (the only other GENERIC_ENTRY user as of this writing)
> isn't comfortable with this, we could switch to
> HAVE_NOINSTR_VALIDATION which is x86_64 only atm.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/tracepoint.h |   13 ++++++++++++-
>  kernel/trace/trace.c       |    3 +++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -178,6 +178,16 @@ static inline struct tracepoint *tracepo
>  #endif /* CONFIG_HAVE_STATIC_CALL */
>  
>  /*
> + * CONFIG_GENERIC_ENTRY archs are expected to have sanitized entry and idle
> + * code that disallow any/all tracing/instrumentation when RCU isn't watching.
> + */
> +#ifdef CONFIG_GENERIC_ENTRY
> +#define RCUIDLE_COND(rcuidle)	(rcuidle)
> +#else

Should probably move the below comment to here:

 /* srcu can't be used from NMI */

> +#define RCUIDLE_COND(rcuidle)	(rcuidle && in_nmi())
> +#endif
> +
> +/*
>   * it_func[0] is never NULL because there is at least one element in the array
>   * when the array itself is non NULL.
>   */
> @@ -189,7 +199,8 @@ static inline struct tracepoint *tracepo
>  			return;						\
>  									\
>  		/* srcu can't be used from NMI */			\

And remove the above.

-- Steve

> -		WARN_ON_ONCE(rcuidle && in_nmi());			\
> +		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
> +			return;						\
>  									\
>  		/* keep srcu and sched-rcu usage consistent */		\
>  		preempt_disable_notrace();				\
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3104,6 +3104,9 @@ void __trace_stack(struct trace_array *t
>  		return;
>  	}
>  
> +	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_GENERIC_ENTRY)))
> +		return;
> +
>  	/*
>  	 * When an NMI triggers, RCU is enabled via ct_nmi_enter(),
>  	 * but if the above rcu_is_watching() failed, then the NMI
> 
