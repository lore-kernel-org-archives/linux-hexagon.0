From: Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 07/44] cpuidle,psci: Push RCU-idle into driver
Date: Mon, 19 Sep 2022 16:11:51 +0200
Message-ID: <20220919141151.GD58444@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.802976773@infradead.org>
Mime-Version: 1.0
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596714;
        bh=jFC8Ee/B68Lt0N7gS8RRayFaddE97lbLbiTesOHxN7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzEUztO2cOw2WGBqf2psEpxOvRZWujFXNz5ZdjgSX/J4eeWt8peadleymWnVJq9yH
         miv2FuTQ3EjwDSKX3MkzxozzcAWGP1+Tn47GbA/6EOK95uuXO7VoAg5QvEO/dNmdNm
         uM6gyiWTngHj5i/4Z4zRvF+6+ClWxzmiN+yu6JnsWI4IJqhvqrR2iIxxSEoq1plzY2
         L9vaQjVUCB9xGl9OxM10M1znA53Mq55FwVxosD+eK8A/NXKEsCWXssqcS46ftjtLuN
         3597C4YqcCzPUlYbazDmbh0TuPASDcDk4+kR+qL/xPPX4Pfu/x9UK+QueTPRhI9KKc
         hgtQWNHwmsxxg==
Content-Disposition: inline
In-Reply-To: <20220919101520.802976773-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: richard.henderson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org, mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vgupta-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcain-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, chenhuacai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-f95k8chpbVdBDLzU/O5InQ@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org, paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org, palmer@dabbel

On Mon, Sep 19, 2022 at 11:59:46AM +0200, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Reviewed-by: Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
