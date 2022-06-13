From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 34/36] cpuidle,omap3: Push RCU-idle into omap_sram_idle()
Date: Mon, 13 Jun 2022 15:35:14 +0300
Message-ID: <YqcvAmiDSOAOAdA9@atomide.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.073801916@infradead.org>
 <YqC6iJx4ygSmry0G@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <xen-devel-bounces@lists.xenproject.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
Content-Disposition: inline
In-Reply-To: <YqC6iJx4ygSmry0G@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 

* Peter Zijlstra <peterz@infradead.org> [220608 15:00]:
> On Wed, Jun 08, 2022 at 04:27:57PM +0200, Peter Zijlstra wrote:
> > @@ -254,11 +255,18 @@ void omap_sram_idle(void)
> >  	 */
> >  	if (save_state)
> >  		omap34xx_save_context(omap3_arm_context);
> > +
> > +	if (rcuidle)
> > +		cpuidle_rcu_enter();
> > +
> >  	if (save_state == 1 || save_state == 3)
> >  		cpu_suspend(save_state, omap34xx_do_sram_idle);
> >  	else
> >  		omap34xx_do_sram_idle(save_state);
> >  
> > +	if (rcuidle)
> > +		rcuidle_rcu_exit();
> 
> *sigh* so much for this having been exposed to the robots for >2 days :/

I tested your git branch of these patches, so:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>

