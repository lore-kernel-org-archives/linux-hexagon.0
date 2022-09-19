From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 09/44] cpuidle,omap3: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 16:31:42 +0200
Message-ID: <20220919143142.GA61009@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.936337959@infradead.org>
Mime-Version: 1.0
Return-path: <linux-clk-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663597905;
        bh=NkXCfQm/FLpDP/QLaoePbhdmGTT1By087FmiZ+g8tK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPr6ORIkZS1hi0mTfC3IAGOVxe5Xf0YIpXn1FG72c3gSFnG+XbcMopHgOCdZrpVuQ
         LHqUCo/2hUmO1H6LNW9r9rHA5mXGvztHGS2F3OtBjHAXIwt5oCzU5wdBmMInXf415s
         ibv233mBU12TSNxEClWBTVHK1fzjS7w3j4hbCapvOVbDE6aKKPaOgVe+365dcYYrsH
         IXd+ByoZVYWQ1bXlckcr80Mp0FHSvK1giDc4yzOoai/YCnXbUK9IDecCd6Dzc6zaZI
         kDA/PRtGSO5qjzxSvX9Ec26StLbOH1EWQlWCIdAgthIaznmMEXMje+f6NIOt73HqRu
         77PbrmkIj/BkA==
Content-Disposition: inline
In-Reply-To: <20220919101520.936337959@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:48AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then teporarily enable it
> again before going idle is daft.

That doesn't tell where those calls are.

Thanks.
