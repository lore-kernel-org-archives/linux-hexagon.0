From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 09/44] cpuidle,omap3: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 16:43:24 +0200
Message-ID: <20220919144324.GA62117@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.936337959@infradead.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663598608;
        bh=D+NoVno96UrWEE2gn7tpItGkEKOt+jvRjziVTjece0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2RIwdWtaC1gU/c1iv3f/GeLucEzNWn7ccmc4GkJFGI8QfQfyUHofdECc2rWD4nFT
         0GaftLgfVcd1PQZdiEvRWN1bWq4LSfCyq8T7EO2jtq161kguk1vIObBbG692peFow3
         xVyXo7iCyJmHMqd+S086gL1tfeYNp+V+xCIDAmfixXqTqubgg5nU77xLOKigezj3PM
         DaLeuiIZfTliZOGY4J1mUhwhazJJvjrhlr1eHMdV/EpxzQpUfj4SYRIitJ/3QvhoFT
         kXsev9FMLepyLeGkyRUFuM4yf7vwnZr8XA/FTgCZNB/ut+W0bJKqkVzf3mVq0/5WFi
         97mYIEcc35h6A==
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
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>

Ok now with the cpu_pm_*() informations that makes sense:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
