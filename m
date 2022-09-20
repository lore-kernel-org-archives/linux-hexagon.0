From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 09/44] cpuidle,omap3: Push RCU-idle into driver
Date: Tue, 20 Sep 2022 10:39:45 +0200
Message-ID: <20220920083945.GA69891@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.936337959@infradead.org>
 <20220919143142.GA61009@lothringen>
 <YyiIaeQY8STLK0d0@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663663189;
        bh=QLZ/gLimlgPenm2mvkYzFXUkUzl2sWERNFTd7Lrn/1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfHPkPepFM7eYC1abChd5HUgbgK6NK5Ayauo2eAkkQ+CyceHVol/FwKHrD0RdQLfO
         zvLwJIz5hFTcfKysjcDoPWgnwe9DDEKNj2dGeGEO2/kIpq57wb6SpC09LCGTp41BhC
         qxQ5vAd4G1aZwL9mb4aPm0WIseAcnDPeseRWtIJM6uCN6SGJfOOrvPOzsT+VAJwBNz
         wiUajd+Ahq99S7H8TFLbbtoaLHF3PS+Az8pt1+z7xkCsVe2mpsMmqYqlwHg5cIBClI
         ExOjOWmHHdRNPqJTL8pOkUMYH9TCMDUfjtUV19S9P9aYLdb8Rxs1AEAhPOImHVP1XR
         BbrIzh74M2mzQ==
Content-Disposition: inline
In-Reply-To: <YyiIaeQY8STLK0d0@hirez.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 05:19:05PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 19, 2022 at 04:31:42PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 19, 2022 at 11:59:48AM +0200, Peter Zijlstra wrote:
> > > Doing RCU-idle outside the driver, only to then teporarily enable it
> > > again before going idle is daft.
> > 
> > That doesn't tell where those calls are.
> 
> cpu_pm_enter/exit and the power domain stuff, possibly also the clock
> domain stuff. It's all over :/
> 
> I suppose I can add a blub and copy/paste it around the various patches
> if you want.

Yes please, sorry I don't want to bother but, just for the sake of
git blame to report something useful in 5 years.

Thanks.
