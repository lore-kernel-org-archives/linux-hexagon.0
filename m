From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 08/44] cpuidle,imx6: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 17:00:52 +0200
Message-ID: <YyiEJOJL5/Bq+9hK@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.869531945@infradead.org>
 <20220919142123.GE58444@lothringen>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DH0Mbf0oZaE0931sFQPw1e06bFjL/ZiWgntyEnYtHbE=; b=Z7/2OIWTtGRG+EiJo2AD3B8G8e
        7uPG4PjU1ya5bfhFJXAHwWaGx5yw3XDL0GYXbmibp9Xx25sduHU5oh8lscXaAHt5fN64/FqKymFHF
        amCjnRPyabcoX1W91yzz2iUJnazyvM6NvWfbu3sbMKkxpf4LYy7yP3/VRTVXmqTNA4AeFl2jL0Vy2
        w/TT6h3dAJgEAR/z8406ANXq2n7gYlBBWtij15zV52/laBjXxQzqTW9Chik+j9dPi1B8sPtUb8+Hh
        QuI3JQlo7zhojBg+6Huof0ss/YYYdPJCFlTmj18gUC6XE0WhO6Gna1XmcuRMnNxKLNJLIqXqZUrqv
        wdzSDrfA==;
Content-Disposition: inline
In-Reply-To: <20220919142123.GE58444@lothringen>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frederic Weisbecker <frederic@kernel.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 04:21:23PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 11:59:47AM +0200, Peter Zijlstra wrote:
> > Doing RCU-idle outside the driver, only to then temporarily enable it
> > again, at least twice, before going idle is daft.
> 
> Hmm, what ends up calling RCU_IDLE() here? Also what about
> cpu_do_idle()?

Both cpu_pm_enter() and cpu_cluster_pm_enter() use ct_irq_enter_irqson()
which is another way to spell RCU_NONIDLE().

