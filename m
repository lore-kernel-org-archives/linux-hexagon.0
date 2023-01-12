From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 41/51] cpuidle,clk: Remove trace_.*_rcuidle()
Date: Thu, 12 Jan 2023 12:28:44 -0800
Message-ID: <cd75c97ac883283fb0764f5862a6377f.sboyd@kernel.org>
References: <20230112194314.845371875@infradead.org> <20230112195541.844982902@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673555327;
	bh=ZbPNLkIUkQwHXCbvQoI2XLaF4ww/POIlS320Sa4a75I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ew9S6ssyQxA/qOEa20QKNGKB4XNqKcj4gZvqGJH+zAG+P+Etqd7vw/znf/4NWIiTQ
	 Bk5xIf0TF8vpJTdsWmpqMzyz2u9CW3n58vVXYINgKQ8Ys9ny0OlUoy7YWJiSRsWGNl
	 RTVY7ppda94AJFEtcKo4HqFchiKjjT19SH8zBk8fjiY0YWgeKj83yZBlXudb2eSa64
	 q4IvtFH0u1VXC5cZIoMU1HyoWnUF84ag01Ib966jn6Jq4C3CU5IEq54tzZpHoOhssE
	 fZa0d21POZJLgjX5QB2TV2LFJLbEPppv5c9Y86RzgOUX6eeUDwPcIKdJkOiovDkAI3
	 X6K2ZCEAo7m+Q==
In-Reply-To: <20230112195541.844982902@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
To: peterz@infradead.org
Cc: juri.lelli@redhat.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, nsekhar@ti.com, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, srivatsa@csail.mit.edu, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, vincent.guittot@linaro.org, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromiu

Quoting Peter Zijlstra (2023-01-12 11:43:55)
> OMAP was the one and only user.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
