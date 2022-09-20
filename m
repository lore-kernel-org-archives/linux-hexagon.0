From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 08/44] cpuidle,imx6: Push RCU-idle into driver
Date: Tue, 20 Sep 2022 11:01:29 +0200
Message-ID: <20220920090129.GD69891@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.869531945@infradead.org>
 <20220919142123.GE58444@lothringen>
 <YymA0yJybIWLco/v@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663664493;
        bh=r3YA3TgrnfQL0+0wV4NaVSy5szGp5VuMs1RW9pHe3lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzxE+ep+hNLQJM2Wi0FzFjxB5EPyT0bT1sF+vGvp/qqEsGDiM8Qxgt9HfL5GiqctW
         ydtwcTF95SErW/3YfT767vlGAIBPRec/9LY/xcROmCrXbpLipwDvonuxfesQbGtW0K
         3X57xI5xG+bP4GpwbyyVcFAUi7K0jN1trLi5oXpe5rIEW+jy1XgRCTH5RP3Mvq9gku
         rfLdXPEErWLn4QrMEjOjhbKqcH+8LTinoB+hUyQqojABcfM2uzy0XQr/ZQeGrr1R1B
         wc6IB4cpjEoOiXRZxqecNrqR6jTHxLhIWd7jd9chmFiCmiZeAdbQsNmvXPK/696igQ
         C+5aVtXIg3knA==
Content-Disposition: inline
In-Reply-To: <YymA0yJybIWLco/v@hirez.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Tue, Sep 20, 2022 at 10:58:59AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 19, 2022 at 04:21:23PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 19, 2022 at 11:59:47AM +0200, Peter Zijlstra wrote:
> > > Doing RCU-idle outside the driver, only to then temporarily enable it
> > > again, at least twice, before going idle is daft.
> > 
> > Hmm, what ends up calling RCU_IDLE() here? Also what about
> > cpu_do_idle()?
> 
> I've ammended patches 5-12 with a comment like:
> 
> Notably both cpu_pm_enter() and cpu_cluster_pm_enter() implicity
> re-enable RCU.
> 
> (each noting the specific sites for the relevant patch).

Thanks!
