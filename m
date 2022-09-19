From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 05/44] cpuidle,riscv: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 15:46:38 +0200
Message-ID: <20220919134638.GB58444@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.669962810@infradead.org>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663595201;
        bh=AeMivRW0JQnrwZYyjaQlcAH3jO881DUdn8V4CSVqYy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBg87/yLwMZ9eT1BeUjhxJ+7dwNsR/5RpM+ZBJJa8SG/75nIEU7j6PxxCQGGA+MCG
         fEz6jjqm0upeEknbVQVTbNNOFA3P4Fz3oLukyiPJGTLq/oF5z7C2TJlNYZklHW2vy+
         M3wAK3fuWQUEX8ycFR/BZYXlfQeGgJukXEeTXFbI1GqGvEKgiCuX1qAcCp4cb88BCr
         u9/v3lrFiAErKNSv5GYp2jo2o6Fdkh0P1QUkG7ezjC4Hr3U+qtfmMTwtOYDCqHlf3R
         IZQA8vPm0m9Bt2whXm4+0BzRLxGYNJM9CdDVmuPwVXVOXcmwjMR2yTHw4WE1qWnn2N
         OShXczUrpfuYg==
Content-Disposition: inline
In-Reply-To: <20220919101520.669962810@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:44AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
