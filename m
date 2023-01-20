From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 16/51] cpuidle: Annotate poll_idle()
Date: Fri, 20 Jan 2023 10:56:35 +0100
Message-ID: <Y8plU/f2WsmGG66H__22091.6562875331$1674208687$gmane$org@hirez.programming.kicks-ass.net>
References: <20230112194314.845371875@infradead.org>
 <20230112195540.312601331@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5PCjUACeYMR6O3y/YgzV4vR8g0qeDy6mmRm0X3w+etU=; b=UZLTzgFBQJ0CQY6DaI73G+uFss
        KwqGSOIdxHfJPvAvpX0h5594aYEYuxp9p+5pIYFQiUyoAtjfGblRYGkqNzzC7O97qLGLXKgOA6xcT
        W2FVpKWX5ry5A3YJ73W5lemSQrX8POUcGFF7oICR8UVyWBARWyply9gPbxYr03MOkT4RNv8a7lsM2
        GazDd5sT6cIuf+3/HAZqobxVWQ/2ElCMUjfxs3yQvXPFy+TlHZutHnPGN5zaBk3/2GxDDh+Chwiar
        rw/dMsVd9kwwUKYpn7si4MqeWxgiSIiBAN6g7snkhdi9zBu81hUwPqpAaiLr5X9LZFKT3ZN6B53aD
        8key49Jw==;
Content-Disposition: inline
In-Reply-To: <20230112195540.312601331@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au

On Thu, Jan 12, 2023 at 08:43:30PM +0100, Peter Zijlstra wrote:
> The __cpuidle functions will become a noinstr class, as such they need
> explicit annotations.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/poll_state.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -13,7 +13,10 @@
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  			       struct cpuidle_driver *drv, int index)
>  {
> -	u64 time_start = local_clock();
> +	u64 time_start;
> +
> +	instrumentation_begin();
> +	time_start = local_clock();
>  
>  	dev->poll_time_limit = false;
>  
> @@ -39,6 +42,7 @@ static int __cpuidle poll_idle(struct cp
>  	raw_local_irq_disable();
>  
>  	current_clr_polling();
> +	instrumentation_end();
>  
>  	return index;
>  }

Pff, this patch is garbage. However wrote it didn't have his brain
engaged :/

Something like the below fixes it, but I still need to build me funny
configs like ia64 and paravirt to see if I didn't wreck me something...

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..70c07e11caa6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -215,7 +215,7 @@ static void __init cyc2ns_init_secondary_cpus(void)
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
-u64 native_sched_clock(void)
+noinstr u64 native_sched_clock(void)
 {
 	if (static_branch_likely(&__use_tsc)) {
 		u64 tsc_now = rdtsc();
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 500d1720421e..0b00f21cefe3 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -426,7 +426,7 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
  * @dev:   the cpuidle device
  *
  */
-u64 cpuidle_poll_time(struct cpuidle_driver *drv,
+__cpuidle u64 cpuidle_poll_time(struct cpuidle_driver *drv,
 		      struct cpuidle_device *dev)
 {
 	int i;
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index d25ec52846e6..bdcfeaecd228 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -15,7 +15,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 {
 	u64 time_start;
 
-	instrumentation_begin();
 	time_start = local_clock();
 
 	dev->poll_time_limit = false;
@@ -42,7 +41,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	raw_local_irq_disable();
 
 	current_clr_polling();
-	instrumentation_end();
 
 	return index;
 }
diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 867d588314e0..7960f0769884 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -45,7 +45,7 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock();
 }
 
-static inline u64 local_clock(void)
+static __always_inline u64 local_clock(void)
 {
 	return sched_clock();
 }
@@ -79,7 +79,7 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock_cpu(cpu);
 }
 
-static inline u64 local_clock(void)
+static __always_inline u64 local_clock(void)
 {
 	return sched_clock_cpu(raw_smp_processor_id());
 }
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index e374c0c923da..6b3b0559e53c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -260,7 +260,7 @@ notrace static inline u64 wrap_max(u64 x, u64 y)
  *  - filter out backward motion
  *  - use the GTOD tick value to create a window to filter crazy TSC values
  */
-notrace static u64 sched_clock_local(struct sched_clock_data *scd)
+noinstr static u64 sched_clock_local(struct sched_clock_data *scd)
 {
 	u64 now, clock, old_clock, min_clock, max_clock, gtod;
 	s64 delta;
@@ -287,7 +287,7 @@ notrace static u64 sched_clock_local(struct sched_clock_data *scd)
 	clock = wrap_max(clock, min_clock);
 	clock = wrap_min(clock, max_clock);
 
-	if (!try_cmpxchg64(&scd->clock, &old_clock, clock))
+	if (!arch_try_cmpxchg64(&scd->clock, &old_clock, clock))
 		goto again;
 
 	return clock;
@@ -360,7 +360,7 @@ notrace static u64 sched_clock_remote(struct sched_clock_data *scd)
  *
  * See cpu_clock().
  */
-notrace u64 sched_clock_cpu(int cpu)
+noinstr u64 sched_clock_cpu(int cpu)
 {
 	struct sched_clock_data *scd;
 	u64 clock;
