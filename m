From: Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: Re: [PATCH v2 07/44] cpuidle,psci: Push RCU-idle into driver
Date: Wed, 21 Sep 2022 22:51:10 +0100
Message-ID: <YyuHTgRh7t6vYjHw@e126311.manchester.arm.com>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.802976773@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20220919101520.802976773@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:46AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tried it on Pixel 6 running psci_idle, looks good with no apparent issues.

Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
