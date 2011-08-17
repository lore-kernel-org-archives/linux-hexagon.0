From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 15/36] Hexagon: Add init_task and process functions
Date: Wed, 17 Aug 2011 21:45:10 +0200
Message-ID: <1903508.hihLuMSVUz@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163521.257943209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163521.257943209@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:35:12 Richard Kuo wrote:
> +/*
> + *  Spin, or better still, do a hardware or VM wait instruction
> + *  If hardware or VM offer wait termination even though interrupts
> + *  are disabled.
> + */
> +static void default_idle(void)
> +{
> +       __vmwait();
> +}
> +
> +void (*idle_sleep)(void) = default_idle;
> +
> +void cpu_idle(void)
> +{
> +       while (1) {
> +               tick_nohz_stop_sched_tick(1);
> +               while (!need_resched())
> +                       idle_sleep();
> +               tick_nohz_restart_sched_tick();
> +               schedule();
> +       }
> +}

This looks like you have the classic going to sleep race in here:

You need to disable hardware interrupts before checking need_resched(),
otherwise an interrupt might hit just after you have checked it and
before you call __vmwait(). The definition of the __vmwait call
must atomically reenable interrupts and suspend the CPU.

	Arnd
