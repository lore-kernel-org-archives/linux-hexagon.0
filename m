From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 19/36] objtool/idle: Validate __cpuidle code as noinstr
Date: Wed, 6 Jul 2022 11:46:25 +0200
Message-ID: <CAMuHMdW4pT+YQfLzLTegFu1M3v9-9vaFDFAama7mc82=x6R__w@mail.gmail.com>
References: <20220608142723.103523089@infradead.org> <20220608144517.124597382@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20220608144517.124597382@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.c

On Wed, Jun 8, 2022 at 4:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Idle code is very like entry code in that RCU isn't available. As
> such, add a little validation.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  arch/m68k/kernel/vmlinux-nommu.lds   |    1 -
>  arch/m68k/kernel/vmlinux-std.lds     |    1 -
>  arch/m68k/kernel/vmlinux-sun3.lds    |    1 -

FWIW
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert
