From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 39/44] cpuidle,clk: Remove trace_.*_rcuidle()
Date: Tue, 4 Oct 2022 13:09:21 +0200
Message-ID: <CAPDyKFqoBJPgehVODY0DGuUcnqJE5rpZjRPfdMCzOP0=JrvKNw@mail.gmail.com>
References: <20220919095939.761690562@infradead.org>
 <20220919101522.975285117@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AF8940B3B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D31DA400CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 949CE82C98
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B11068132A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=Z7fvRiwPcYU72K21mcsEeWsle1VHrp2FoZLK7rnaPdE=;
 b=OhrgekEJA2e8cdAwMtySnzVGP1IXX7u0VkwcrOOu54GZ2JxdWY9lEfVkhASIMdH6iJ
 3CS7i3bHpSnDattX7vdcbOy/0Ru61hlzqZKw12qszXyQ8c8k8+VbmoP3khJqXB2u34OK
 r0R6w3Chhty48bs5fIPiEqpNsjqgSOd25DYZPmh/eJumMJEGGWz83W+3fdR0JwF+vFO5
 mEEbHpfpQY24Mu19zAFZi2TsiyCRpZk9s0G1O2wNLxMVY3JMpx0s8hV3tsChMbk0eh7y
 zwRqOOW8NupYp/v5bTpNygY4XFLMrr9CtK+i2O/hqSFWvl5B0S5XIVxlEXDh/AnokWSK
 1UeA==
In-Reply-To: <20220919101522.975285117@infradead.org>
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

On Mon, 19 Sept 2022 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> OMAP was the one and only user.

OMAP? :-)

>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/clk/clk.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -978,12 +978,12 @@ static void clk_core_disable(struct clk_
>         if (--core->enable_count > 0)
>                 return;
>
> -       trace_clk_disable_rcuidle(core);
> +       trace_clk_disable(core);
>
>         if (core->ops->disable)
>                 core->ops->disable(core->hw);
>
> -       trace_clk_disable_complete_rcuidle(core);
> +       trace_clk_disable_complete(core);
>
>         clk_core_disable(core->parent);
>  }
> @@ -1037,12 +1037,12 @@ static int clk_core_enable(struct clk_co
>                 if (ret)
>                         return ret;
>
> -               trace_clk_enable_rcuidle(core);
> +               trace_clk_enable(core);
>
>                 if (core->ops->enable)
>                         ret = core->ops->enable(core->hw);
>
> -               trace_clk_enable_complete_rcuidle(core);
> +               trace_clk_enable_complete(core);
>
>                 if (ret) {
>                         clk_core_disable(core->parent);
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
