From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 15/36] cpuidle,cpu_pm: Remove RCU fiddling from
 cpu_pm_{enter,exit}()
Date: Tue, 14 Jun 2022 17:53:25 +0100
Message-ID: <Yqi9BTTnlbcUsD5c@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.871305980@infradead.org>
 <YqiznJL7qB9uSQ9c@FVFF77S0Q05N>
 <Yqi6Zp+DTm22dLB9@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Yqi6Zp+DTm22dLB9@hirez.programming.kicks-ass.net>
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, paul

On Tue, Jun 14, 2022 at 06:42:14PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 14, 2022 at 05:13:16PM +0100, Mark Rutland wrote:
> > On Wed, Jun 08, 2022 at 04:27:38PM +0200, Peter Zijlstra wrote:
> > > All callers should still have RCU enabled.
> > 
> > IIUC with that true we should be able to drop the RCU_NONIDLE() from
> > drivers/perf/arm_pmu.c, as we only needed that for an invocation via a pm
> > notifier.
> > 
> > I should be able to give that a spin on some hardware.
> > 
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/cpu_pm.c |    9 ---------
> > >  1 file changed, 9 deletions(-)
> > > 
> > > --- a/kernel/cpu_pm.c
> > > +++ b/kernel/cpu_pm.c
> > > @@ -30,16 +30,9 @@ static int cpu_pm_notify(enum cpu_pm_eve
> > >  {
> > >  	int ret;
> > >  
> > > -	/*
> > > -	 * This introduces a RCU read critical section, which could be
> > > -	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
> > > -	 * this.
> > > -	 */
> > > -	rcu_irq_enter_irqson();
> > >  	rcu_read_lock();
> > >  	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
> > >  	rcu_read_unlock();
> > > -	rcu_irq_exit_irqson();
> > 
> > To make this easier to debug, is it worth adding an assertion that RCU is
> > watching here? e.g.
> > 
> > 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> > 			 "cpu_pm_notify() used illegally from EQS");
> > 
> 
> My understanding is that rcu_read_lock() implies something along those
> lines when PROVE_RCU.

Ah, duh. Given that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
