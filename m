From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 11/44] cpuidle,omap4: Push RCU-idle into driver
Date: Tue, 20 Sep 2022 12:53:41 +0200
Message-ID: <20220920105341.GB72346@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101521.072508494@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663671224;
        bh=1uzaYeWYbymD/f+i/QytZhu6oKO9BM7m7uKIAm7/1aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwUuVl6qzzyQ8/M60E4GBJaDSvCCIGZsWXd6EWoe6ETg4UPGRSPJSpODGC89bVoml
         D8yMcp2L8SqglVlcwPjBx0kwWsmuhxSt4A6MHMYEdl8sw5Zt0+i8CPGg6TTK40x4my
         mHRIDutJuMJ3kECm4eorV/KO7XWDkJoFt5Xcko5DBOFQuad34F85DOuPGJQOkcR3nN
         x3i3rl+wBIvgbXn74nt/EudGishy0lWfyQwIhjZzzOrS/gzl1GIHezRYRweYZnMwZB
         mX8bZPz/2M6J4eYsqVrIj88f6cgWd9NcoOu5bfu6upfEe+DnQeaKeleng7SJXqBrye
         EQG2xv/JeiBzw==
Content-Disposition: inline
In-Reply-To: <20220919101521.072508494@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:50AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, some *four* times, before going idle is daft.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
