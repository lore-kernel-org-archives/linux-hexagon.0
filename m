From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 03/44] cpuidle/poll: Ensure IRQ state is invariant
Date: Tue, 20 Sep 2022 10:57:00 +0200
Message-ID: <YymAXPkZkyFIEjXM@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.534233547@infradead.org>
 <20220919131927.GA58444@lothringen>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/nDDP1N0D4CAKFG1jjZ0nUCcb4Cwi+2XeLNzAB5a/3A=; b=dwq7k7OLBAweuvxZAbsIyybjmJ
        LWKFQLhJfLLYjlWcLF1VzOmm/u3DYXUkxiGZB432qxzVGoPDa+HDV664vlFYQOwNVOgwYKQh00P/y
        2Moq5lHOrC15n7bUB20DWWFsx8XV1J1DNLnxbuCGUFWdx8geNgMfV6XhqReLWifLY+YeFodx27IXq
        /IrJ0mO09Di3qhEI4cp6g7HRbgntsbzEH8ickJuRs6Usu7AqtrURdlQsKWIMoNKkSXupoPQSsqje7
        UezmEjo7U4Z1A3DxPyeQLWaZEGErf50B+83wnXPcrPsl85uPvrl+T4DjBM0ejacsZ7Zz8oufPZrwY
        XBBt0mUA==;
Content-Disposition: inline
In-Reply-To: <20220919131927.GA58444@lothringen>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frederic Weisbecker <frederic@kernel.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

On Mon, Sep 19, 2022 at 03:19:27PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 11:59:42AM +0200, Peter Zijlstra wrote:
> > cpuidle_state::enter() methods should be IRQ invariant
> 
> Got a bit confused with the invariant thing since the first chunck I
> see in this patch is a conversion to an non-traceable local_irq_enable().
> 
> Maybe just add a short mention about that and why?

Changelog now reads:

---
Subject: cpuidle/poll: Ensure IRQ state is invariant
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue May 31 15:43:32 CEST 2022

cpuidle_state::enter() methods should be IRQ invariant.

Additionally make sure to use raw_local_irq_*() methods since this
cpuidle callback will be called with RCU already disabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
