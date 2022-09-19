From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 08/44] cpuidle,imx6: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 17:01:08 +0200
Message-ID: <YyiENIiiw0lx4z3l@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.869531945@infradead.org>
 <20220919144941.GA62211@lothringen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3DF240BAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 363BA40BA8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90F916076C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DB9B60757
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GQT9ZKmQZViLafATQeaZBpdND2gP4uRG0ahM2YMYtd8=; b=g/io43RigyyT41y2dFYusHC91i
 FN11xGh8i9tSF+EoWlo1zpG/7kAtBGSI2HmZByL4Oe8pG3bEgJ+0ROI7nYO0NOnc1TY5oprLEKNsP
 0s07QhQQGBqOQpI9GMDgINY/2CjS57svuapajwEVoK2R5yc4GAMJp+DMGuZKJlfslCqnDHrafRUiw
 jORg8zwhWlWojJALVxpQjQFiL2JzpT9CaEaqFUVxHoyqBPjNzU9yff7QlldALoQgVvDBY1b6Bykv7
 bVtAcUpYMDOJ65BerD+Uz9pEW8t4LuzSWPRPEzSY89wpLArsaujZiDHsp5Um+PEFfzZR6oEfgqVwd
 v4kzfEww==;
Content-Disposition: inline
In-Reply-To: <20220919144941.GA62211@lothringen>
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
To: Frederic Weisbecker <frederic@kernel.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <a>

On Mon, Sep 19, 2022 at 04:49:41PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 11:59:47AM +0200, Peter Zijlstra wrote:
> > Doing RCU-idle outside the driver, only to then temporarily enable it
> > again, at least twice, before going idle is daft.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/arm/mach-imx/cpuidle-imx6sx.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > @@ -47,7 +47,9 @@ static int imx6sx_enter_wait(struct cpui
> >  		cpu_pm_enter();
> >  		cpu_cluster_pm_enter();
> >  
> > +		ct_idle_enter();
> >  		cpu_suspend(0, imx6sx_idle_finish);
> > +		ct_idle_exit();
> >  
> >  		cpu_cluster_pm_exit();
> >  		cpu_pm_exit();
> > @@ -87,7 +89,8 @@ static struct cpuidle_driver imx6sx_cpui
> >  			 */
> >  			.exit_latency = 300,
> >  			.target_residency = 500,
> > -			.flags = CPUIDLE_FLAG_TIMER_STOP,
> > +			.flags = CPUIDLE_FLAG_TIMER_STOP |
> > +				 CPUIDLE_FLAG_RCU_IDLE,
> >  			.enter = imx6sx_enter_wait,
> 
> There is a second one below that also uses imx6sx_enter_wait.

Duh, thanks!
