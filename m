From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 15/35] Hexagon: Add init_task and process functions
Date: Wed, 31 Aug 2011 15:45:14 +0200
Message-ID: <201108311545.14797.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190801.159310885@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110830190801.159310885@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> Fixed potential race-to-sleep condition in cpu_idle().  I hope.
> 
> If called with interrupts disabled, our __vmwait() actually just returns
> without servicing it.  Let me know if there's any other condition that
> I've missed...

The race should be gone now, but

> +void cpu_idle(void)
> +{
> +	while (1) {
> +		tick_nohz_stop_sched_tick(1);
> +		local_irq_disable();
> +		while (!need_resched()) {
> +			idle_sleep();
> +			/*  interrupts wake us up, but aren't serviced  */
> +			local_irq_enable();	/* service interrupt   */
> +			local_irq_disable();
> +		}
> +		tick_nohz_restart_sched_tick();
> +		schedule();
> +	}
> +}

you now call schedule() with interrupts disabled, which isn't strictly
allowed.

I think it should all be fine if you write it as

	while (1) {
		tick_nohz_stop_sched_tick(1);
		local_irq_disable();
		while (!need_resched()) {
			idle_sleep();
		}
		local_irq_enable();
		tick_nohz_restart_sched_tick();
		schedule();
	}


	Arnd
