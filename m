From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 06/44] cpuidle,tegra: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 16:05:27 +0200
Message-ID: <20220919140527.GC58444@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.736563806@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596331;
        bh=hqpQnG/rjRJ81hfuIK0S1DY9cC3WlcP1cwCcwyGmRYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHvlWwU9iLcICr4GA0wvbFMtZRycSkePLGuwn0Wq5plVfbx/Tii0XIdCQwikDrLjw
         8Ks+UtynxkCYfDfznCu4vxoy6lrN/1pyw4n452OCoSaGSHU6rwFAge3K0QhIyFLOSR
         JGneRdFLQ3rSxrl3hkt0tqmVBZ/aZlW7qNuV1GyRpm6KCN+WFHSxCwjpjeba7CsIOP
         Yz5MJFMiZIm1WV9KbMnzB0jGhj2MtGbU+l9tyWqJP0PDtWjbgH1Du9ac2P3Fhm8B0Z
         Kpv3AlVh+w6otMGKiyBZUitW8Nu9ZoBDlKme+nShAv6Iz6s/fxHg30/YEVxKu5MA6Y
         P0mCOXh99bXNQ==
Content-Disposition: inline
In-Reply-To: <20220919101520.736563806@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:45AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
