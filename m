From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/44] cpuidle,rcu: Clean up the mess
Date: Tue, 27 Sep 2022 09:31:11 +0300
Message-ID: <YzKYrx8Kd9SBYcUg@atomide.com>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20220919095939.761690562@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.be

Hi,

* Peter Zijlstra <peterz@infradead.org> [220919 10:08]:
> Hi All!
> 
> At long last, a respin of the cpuidle vs rcu cleanup patches.
> 
> v1: https://lkml.kernel.org/r/20220608142723.103523089@infradead.org
> 
> These here patches clean up the mess that is cpuidle vs rcuidle.

I just gave these a quick test and things still work for me. The old
omap3 off mode during idle still works. No more need to play the
whack the mole game with RCU-idle :) I did not test on x86, or on other
ARMs, but considering the test pretty much covered the all the
affected RCU-idle related paths, where suitable, feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
